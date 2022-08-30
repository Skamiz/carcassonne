local modname = minetest.get_current_modname()

local tex = "csn_tb_pig_skin.png"
local pig_def = {
	name = modname .. ":pig",
	description = "Pig",
	inventory_image = "csn_tb_pig.png",
	y_offset = 0.5/16,
	initial_properties = {
        visual = "cube",
		visual_size = {x = 3/16, y = 1/16, z = 1/16},
        collisionbox = {-1.5/16, -0.5/16, -0.5/16, 1.5/16, 0.5/16, 0.5/16},
		textures = {tex, tex, tex .. "^[colorize:#000:40", tex .. "^[colorize:#000:40", tex .. "^[colorize:#000:20", tex .. "^[colorize:#000:20"},
    },
}

tile_cards.register_piece(pig_def)
tile_cards.player_pieces[#tile_cards.player_pieces + 1] = modname .. ":pig"


local tex = "csn_tb_builder_skin.png"
local builder_def = {
	name = modname .. ":builder",
	description = "Builder",
	inventory_image = "csn_tb_builder.png",
	y_offset = 1.5/16,
	initial_properties = {
        visual = "cube",
		visual_size = {x = 2/16, y = 3/16, z = 2/16},
        collisionbox = {-1/16, -1.5/16, -1/16, 1/16, 1.5/16, 1/16},
		textures = {tex, tex, tex .. "^[colorize:#000:40", tex .. "^[colorize:#000:40", tex .. "^[colorize:#000:20", tex .. "^[colorize:#000:20"},
    },
}

tile_cards.register_piece(builder_def)


tile_cards.player_pieces[#tile_cards.player_pieces + 1] = modname .. ":builder"
