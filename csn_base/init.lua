local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

dofile(modpath .. "/cards.lua")
dofile(modpath .. "/pieces.lua")

tile_cards.starter = "carcassonne:card_25"

local colors = {
	blue = "#0062a0",
	green = "#008d49",
	yellow = "#dfc237",
	red = "#cf1a25",
	black = "#3c3b3c",
}
for k, v in pairs(colors) do
	tile_cards.player_colors[k] = v
end

minetest.register_node(modname .. ":scoreboard", {
	description = "Scoreboard",
	drawtype = "nodebox",
	visual_scale = 3.0,
	tiles = {"csn_base_scoreboard.png", "tile_cards_backside.png"},
	-- inventory_image = "carcassonne_tilesheet_base.png^[sheet:5x5:" .. ((i-1)%5) .. "," .. math.floor((i-1)/5),
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand = 2},
	node_box = {type = "fixed", fixed = {-24/(16 * 3), -8/(16 * 3), -24/(16 * 3), 24/(16 * 3), -7/(16 * 3), 24/(16 * 3)}},
	selection_box = {type = "fixed", fixed = {-24/16, -8/16, -24/16, 24/16, -7/16, 24/16}},
	collision_box = {type = "fixed", fixed = {-24/16, -8/16, -24/16, 24/16, -7/16, 24/16}},
})
