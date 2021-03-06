--[[
	Myte2 Server Files
	PACHI | Tunga
	https://forum.turkmmo.com/uye/2127751-pachi/
--]]
quest mystery_key begin
	state start begin
	
		function get_master_key()
			return 50156
		end

		function get_key_for_chest(chest_vnum)
			local chest_table = {
				[50132] = 50150,
				[50133] = 50151,
				[50134] = 50152,
				[50135] = 50153,
				[50136] = 50154,
				[50137] = 50155,
			}
			return chest_table[chest_vnum]
		end
		
		function get_reward_for_chest(chest_vnum)
			local reward_table = {
				[50132] = {
					{71126, 1, 20},
					{71094, 1},
					{71085, 2},
					{70039, 2},
					{71032, 3},
					{70024, 3},
					{25040, 5},
					{71044, 7},
					{71083, 8},
					{71030, 10},
					{71027, 10},
					{71012, 12}
					
				}
			}
			return get_random_vnum_from_table(reward_table[chest_vnum])
		end

		function open_chest(chest_vnum, key_vnum)
			say(" Elmas Anahtar ile sandığı açmak ister misiniz? ")
			local s= select(" Evet, isterim. ", " Hayır, şimdi değil. ")
			if s==2 then
				return
			end
			local reward = mystery_key.get_reward_for_chest(chest_vnum)
			item.remove()
			pc.remove_item(key_vnum, 1)
			pc.give_item2(reward)
		end

		when 50132.use begin
			local key_vnum = mystery_key.get_key_for_chest(item.vnum)
			local master_key_vnum = mystery_key.get_master_key()
			say_title(item_name(item.vnum) .. ": ")
			if pc.count_item(key_vnum) >= 1 then
				mystery_key.open_chest(item.vnum, key_vnum)
			elseif pc.count_item(master_key_vnum) >= 1 then
				mystery_key.open_chest(item.vnum, master_key_vnum)
			else
				say(" Sandığın açılabilmesi için bir anahtar gerekiyor. ")
			end
		end
	end
end
