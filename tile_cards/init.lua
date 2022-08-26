local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

tile_cards = {}
tile_cards.master_deck = {}
tile_cards.starter = ""

tile_cards.player_colors = {}
tile_cards.player_pieces = {}
tile_cards.general_pieces = {}

dofile(modpath .. "/cards.lua")
dofile(modpath .. "/pieces.lua")
dofile(modpath .. "/dispenser.lua")
