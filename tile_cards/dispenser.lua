local modname = minetest.get_current_modname()

local dispenser_fs = ""
	.. "formspec_version[6]"
	.. "size[5,3,false]"
	.. "button[0,0;2,1;reset;Reset]"
	.. "button[3,0;2,1;starter;Starter]"
	.. "image_button[2,0;1,1;tile_cards_misc.png;misc;]"

local function get_dispenser_fs(pos)
	local fs = dispenser_fs
	local n = 1
	for k, v in pairs(tile_cards.player_colors) do
		fs = fs .. "image_button[" .. ((n - 1) % 5) .. "," .. math.floor((n - 1) / 5) + 1 .. ";1,1;tile_cards_color.png^[multiply:" .. v .. ";color_" .. k .. ";" .. #tile_cards.player_pieces .. ";false;false]"
		n = n + 1
	end
	return fs
end


minetest.register_node(modname .. ":dispenser", {
	description = "card dispenser",
	tiles = {"tile_cards_dispenser.png"},
	groups = {oddly_breakable_by_hand = 2},
	on_construct = function(pos)
		local deck = table.copy(tile_cards.master_deck)
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
		meta:set_string("infotext", "Cards Remaining: " .. #deck)
	end,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		clicker:get_meta():set_string("edit_pos", minetest.pos_to_string(pos))
		minetest.show_formspec(clicker:get_player_name(), modname ..":dispenser", get_dispenser_fs(pos))
	end,
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= modname .. ":dispenser" then return end
	-- minetest.chat_send_all("foo")

	if fields.reset then
		local pos = minetest.string_to_pos(player:get_meta():get("edit_pos"))
		local deck = table.copy(tile_cards.master_deck)
		local meta = minetest.get_meta(pos)
		meta:set_string("deck", minetest.serialize(deck))
		meta:set_string("infotext", "Cards Remaining: " .. #deck)
	end
	if fields.starter then
		local pos = minetest.string_to_pos(player:get_meta():get("edit_pos"))
		local meta = minetest.get_meta(pos)
		local deck = minetest.deserialize(meta:get_string("deck"))

		for k, v in pairs(deck) do
			if v == tile_cards.starter then
				player:get_inventory():add_item("main", tile_cards.starter)
				table.remove(deck, k)
			end
		end

		meta:set_string("deck", minetest.serialize(deck))
		meta:set_string("infotext", "Cards Remaining: " .. #deck)
	end
	if fields.misc then
		for k, v in pairs(tile_cards.general_pieces) do
			local itemstack = ItemStack(v)
			player:get_inventory():add_item("main", itemstack)
		end
	end
	for k, v in pairs(tile_cards.player_colors) do
		if fields["color_" .. k] then
			for s, t in pairs(tile_cards.player_pieces) do
				local itemstack = ItemStack(t)
				itemstack:get_meta():set_string("color", v)
				player:get_inventory():add_item("main", itemstack)
			end
		end
	end
	return true
end)
