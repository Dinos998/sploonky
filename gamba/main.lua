meta = {
	name = "gamba",
	version = "0.1",
	description = "There is no description. I can't english",
	author = "Dinos998",
    online_safe = true,
}

new_shop_enter = create_sound('soundbank/wav/gamba.wav')
new_shop_nope = create_sound('soundbank/wav/lose.wav')
new_secret_a = create_sound('soundbank/wav/win.wav')
new_death_ghost = create_sound('soundbank/wav/Jhin 4.wav')
new_orb_break = create_sound('soundbank/wav/Jhin 4.wav')
cosmic_ocean_enter = create_sound("soundbank/wav/Jhin 4.wav")

orbs_destroyed_in_level = 0

set_callback(function()
	
    orbs_destroyed_in_level = 0

    local state = get_state()

    if (state.world == 8 and state.level == 5) then -- entering cosmic ocean
        local rng = math.floor(math.random() * 100)

        local range1 = 20
        local range2 = (100 - range1) / 2

        if (rng < range1) then
            cosmic_ocean_enter = create_sound("soundbank/wav/Mordekaiser_DarkStar_Kill_8.wav")
        elseif (rng < range2) then
            cosmic_ocean_enter = create_sound("soundbank/wav/Jhin_Empyrean_R_0.wav")
        else 
            cosmic_ocean_enter = create_sound("soundbank/wav/Jhin_Empyrean_R_1.wav")
        end

        local cosmic_ocean_enter_playing = cosmic_ocean_enter:play(true) -- play our own sound
        cosmic_ocean_enter_playing:set_volume(options.sfx_volume/100)
        cosmic_ocean_enter_playing:set_pause(false)
    end

end, ON.LEVEL)

-- test sounds
-- set_vanilla_sound_callback(VANILLA_SOUND.PLAYER_WHIP1, VANILLA_SOUND_CALLBACK_TYPE.STARTED, function(shop_enter) 
    -- local rng = math.floor(math.random() * 100)

    -- local range1 = 20
    -- local range2 = (100 - range1) / 2

    -- if (rng < range1) then
    --     cosmic_ocean_enter = create_sound("soundbank/wav/Mordekaiser_DarkStar_Kill_8.wav")
    -- elseif (rng < range2) then
    --     cosmic_ocean_enter = create_sound("soundbank/wav/Jhin_Empyrean_R_0.wav")
    -- else 
    --     cosmic_ocean_enter = create_sound("soundbank/wav/Jhin_Empyrean_R_1.wav")
    -- end

    -- local cosmic_ocean_enter_playing = cosmic_ocean_enter:play(true) -- play our own sound
    -- cosmic_ocean_enter_playing:set_volume(options.sfx_volume/100)
    -- cosmic_ocean_enter_playing:set_pause(false)
-- end)

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
        new_orb_break = create_sound('soundbank/wav/Jhin 1.wav')
        orbs_destroyed_in_level = orbs_destroyed_in_level + 1
    elseif orbs_destroyed_in_level == 1 then
        new_orb_break = create_sound('soundbank/wav/Jhin 2.wav')
        orbs_destroyed_in_level = orbs_destroyed_in_level + 1
    elseif orbs_destroyed_in_level == 2 then
        new_orb_break = create_sound('soundbank/wav/Jhin 3.wav')
        orbs_destroyed_in_level = orbs_destroyed_in_level + 1
    else 
        new_orb_break = create_sound('soundbank/wav/Jhin 4.wav')
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

register_option_int("sfx_volume", "sfx volume", "", 20, 16, 256)

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
				options.sfx_volume = 20
			end
		end
    end
end, ON.LOAD)







































register_option_int("x_location", "x location", "", 0, 16, 256)
register_option_int("y_location", "y location", "", 85, 16, 256)
register_option_int("opacity", "opacity", "", 75, 16, 256)
register_option_int("image_size", "image size", "", 9, 16, 256)

set_callback(function(save_ctx)
    local save_data_str = json.encode({
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

            if options.y_location == nil then
                options.y_location = 85
            end
            
            if options.x_location == nil then
                options.x_location = 0
            end

            if options.opacity == nil then
                options.opacity = 75
            end

            if options.image_size == nil then
                options.image_size = 9
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

---@param draw_ctx GuiDrawContext
set_callback(function(draw_ctx)
    
    -- don't show counter
    local inLevel = state.screen ~= SCREEN.LEVEL
    local CONotStarted = state.level < 5
    local paused = state.pause ~= 0
    if inLevel or CONotStarted or paused then
		return
	end

    -- creates images
    local unbroken = create_image('images/Cosmic_Orb_Unbroken.png')
    local broken = create_image('images/Cosmic_Orb_Broken.png')
    
    -- defines image bounds
    local leftBound = options.x_location / 100 - options.image_size / 100 * 1/2
    local upperBound = options.y_location / 100 - options.image_size / 100 * 1920/1080 / 2
    local rightBound = options.x_location / 100 + options.image_size / 100 * 1/2
    local lowerBound = options.y_location / 100 + options.image_size / 100 * 1920/1080 / 2
    local diff = options.image_size / 100

    -- set images to locations
    local orbs = {}
    if (orbs_destroyed_in_level == 0) then
        orbs[0], orbs[1], orbs[2] = unbroken, unbroken, unbroken
    elseif (orbs_destroyed_in_level == 1) then
        orbs[0], orbs[1], orbs[2] = unbroken, unbroken, broken
    elseif (orbs_destroyed_in_level == 2) then
        orbs[0], orbs[1], orbs[2] = unbroken, broken, broken
    else
        orbs[0], orbs[1], orbs[2] = broken, broken, broken
    end

    -- left image
    draw_ctx:draw_image(orbs[0], leftBound - diff, upperBound, rightBound - diff, lowerBound, 0, 0, 1, 1, rgba(255, 255, 255, math.floor(options.opacity * 2.55)))
    -- middle image
    draw_ctx:draw_image(orbs[1], leftBound, upperBound, rightBound, lowerBound, 0, 0, 1, 1, rgba(255, 255, 255, math.floor(options.opacity * 2.55)))
    -- right image
    draw_ctx:draw_image(orbs[2], leftBound + diff, upperBound, rightBound + diff, lowerBound, 0, 0, 1, 1, rgba(255, 255, 255, math.floor(options.opacity * 2.55)))
end, ON.GUIFRAME)