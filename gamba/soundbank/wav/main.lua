meta = {
	name = "gamba",
	version = "0.1",
	description = "There is no description. I can't english",
	author = "Dinos998",
    online_safe = true,
}

new_shop_enter = create_sound('gamba.wav')
new_shop_nope = create_sound('lose.wav')
new_secret_a = create_sound('win.wav')
new_death_ghost = create_sound('Jhin 4.wav')
new_orb_break = create_sound('Jhin 4.wav')
cosmic_ocean_enter = create_sound("Jhin 4.wav")

orbs_destroyed_in_level = 0

set_callback(function()
	
    orbs_destroyed_in_level = 0

    local state = get_state()

    if (state.world == 8 and state.level == 5) then -- entering cosmic ocean
        local rng = math.floor(math.random() * 100)

        local range1 = 20
        local range2 = (100 - range1) / 2

        if (rng < range1) then
            cosmic_ocean_enter = create_sound("Mordekaiser_DarkStar_Kill_8.wav")
        elseif (rng < range2) then
            cosmic_ocean_enter = create_sound("Jhin_Empyrean_R_0.wav")
        else 
            cosmic_ocean_enter = create_sound("Jhin_Empyrean_R_1.wav")
        end

        local cosmic_ocean_enter_playing = cosmic_ocean_enter:play(true) -- play our own sound
        cosmic_ocean_enter_playing:set_volume(options.sfx_volume/100)
        cosmic_ocean_enter_playing:set_pause(false)
    end

end, ON.LEVEL)

-- test sounds
set_vanilla_sound_callback(VANILLA_SOUND.PLAYER_WHIP1, VANILLA_SOUND_CALLBACK_TYPE.STARTED, function(shop_enter) 
    -- local rng = math.floor(math.random() * 100)

    -- local range1 = 20
    -- local range2 = (100 - range1) / 2

    -- if (rng < range1) then
    --     cosmic_ocean_enter = create_sound("Mordekaiser_DarkStar_Kill_8.wav")
    -- elseif (rng < range2) then
    --     cosmic_ocean_enter = create_sound("Jhin_Empyrean_R_0.wav")
    -- else 
    --     cosmic_ocean_enter = create_sound("Jhin_Empyrean_R_1.wav")
    -- end

    -- local cosmic_ocean_enter_playing = cosmic_ocean_enter:play(true) -- play our own sound
    -- cosmic_ocean_enter_playing:set_volume(options.sfx_volume/100)
    -- cosmic_ocean_enter_playing:set_pause(false)
end)

-- 
set_vanilla_sound_callback(VANILLA_SOUND.SHOP_SHOP_ENTER, VANILLA_SOUND_CALLBACK_TYPE.STARTED, function(shop_enter)
    shop_enter:stop()
    local new_shop_enter_playing = new_shop_enter:play(true) -- play our own sound
    new_shop_enter_playing:set_volume(options.sfx_volume * 0.8 /100)
    new_shop_enter_playing:set_pause(false)
end)

set_vanilla_sound_callback(VANILLA_SOUND.SHOP_SHOP_NOPE, VANILLA_SOUND_CALLBACK_TYPE.STARTED, function(shop_nope)
    shop_nope:stop()
    local new_shop_nope_playing = new_shop_nope:play() -- play our own sound
    new_shop_nope_playing:set_volume(options.sfx_volume * 0.8 /100)
    new_shop_nope_playing:set_pause(false)
end)

set_vanilla_sound_callback(VANILLA_SOUND.UI_SECRET, VANILLA_SOUND_CALLBACK_TYPE.STARTED, function(ui_secret_a)
    ui_secret_a:stop()
    local new_secret_a_playing = new_secret_a:play() -- play our own sound
    new_secret_a_playing:set_volume(options.sfx_volume * 0.8 /100)
    new_secret_a_playing:set_pause(false)
end)

set_vanilla_sound_callback(VANILLA_SOUND.SHARED_COSMIC_ORB_DESTROY, VANILLA_SOUND_CALLBACK_TYPE.STARTED, function(cosmic_orb_destroy)
    -- cosmic_orb_destroy:stop()
    
    if orbs_destroyed_in_level == 0 then
        new_orb_break = create_sound('Jhin 1.wav')
        orbs_destroyed_in_level = orbs_destroyed_in_level + 1
    elseif orbs_destroyed_in_level == 1 then
        new_orb_break = create_sound('Jhin 2.wav')
        orbs_destroyed_in_level = orbs_destroyed_in_level + 1
    elseif orbs_destroyed_in_level == 2 then
        new_orb_break = create_sound('Jhin 3.wav')
        orbs_destroyed_in_level = orbs_destroyed_in_level + 1
    else 
        new_orb_break = create_sound('Jhin 4.wav')
    end
    
    local new_cosmic_orb = new_orb_break:play() -- play our own sound
    new_cosmic_orb:set_volume(options.sfx_volume/100)
    new_cosmic_orb:set_pause(false)
end)

set_vanilla_sound_callback(VANILLA_SOUND.PLAYER_DEATH_GHOST, VANILLA_SOUND_CALLBACK_TYPE.STARTED, function(death_ghost)
    death_ghost:stop()
    local new_death_ghost_playing = new_death_ghost:play() -- play our own sound
    new_death_ghost_playing:set_volume(options.sfx_volume/100)
    new_death_ghost_playing:set_pause(false)
end)

register_option_int("sfx_volume", "sfx volume", "", 40, 16, 256)

set_callback(function(save_ctx)
    local save_data_str = json.encode({
		["version"] = "0.1",
		["options"] = options
	})
    save_ctx:save(save_data_str)
end, ON.SAVE)

set_callback(function(load_ctx)
    local save_data_str = load_ctx:load()
    if save_data_str ~= "" then
        local save_data = json.decode(save_data_str)
		if save_data.options then
			options = save_data.options
			if options.sfx_volume == nil then
				options.sfx_volume = 40
			end
		end
    end
end, ON.LOAD)






































-- meta = {
-- 	name = "Orb Counter",
-- 	version = "0.1",
-- 	description = "Displays how many orbs are left",
-- 	author = "fienestar",
-- 	online_safe = true,
-- }

register_option_int("font_size", "font size", "", 86, 16, 256)

set_callback(function(save_ctx)
    local save_data_str = json.encode({
		["version"] = "0.1",
		["options"] = options
	})
    save_ctx:save(save_data_str)
end, ON.SAVE)

set_callback(function(load_ctx)
    local save_data_str = load_ctx:load()
    if save_data_str ~= "" then
        local save_data = json.decode(save_data_str)
		if save_data.options then
			options = save_data.options
			if options.font_size == nil then
				options.font_size = 86
			end
		end
    end
end, ON.LOAD)

get_state = function()
	return state
end

if get_local_state then
	get_state = get_local_state
end

set_callback(function(ctx)
	local state = get_state()
	
	if state.screen ~= SCREEN.LEVEL or state.level < 5 or state.pause ~= 0 then
		return
	end

	local orb_count = tostring(orbs_destroyed_in_level)

	width32, _ = draw_text_size(options.font_size, orb_count)
	ctx:draw_text(-width32/2, 20, options.font_size, orb_count, rgba(243, 137, 215, 75))
end, ON.GUIFRAME)