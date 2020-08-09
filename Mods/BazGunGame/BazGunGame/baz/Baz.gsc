#include baz\BazUtils;

bazOnInit()
{
	enableJumpMod = getDvarInt("baz_jumpModEnable");
	if(enableJumpMod == 1)
	{
	    jumpHeight = getDvarInt("baz_jumpModHeight");
		setDvar("jump_height", jumpHeight);
		
		enableFallDamage = getDvarInt("baz_jumpModEnableFallDamage");
		if(enableFallDamage != 1)
		{
		    setDvar("bg_fallDamageMinHeight", 9998); // Max jumpHeight is 1000
		    setDvar("bg_fallDamageMaxHeight", 9999); // Has to be higher than min value
		}
	}
}

bazOnStartGameType()
{
	expFogStartDist = getDvarInt("baz_expFogStartDist");
	expFogHalfDist = getDvarInt("baz_expFogHalfDist");
	expFogRed = getDvarFloat("baz_expFogRed");
	expFogGreen = getDvarFloat("baz_expFogGreen");
	expFogBlue = getDvarFloat("baz_expFogBlue");
	expFogTransition = getDvarFloat("baz_expFogTransition");
	setExpFog(expFogStartDist, expFogHalfDist, expFogRed, expFogGreen, expFogBlue, expFogTransition);
}

bazCallback_PlayerConnect()
{
    self bazSetClientDvars();
}

bazSetClientDvars()
{
	self setClientDvars(
		"fx_enable", getDvarInt("baz_fx_enable"),
		"r_fullbright", getDvarInt("baz_r_fullbright"),
		"player_sustainAmmo", getDvarInt("baz_player_sustainAmmo"),
		"r_fog", getDvarInt("baz_r_fog"),
		"r_drawDecals", getDvarInt("baz_r_drawDecals"),
		"r_drawSun", getDvarInt("baz_r_drawSun"),
		"r_picmip_water", getDvarInt("baz_r_picmip_water"),
		"cg_brass", getDvarInt("baz_cg_brass"),
		"com_maxFPS", getDvarInt("baz_com_maxFPS")
		);
}

bazOnSpawnPlayer()
{
    if(getDvarInt("baz_anticamp_enabled") != 0)
        self thread bazPlayerAntiCamp();

    welcome_text = getDvar("baz_welcome_text");
    
    if(welcome_text == "")
        self IprintLnBold("No Greeting!");
    else
    {
        replaced_welcome_text = string_replace( welcome_text, "<name>", self.name );
        self IprintLnBold( replaced_welcome_text );
    }
}

bazPlayerAntiCamp()
{
    self endon( "death" );
    my_camp_time = 0;
    have_i_been_warned = false;
    camp_radius = getDvarInt("baz_anticamp_camp_radius");
    camp_to_warning_time = getDvarInt("baz_anticamp_camp_to_warning_time");
    warning_to_death_time = getDvarInt("baz_anticamp_warning_to_death_time");
    warning_text = getDvar("baz_anticamp_warning_text");
    death_text = getDvar("baz_anticamp_death_text");

    while( 1 )
    {
        old_position = self.origin;
        //wait 1;
        wait 1;
        new_position = self.origin;
        distance = distance2d( old_position, new_position );

        if( distance < camp_radius )
        {
            my_camp_time++;
        }
        else
        {
            my_camp_time = 0;
            have_i_been_warned = false;
        }

        if( my_camp_time >= camp_to_warning_time && !have_i_been_warned )
        {
            self IprintLnBold( warning_text );
            have_i_been_warned = true;
        }

        if( my_camp_time >= ( camp_to_warning_time + warning_to_death_time ) && have_i_been_warned )
        {
            self IprintLnBold( death_text );
            wait 1;
            self suicide();
        }
    }
}
