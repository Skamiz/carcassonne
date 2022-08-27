local modname = minetest.get_current_modname()

local tex = "csn_ic_pawn_skin.png"
local def = {
	name = "strong_pawn",
	description = "Strong Pawn",
	inventory_image = "csn_ic_pawn.png",
	y_offset = 1.5/16,
	skin = "csn_base_pawn_skin.png",
	initial_properties = {
        visual = "cube",
		visual_size = {x = 3/16, y = 3/16, z = 3/16},
        collisionbox = {-1/16, -1/16, -1/16, 1/16, 1/16, 1/16},
		textures = {tex, tex, tex, tex, tex, tex},
    },
}

tile_cards.register_piece(def)


tile_cards.player_pieces[#tile_cards.player_pieces + 1] = modname .. ":strong_pawn"
