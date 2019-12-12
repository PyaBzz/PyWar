/* ---- by Lepko ---- lepko.san@gmail.com ---- http://www.xt-net.info/ ---- */

Set_Sequence()
{
	game["gg_weaps"] = [];
	game["gg_weaps"][0] = "none";

	weapons = level.gg_weapon_sequence;
	explode = strTok( weapons, "," );

	if( explode.size > 1)
	{
		for( nn = 0 ; nn < explode.size ; nn++ )
		{
			this_weapon = explode[ nn ] + "_mp";
			
			if( Validate_Weapon( this_weapon ) )
				game["gg_weaps"][game["gg_weaps"].size] = this_weapon;
		}
	}
	else
	{
	// Pistols
		game["gg_weaps"][game["gg_weaps"].size] = "beretta_mp";
		game["gg_weaps"][game["gg_weaps"].size] = "usp_mp";
		game["gg_weaps"][game["gg_weaps"].size] = "colt45_mp";
		game["gg_weaps"][game["gg_weaps"].size] = "deserteagle_mp";
	
	// Shotguns
		game["gg_weaps"][game["gg_weaps"].size] = "winchester1200_mp";
		game["gg_weaps"][game["gg_weaps"].size] = "m1014_mp";
	
	// Smgs
		game["gg_weaps"][game["gg_weaps"].size] = "mp5_mp";
		game["gg_weaps"][game["gg_weaps"].size] = "skorpion_mp";
		game["gg_weaps"][game["gg_weaps"].size] = "uzi_mp";
		game["gg_weaps"][game["gg_weaps"].size] = "ak74u_mp";
		game["gg_weaps"][game["gg_weaps"].size] = "p90_mp";
	
	// Assault Rifles
		game["gg_weaps"][game["gg_weaps"].size] = "m16_mp";
		game["gg_weaps"][game["gg_weaps"].size] = "ak47_mp";
		game["gg_weaps"][game["gg_weaps"].size] = "m4_mp";
		game["gg_weaps"][game["gg_weaps"].size] = "g3_mp";
		game["gg_weaps"][game["gg_weaps"].size] = "g36c_mp";
		game["gg_weaps"][game["gg_weaps"].size] = "m14_mp";
		game["gg_weaps"][game["gg_weaps"].size] = "mp44_mp";
	
	// Heavy Guns
		game["gg_weaps"][game["gg_weaps"].size] = "saw_mp";
		game["gg_weaps"][game["gg_weaps"].size] = "rpd_mp";
		game["gg_weaps"][game["gg_weaps"].size] = "m60e4_mp";
	
	// Snipers
		game["gg_weaps"][game["gg_weaps"].size] = "m40a3_mp";
		game["gg_weaps"][game["gg_weaps"].size] = "m21_mp";
		game["gg_weaps"][game["gg_weaps"].size] = "dragunov_mp";
		game["gg_weaps"][game["gg_weaps"].size] = "remington700_mp";
		game["gg_weaps"][game["gg_weaps"].size] = "barrett_mp";

		game["gg_weaps"][game["gg_weaps"].size] = "frag_grenade_mp";
		game["gg_weaps"][game["gg_weaps"].size] = "knife_mp";
	/* Other
		game["gg_weaps"][game["gg_weaps"].size] = "c4_mp";
		game["gg_weaps"][game["gg_weaps"].size] = "rpg_mp";
		game["gg_weaps"][game["gg_weaps"].size] = "claymore_mp";
	*/
	}
}

//TODO: Allow attachments?
Validate_Weapon( weapon )
{
	value = false;
	
	switch ( weapon )
	{
		case "beretta_mp":
		case "usp_mp":
		case "colt45_mp":
		case "deserteagle_mp":
		case "winchester1200_mp":
		case "m1014_mp":
		case "mp5_mp":
		case "skorpion_mp":
		case "uzi_mp":
		case "ak74u_mp":
		case "p90_mp":
		case "m16_mp":
		case "ak47_mp":
		case "m4_mp":
		case "g3_mp":
		case "g36c_mp":
		case "m14_mp":
		case "mp44_mp":
		case "saw_mp":
		case "rpd_mp":
		case "m60e4_mp":
		case "m40a3_mp":
		case "m21_mp":
		case "dragunov_mp":
		case "remington700_mp":
		case "barrett_mp":
		case "c4_mp":
		case "rpg_mp":
		case "claymore_mp":
		case "frag_grenade_mp":
		case "knife_mp":
			value = true;
			break;
		default:
			value = false;
			break;
	}
	
	return value;
}

Give_New_Weapon()
{
	self TakeAllWeapons();
	self ClearPerks();
	
	mylevel = self.pers["gg_level"];
	myweapon = game["gg_weaps"][ mylevel ];
	
	if( !isDefined( myweapon ) )
		return;

	if( level.gg_second_weapon != "" && Validate_Weapon( level.gg_second_weapon+"_mp" ) )
		second_weapon = level.gg_second_weapon+"_mp";
	else
		second_weapon = "c4_mp";

	if( myweapon == "frag_grenade_mp" )
	{
		self gungame\utility::PlaySoundOnPlayers( "gg_nade_level" );

		if( isSubStr( level.gg_second_weapon_levels, "frag" ) )
			myweapon = second_weapon;
		else
		    myweapon = "c4_mp";

		ammo = int( level.gg_ammo_frag );

		if( level.gg_dont_cook_frags )
		{
			self giveWeapon( "frag_no_cook_mp" );
			self setWeaponAmmoClip( "frag_no_cook_mp", ammo );
			self switchToOffhand( "frag_no_cook_mp" );
		}
		else
		{
			self giveWeapon( "frag_grenade_mp" );
			self setWeaponAmmoClip( "frag_grenade_mp", ammo );
			self switchToOffhand( "frag_grenade_mp" );
		}

		if( myweapon == "c4_mp" )
        {
			self giveWeapon( myweapon );
        	self setWeaponAmmoClip( myweapon, 0 );
        	self setWeaponAmmoStock( myweapon, 0 );
		}
		else
		{
			self giveWeapon( myweapon );
			self giveMaxAmmo( myweapon );
		}
		self SetSpawnWeapon( myweapon );
	}
	else if( myweapon == "knife_mp" )
	{
		self gungame\utility::PlaySoundOnPlayers( "gg_knife_level" );

		if( isSubStr( level.gg_second_weapon_levels, "knife" ) )
			myweapon = second_weapon;
		else
		    myweapon = "c4_mp";

		if( myweapon == "c4_mp" )
        {
			self giveWeapon( myweapon );
        	self setWeaponAmmoClip( myweapon, 0 );
        	self setWeaponAmmoStock( myweapon, 0 );
		}
		else
		{
			self giveWeapon( myweapon );
			self giveMaxAmmo( myweapon );
		}
		self SetSpawnWeapon( myweapon );
	}
	else if( myweapon == "c4_mp" )
	{
		if( isSubStr( level.gg_second_weapon_levels, "c4" ) )
			second_weapon = second_weapon;
		else
		    second_weapon = "c4_mp";

        ammo = int( level.gg_ammo_c4 );

		if( second_weapon != "c4_mp" )
		{
			self giveWeapon( second_weapon );
			self giveMaxAmmo( second_weapon );
		}

        self giveWeapon( myweapon );
        self setWeaponAmmoClip( myweapon, ammo );
        //self setWeaponAmmoStock( myweapon, 0 );
		self SetSpawnWeapon( myweapon );
	}
	else if( myweapon == "rpg_mp" )
	{
		if( isSubStr( level.gg_second_weapon_levels, "rpg" ) )
			second_weapon = second_weapon;
		else
		    second_weapon = "c4_mp";

        ammo = int( level.gg_ammo_rpg );

        self giveWeapon( myweapon );
        self setWeaponAmmoClip( myweapon, 0 );
        self setWeaponAmmoStock( myweapon, ammo );

		if( second_weapon != "c4_mp" )
		{
			self giveWeapon( second_weapon );
			self giveMaxAmmo( second_weapon );
		}
		self SetSpawnWeapon( myweapon );
	}
	else
	{
		if( isSubStr( level.gg_second_weapon_levels, "other" ) )
			second_weapon = second_weapon;
		else
		    second_weapon = "c4_mp";

		if( second_weapon != "c4_mp" )
		{
			self giveWeapon( second_weapon );
			self giveMaxAmmo( second_weapon );
		}

		self giveWeapon( myweapon );
		self giveMaxAmmo( myweapon );
		self SetSpawnWeapon( myweapon );
	}
}

Reload_Weapon()
{
	mylevel = self.pers["gg_level"];
	myweapon = game["gg_weaps"][mylevel];
	
	if ( !self hasWeapon( myweapon ) )
	{
		if( level.gg_turbo )
			self Give_New_Weapon();

		return;
	}

	if( myweapon == "frag_grenade_mp" )
	{
        ammo = int( level.gg_ammo_frag );

		if( level.gg_dont_cook_frags )
			self setWeaponAmmoClip( "frag_no_cook_mp", ammo );
		else
			self setWeaponAmmoClip( "frag_grenade_mp", ammo );
	}
	else if( myweapon == "c4_mp" )
	{
        ammo = int( level.gg_ammo_c4 );
        self setWeaponAmmoClip( myweapon, ammo );
	}
	else if( myweapon == "rpg_mp" )
	{
        ammo = int( level.gg_ammo_rpg );
//        self setWeaponAmmoClip( myweapon, 1 );
        self setWeaponAmmoStock( myweapon, ammo );
	}
	else
	{
		self giveMaxAmmo( myweapon );
		self SetWeaponAmmoClip( myweapon, 300 );
	}
}
