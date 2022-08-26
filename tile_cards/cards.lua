-- TODO: get card margin in here
local margin = 0

function tile_cards.deck_from_tilesheet(tilesheet, card_defs)
	local modname = minetest.get_current_modname()
	local deck = {}

	for i, card in ipairs(card_defs) do

		local name = modname .. ":card_" .. i

		local x = ((i - 1) % tilesheet.width)
		local y = math.floor((i - 1) / tilesheet.width)
		local tile = tilesheet.image .. "^[sheet:" .. tilesheet.width .. "x" .. tilesheet.height .. ":" .. x .. "," .. y

		minetest.register_node(name, {
			description = card.description or "card " .. i,
			drawtype = "nodebox",
			tiles = {tile, "tile_cards_backside.png"},
			inventory_image = tile,
			paramtype = "light",
			paramtype2 = "facedir",
			groups = {oddly_breakable_by_hand = 3},
			node_box = {type = "fixed", fixed = {-(8-margin)/16, -8/16, -(8-margin)/16, (8-margin)/16, -7/16, (8-margin)/16}},
		})

		for n = 1, card.amount or 1 do
			deck[#deck + 1] = name
		end

	end

	return deck
end
