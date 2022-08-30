local modname = minetest.get_current_modname()

local warehouse_fs = ""
	.. "formspec_version[6]"
	.. "size[5,2,false]"
	.. "image_button[0,0;1,1;csn_tb_barrel.png;barrel;]"
	.. "image_button[2,0;1,1;csn_tb_wheat.png;wheat;]"
	.. "image_button[4,0;1,1;csn_tb_cloth.png;cloth;]"

local function get_warehouse_fs(pos)
	local meta = minetest.get_meta(pos)
	local fs = warehouse_fs
	fs = fs .. "label[0.45,1.5;" .. meta:get_string("barrel") .. "]"
	fs = fs .. "label[2.45,1.5;" .. meta:get_string("wheat") .. "]"
	fs = fs .. "label[4.45,1.5;" .. meta:get_string("cloth") .. "]"
	return fs
end

minetest.register_node(modname .. ":warehouse", {
	description = "Warehouse\nContains trade goods.",
	tiles = {
		"csn_tb_warehouse_top.png",
		"csn_tb_warehouse.png",
		"csn_tb_warehouse.png^csn_tb_barrel.png",
		"csn_tb_warehouse.png^csn_tb_wheat.png",
		"csn_tb_warehouse.png",
		"csn_tb_warehouse.png^csn_tb_cloth.png",
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_int("barrel", 9)
		meta:set_int("wheat", 6)
		meta:set_int("cloth", 5)
	end,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		clicker:get_meta():set_string("edit_pos", minetest.pos_to_string(pos))
		minetest.show_formspec(clicker:get_player_name(), modname ..":warehouse", get_warehouse_fs(pos))
	end,
})
tile_cards.general_pieces[#tile_cards.general_pieces + 1] = modname .. ":warehouse"

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= modname .. ":warehouse" then return end
	-- minetest.chat_send_all("foo")

	local pos = minetest.string_to_pos(player:get_meta():get("edit_pos"))
	if fields.barrel then
		local meta = minetest.get_meta(pos)
		local count = meta:get_int("barrel")
		if count > 0 then
			player:get_inventory():add_item("main", modname .. ":barrel")
			meta:set_int("barrel", count - 1)
			minetest.show_formspec(player:get_player_name(), modname ..":warehouse", get_warehouse_fs(pos))
		end
	end
	if fields.wheat then
		local meta = minetest.get_meta(pos)
		local count = meta:get_int("wheat")
		if count > 0 then
			player:get_inventory():add_item("main", modname .. ":wheat")
			meta:set_int("wheat", count - 1)
			minetest.show_formspec(player:get_player_name(), modname ..":warehouse", get_warehouse_fs(pos))
		end
	end
	if fields.cloth then
		local meta = minetest.get_meta(pos)
		local count = meta:get_int("cloth")
		if count > 0 then
			player:get_inventory():add_item("main", modname .. ":cloth")
			meta:set_int("cloth", count - 1)
			minetest.show_formspec(player:get_player_name(), modname ..":warehouse", get_warehouse_fs(pos))
		end
	end

	return true
end)
