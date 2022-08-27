local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

dofile(modpath .. "/cards.lua")
dofile(modpath .. "/pieces.lua")

tile_cards.player_colors["grey"] = "#aaaaaa"
