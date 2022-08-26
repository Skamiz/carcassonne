local modname = minetest.get_current_modname()

local function print_table(po)
	for k, v in pairs(po) do
		minetest.chat_send_all(type(k) .. " : " .. tostring(k) .. " | " .. type(v) .. " : " .. tostring(v))
	end
end

local function pointing_pos(player, distance, liquids)
	local eye_pos = player:get_pos()
    local eye_height = player:get_properties().eye_height
	local eye_offset = player:get_eye_offset()

    eye_pos.y = eye_pos.y + eye_height
	eye_pos = eye_pos + eye_offset

    local look_dir = player:get_look_dir()
    local ray_end = eye_pos + (look_dir * 5)

    local ray = minetest.raycast(eye_pos, ray_end, false, liquids)
	local next = ray:next()
    return next and next.intersection_point
end

minetest.register_entity(modname .. ":pawn", {
	initial_properties = {
        visual = "cube",
		visual_size = {x = 2/16, y = 2/16, z = 2/16},
        collisionbox = {-1/16, -1/16, -1/16, 1/16, 1/16, 1/16},
		textures = {
			"carcassonne_pawn_tile.png",
			"carcassonne_pawn_tile.png",
			"carcassonne_pawn_tile.png",
			"carcassonne_pawn_tile.png",
			"carcassonne_pawn_tile.png",
			"carcassonne_pawn_tile.png"
		},
		-- colors = {},
    },
	on_activate = function(self, staticdata, dtime_s)
		self.object:set_armor_groups({punch_operable = 1})
		if staticdata then
			self:_set_color(staticdata)
		end
	end,
    on_punch = function(self, puncher)
		local itemstack = ItemStack(modname .. ":pawn")
		itemstack:get_meta():set_string("color", self._color)
		puncher:get_inventory():add_item("main", itemstack)
		self.object:remove()
	end,
	get_staticdata = function(self)
		return self._color
	end,
    _set_color = function(self, color)
		self._color = color
		local t = "carcassonne_pawn_tile.png^[multiply:" .. color
		self.object:set_properties({textures = {t, t, t, t, t, t}})
	end,
})

-- local color_fs = ""
-- 		.. "formspec_version[6]"
-- 		.. "size[5,3,false]"
-- 		.. "field[1,1;3,0.75;color;Color;#ffffff]"

minetest.register_craftitem(modname .. ":pawn", {
	description = "Pawn",
	inventory_image = "carcassonne_pawn.png",
	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointing_pos(placer, 5, false)
		pos.y = pos.y + 1/16
		if not pos then minetest.chat_send_all("raycast is too short, yell at Skamiz to fix it") return end
		local piece = minetest.add_entity(pos, modname .. ":pawn")

		local meta = itemstack:get_meta()
		piece:get_luaentity():_set_color(meta:get("color") or "#ffffff")

		itemstack:take_item()
		return itemstack
	end,
	-- on_use = function(itemstack, user, pointed_thing)
	-- 	minetest.show_formspec(user:get_player_name(), modname ..":color", color_fs:gsub("#ffffff", itemstack:get_meta():get("color") or "#ffffff"))
	-- end,
})

-- minetest.register_on_player_receive_fields(function(player, formname, fields)
-- 	if formname ~= modname .. ":color" then return end
--
-- 	-- minetest.chat_send_all("foo")
-- 	if fields.color then
-- 		local color = fields.color
-- 		local wielded = player:get_wielded_item()
-- 		local meta = wielded:get_meta()
-- 		meta:set_string("color", color)
-- 		player:set_wielded_item(wielded)
-- 	end
-- 	return true
-- end)
