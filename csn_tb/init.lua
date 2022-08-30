local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

dofile(modpath .. "/cards.lua")
dofile(modpath .. "/pieces.lua")
dofile(modpath .. "/warehouse.lua")


minetest.register_craftitem(modname .. ":barrel", {
	description = "Barrel",
	inventory_image = "csn_tb_barrel.png",
})
minetest.register_craftitem(modname .. ":wheat", {
	description = "Wheat",
	inventory_image = "csn_tb_wheat.png",
})
minetest.register_craftitem(modname .. ":cloth", {
	description = "Cloth",
	inventory_image = "csn_tb_cloth.png",
})
