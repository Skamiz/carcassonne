local modname = minetest.get_current_modname()

local tex = "csn_base_pawn_skin.png"
local def = {
	name = "pawn",
	description = "Pawn",
	inventory_image = "csn_base_pawn.png",
	y_offset = 1/16,
	skin = "csn_base_pawn_skin.png",
	initial_properties = {
        visual = "cube",
		visual_size = {x = 2/16, y = 2/16, z = 2/16},
        collisionbox = {-1/16, -1/16, -1/16, 1/16, 1/16, 1/16},
		textures = {tex, tex, tex, tex, tex, tex},
    },
}

tile_cards.register_piece(def)

for i = 1, 8 do
	tile_cards.player_pieces[#tile_cards.player_pieces + 1] = modname .. ":pawn"
end
