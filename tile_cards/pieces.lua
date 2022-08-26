

function tile_cards.pointed_pos(player, distance, liquids)
	local eye_pos = player:get_pos()
    local eye_height = player:get_properties().eye_height
	local eye_offset = player:get_eye_offset()

    eye_pos.y = eye_pos.y + eye_height
	eye_pos = eye_pos + eye_offset

    local look_dir = player:get_look_dir()
    local ray_end = eye_pos + (look_dir * (distance or 5))

    local ray = minetest.raycast(eye_pos, ray_end, false, liquids)
	local next = ray:next()
    return next and next.intersection_point
end

function tile_cards.register_piece(def)
	local modname = minetest.get_current_modname()
	local name = modname .. ":" .. def.name

	minetest.register_craftitem(name, {
		description = def.description,
		inventory_image = def.inventory_image,
		on_place = function(itemstack, placer, pointed_thing)
			local pos = tile_cards.pointed_pos(placer, 5, false)
			pos.y = pos.y + def.y_offset
			if not pos then minetest.chat_send_all("raycast is too short, yell at Skamiz to fix it") return end
			local piece = minetest.add_entity(pos, name)

			local meta = itemstack:get_meta()
			piece:get_luaentity():_set_color(meta:get("color") or "#ffffff")

			itemstack:take_item()
			return itemstack
		end,
	})

	local tex = def.skin

	minetest.register_entity(name, {
		initial_properties = def.initial_properties,
		on_activate = function(self, staticdata, dtime_s)
			self.object:set_armor_groups({punch_operable = 1})
			if staticdata then
				self:_set_color(staticdata)
			end
		end,
	    on_punch = function(self, puncher)
			local itemstack = ItemStack(name)
			itemstack:get_meta():set_string("color", self._color)
			puncher:get_inventory():add_item("main", itemstack)
			self.object:remove()
		end,
		get_staticdata = function(self)
			return self._color
		end,
	    _set_color = function(self, color)
			self._color = color
			local textures = table.copy(def.initial_properties.textures)
			for k, texture in pairs(textures) do
				textures[k] = texture .. "^[multiply:" .. color
			end
			self.object:set_properties({textures = textures})
		end,
	})

end
