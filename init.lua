local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

local cards = dofile(modpath .. "/cards.lua")
dofile(modpath .. "/pieces.lua")
dofile(modpath .. "/dispenser.lua")

local margin = 0

local starter = "carcassonne:card_25"
local colors = {
	blue = "#0062a0",
	green = "#008d49",
	yellow = "#dfc237",
	red = "#cf1a25",
	black = "#3c3b3c",
}
local full_deck = {}

for i, card in ipairs(cards) do
	minetest.register_node(modname .. ":card_" .. i, {
		description = card.description,
		drawtype = "nodebox",
		tiles = {"carcassonne_tilesheet_base.png^[sheet:5x5:" .. ((i-1)%5) .. "," .. math.floor((i-1)/5), "carcassonne_card_back.png"},
		inventory_image = "carcassonne_tilesheet_base.png^[sheet:5x5:" .. ((i-1)%5) .. "," .. math.floor((i-1)/5),
		-- tiles = {"carcassonne_card_" .. i .. ".png", "carcassonne_card_back.png"},
		-- inventory_image = "carcassonne_card_" .. i .. ".png",
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {oddly_breakable_by_hand = 3},
		node_box = {type = "fixed", fixed = {-(8-margin)/16, -8/16, -(8-margin)/16, (8-margin)/16, -7/16, (8-margin)/16}},
	})
	for n = 1, card.amount do
		full_deck[#full_deck + 1] = modname .. ":card_" .. i
	end
end

local dispenser_fs = ""
	.. "formspec_version[6]"
	.. "size[5,3,false]"
	.. "button[0,0;2,1;reset;Reset]"
	.. "button[3,0;2,1;starter;Starter]"
	local n = 0
	for k, v in pairs(colors) do
		dispenser_fs = dispenser_fs .. "image_button[" .. n .. ",2;1,1;carcassonne_pawn.png^[multiply:" .. v .. ";color_" .. k .. ";8]"
		n = n + 1
	end
minetest.register_node(modname .. ":dispneser", {
	description = "card dispenser",
	tiles = {"carcassonne_dispenser.png"},
	groups = {oddly_breakable_by_hand = 2},
	on_construct = function(pos)
		local deck = table.copy(full_deck)
		local meta = minetest.get_meta(pos)
		meta:set_string("deck", minetest.serialize(deck))
		meta:set_string("infotext", "cards Remaining: " .. #deck)
	end,
	on_punch = function(pos, node, puncher, pointed_thing)
		local meta = minetest.get_meta(pos)
		local deck = minetest.deserialize(meta:get_string("deck"))
		if #deck == 0 then minetest.chat_send_all("Out of cards.") return end
		local r = math.random(#deck)
		puncher:get_inventory():add_item("main", deck[r])
		table.remove(deck, r)
		meta:set_string("deck", minetest.serialize(deck))
		meta:set_string("infotext", "cards Remaining: " .. #deck)
	end,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		clicker:get_meta():set_string("edit_pos", minetest.pos_to_string(pos))
		minetest.show_formspec(clicker:get_player_name(), modname ..":dispenser", dispenser_fs)
	end,
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= modname .. ":dispenser" then return end
	-- minetest.chat_send_all("foo")

	if fields.reset then
		local pos = minetest.string_to_pos(player:get_meta():get("edit_pos"))
		local deck = table.copy(full_deck)
		local meta = minetest.get_meta(pos)
		meta:set_string("deck", minetest.serialize(deck))
		meta:set_string("infotext", "cards Remaining: " .. #deck)
	end
	if fields.starter then
		local pos = minetest.string_to_pos(player:get_meta():get("edit_pos"))
		local meta = minetest.get_meta(pos)
		local deck = minetest.deserialize(meta:get_string("deck"))

		for k, v in pairs(deck) do
			if v == starter then
				player:get_inventory():add_item("main", starter)
				table.remove(deck, k)
			end
		end

		meta:set_string("deck", minetest.serialize(deck))
		meta:set_string("infotext", "cards Remaining: " .. #deck)
	end
	for k, v in pairs(colors) do
		if fields["color_" .. k] then
			local itemstack = ItemStack(modname .. ":pawn 8")
			itemstack:get_meta():set_string("color", v)
			player:get_inventory():add_item("main", itemstack)
		end
	end
	return true
end)
