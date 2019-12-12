/* ---- by Lepko ---- lepko.san@gmail.com ---- http://www.xt-net.info/ ---- */

setDvarDefault( dvarName, setVal, minVal, maxVal, type )
{
	if ( getDvar( dvarName ) != "" )
	{
		if ( isString( setVal ) )
			setVal = getDvar( dvarName );
		else
		{
			if (isDefined(type) && type == "float")
				setVal = getDvarFloat( dvarName );
			else
				setVal = getDvarInt( dvarName );
		}
	}
		
	if ( isDefined( minVal ) && !isString( setVal ) )
		setVal = max( setVal, minVal );

	if ( isDefined( maxVal ) && !isString( setVal ) )
		setVal = min( setVal, maxVal );

	setDvar( dvarName, setVal );
	return setVal;
}

PlaySoundOnPlayers( sound )
{
	players = getentarray( "player", "classname" );
	for( i = 0 ; i < players.size ; i++ )
	{
		if( self != players[i] )
		{
			players[i] StopLocalSound( "gg_nade_level" );
			players[i] StopLocalSound( "gg_knife_level" );
			players[i] playLocalSound( sound );
		}
	}
}

string_replace( full, find, replace )
{
/* ---- by Lepko ---- lepko.san@gmail.com ---- http://www.xt-net.info/ ---- */
	if( !isDefined(full) )
		return "";

	if( !isString(full) || !isString(replace) || !isString(find) || find == replace || !isSubStr(full, find) )
		return full;

	return_string = "";
	replacement_count = 0;
	for( m = 0; m < full.size; m++ )
	{
		// Check all characters of a string for a first char match
		n = 0;
		if( full[m] != find[n] )
			continue;

		// Check if the whole find string matches the full's substring
		match = false;
		if( find.size > 1 )
		{
			for( n = 1; n < find.size; n++ )
			{
				if( full[m+n] != find[n] )
				{
					match = false;
					break;
				}
				else
					match = true;
			}
		}
		else
			match = true;

		// If we got a match save its position and start replacing
		if( match )
		{
			first_char = m;
			//rebuild the string before the substring that is going to be replaced
			return_string = "";
			for( r = 0; r < first_char; r++ )
				return_string += full[r];

			//add the replacing string
			return_string += replace;
			
			//rebuild the string after the substing that has been replaced
			find_lenght = find.size;
			for( r = first_char+find_lenght; r < full.size; r++ )
				return_string += full[r];

			//increase replacement count
			replacement_count++;

			//replace the full string so we can check for the next match
			full = return_string;

			//set m to 0 so that it starts the for loop over again
			m = 0;
		}
	}

	if( !replacement_count )
		return full;
	else
		return return_string;
}

Debug_Print( text )
{
	for( k = 0 ; k < 3 ; k++ )
	{
		iprintln("^1Please submit this info and when it happened");
		iprintln("^1to me @ ^5lepko.san@gmail.com:");
		iprintln( text );
		
		wait(3);
	}
}

convertWeaponName(sWeapon)
{
	if( !isDefined(sWeapon) )
		return "";

	//added by WRM for non-localised weapon names
	switch(sWeapon)
	{
		case "ak47_mp":						weapon = "AK-47";				break;
		case "ak47_acog_mp":				weapon = "AK-47 Acog";			break;
		case "ak47_gl_mp":					weapon = "AK-47 GL";			break;
		case "gl_ak47_mp":					weapon = "AK-47 GL";			break;
		case "ak47_reflex_mp":				weapon = "AK-47 Reflex";		break;
		case "ak47_silencer_mp":			weapon = "AK-47 Silenced";		break;
		case "ak74u_mp":					weapon = "AK-74u";				break;
		case "ak74u_acog_mp":				weapon = "AK-74u Acog";			break;
		case "ak74u_reflex_mp":				weapon = "AK-74u Reflex";		break;
		case "ak74u_silencer_mp":			weapon = "AK-74u Silenced";		break;
		case "aw50_acog_mp":				weapon = "AW-50 Acog";			break;
		case "aw50_mp":						weapon = "AW-50";				break;
		case "barrett_acog_mp":				weapon = ".50 Barrett Acog";	break;
		case "barrett_mp":					weapon = ".50 Barrett";			break;
		case "beretta_mp":					weapon = "Beretta";				break;
		case "beretta_silencer_mp":			weapon = "Beretta Silenced";	break;
		case "colt45_mp":					weapon = "Colt 45";				break;
		case "colt45_silencer_mp":			weapon = "Colt 45 Silenced";	break;
		case "concussion_grenade_mp":		weapon = "Concussion Grenade";	break;
		case "dragunov_acog_mp":			weapon = "Dragunov SVD Acog";	break;
		case "dragunov_mp":					weapon = "Dragunov SVD";		break;
		case "flash_grenade_mp":			weapon = "Flash Grenade";		break;
		case "frag_grenade_mp":				weapon = "Frag Grenade";		break;
		case "frag_no_cook_mp":				weapon = "Frag Grenade";		break;  // Added by Lepko
		case "frag_grenade_short_mp":		weapon = "Frag Grenade Short";	break;
		case "g3_mp":						weapon = "H&K G3";				break;
		case "g3_acog_mp":					weapon = "H&K G3 Acog";			break;
		case "g3_reflex_mp":				weapon = "H&K G3 Reflex";		break;
		case "g3_silencer_mp":				weapon = "H&K G3 Silenced";		break;
		case "g3_gl_mp":					weapon = "H&K G3 GL";			break;
		case "gl_g3_mp":					weapon = "H&K G3 GL";			break;
		case "g36c_mp":						weapon = "H&K G36C";			break;
		case "g36c_acog_mp":				weapon = "H&K G36C Acog";		break;
		case "g36c_reflex_mp":				weapon = "H&K G36C Reflex";		break;
		case "g36c_silencer_mp":			weapon = "H&K G36C Silenced";	break;
		case "g36c_gl_mp":					weapon = "H&K G36C GL";			break;
		case "gl_g36c_mp":					weapon = "H&K G36C GL";			break;
		case "m4_mp":						weapon = "5.56mm M4 Carbine";			break;
		case "m4_acog_mp":					weapon = "5.56mm M4 Carbine Acog";		break;
		case "m4_reflex_mp":				weapon = "5.56mm M4 Carbine Reflex";	break;
		case "m4_silencer_mp":				weapon = "5.56mm M4 Carbine Silenced";	break;
		case "m4_gl_mp":					weapon = "5.56mm M4 Carbine GL";		break;
		case "gl_m4_mp":					weapon = "5.56mm M4 Carbine GL";		break;
		case "m14_mp":						weapon = "7.62mm M14";			break;
		case "m14_acog_mp":					weapon = "7.62mm M14 Acog";		break;
		case "m14_reflex_mp":				weapon = "7.62mm M14 Reflex";	break;
		case "m14_silencer_mp":				weapon = "7.62mm M14 Silenced";	break;
		case "m14_gl_mp":					weapon = "7.62mm M14 GL";		break;
		case "gl_m14_mp":					weapon = "7.62mm M14 GL";		break;
		case "m16_mp":						weapon = "5.56mm M16";			break;
		case "m16_acog_mp":					weapon = "5.56mm M16 Acog";		break;
		case "m16_reflex_mp":				weapon = "5.56mm M16 Reflex";	break;
		case "m16_silencer_mp":				weapon = "5.56mm M16 Silenced";	break;
		case "m16_gl_mp":					weapon = "5.56mm M16 GL";		break;
		case "gl_m16_mp":					weapon = "5.56mm M16 GL";		break;
		case "m21_acog_mp":					weapon = "M21 Rifle Acog";		break;
		case "m21_mp":						weapon = "M21 Rifle";			break;
		case "smokegrenade_mp":				weapon = "Smoke Grenade";		break;
		case "m40a3_acog_mp":				weapon = "M40A3 Acog";			break;
		case "m40a3_mp":					weapon = "M40A3";				break;
		case "m60e4_grip_mp":				weapon = "M60E4 Grip";			break;
		case "m60e4_acog_mp":				weapon = "M60E4 Acog";			break;
		case "m60e4_mp":					weapon = "M60E4";				break;
		case "m60e4_reflex_mp":				weapon = "M60E4 Reflex";		break;
		case "m1014_grip_mp":				weapon = "M1014 Grip";			break;
		case "m1014_mp":					weapon = "M1014";				break;
		case "m1014_reflex_mp":				weapon = "M1014 Reflex";		break;
		case "mp5_acog_mp":					weapon = "H&K MP5 Acog";		break;
		case "mp5_mp":						weapon = "H&K MP5";				break;
		case "mp5_reflex_mp":				weapon = "H&K MP5 Reflex";		break;
		case "mp5_silencer_mp":				weapon = "H&K MP5 Silenced";	break;
		case "p90_acog_mp":					weapon = "FN P90 Acog";			break;
		case "p90_mp":						weapon = "FN P90";				break;
		case "p90_reflex_mp":				weapon = "FN P90 Reflex";		break;
		case "p90_silencer_mp":				weapon = "FN P90 Silenced";		break;
		case "remington700_acog_mp":		weapon = "Remington 700 Acog";	break;
		case "remington700_mp":				weapon = "Remington 700";		break;
		case "rpd_acog_mp":					weapon = "7.62mm RPD Acog";		break;
		case "rpd_mp":						weapon = "7.62mm RPD ";			break;
		case "rpd_grip_mp":					weapon = "7.62mm RPD Grip";		break;
		case "rpd_reflex_mp":				weapon = "7.62mm RPD Reflex";	break;
		case "saw_acog_mp":					weapon = "SAW Acog";			break;
		case "saw_mp":						weapon = "SAW";					break;
		case "saw_reflex_mp":				weapon = "SAW Reflex";			break;
		case "saw_grip_mp":					weapon = "SAW Grip";			break;
		case "saw_bipod_crouch_mp":			weapon = "SAW Bipod";			break;
		case "saw_bipod_prone_mp":			weapon = "SAW Bipod";			break;
		case "saw_bipod_stand_mp":			weapon = "SAW Bipod";			break;
		case "skorpion_acog_mp":			weapon = "Skorpion Acog";		break;
		case "skorpion_mp":					weapon = "Skorpion";			break;
		case "skorpion_silencer_mp":		weapon = "Skorpion Silenced";	break;
		case "skorpion_reflex_mp":			weapon = "Skorpion Reflex";		break;
		case "usp_mp":						weapon = "USP";					break;
		case "usp_silencer_mp":				weapon = "USP Silenced";		break;
		case "uzi_acog_mp":					weapon = "UZI Acog";			break;
		case "uzi_mp":						weapon = "UZI";					break;
		case "uzi_reflex_mp":				weapon = "UZI Reflex";			break;
		case "uzi_silencer_mp":				weapon = "UZI Silenced";		break;
		case "deserteaglegold_mp":			weapon = "Desert Eagle";		break;
		case "deserteagle_mp":				weapon = "Desert Eagle";		break;
		case "winchester1200_grip_mp":		weapon = "Winchester 1200 Grip";	break;
		case "winchester1200_reflex_mp":	weapon = "Winchester 1200 Reflex";	break;
		case "winchester1200_mp":			weapon = "Winchester 1200";			break;
		case "MOD_EXPLOSIVE":				weapon = "explosion";			break;
		case "MOD_WATER":					weapon = "drowning";			break;
		case "MOD_TRIGGER_HURT":			weapon = "environment";			break;
		case "MOD_MELEE":					weapon = "knife";				break;
		case "MOD_ARTILLERY":				weapon = "artillery";			break;
		// Added by Lepko:
		case "mp44_mp":						weapon = "MP44";				break;
		case "c4_mp":						weapon = "C4 Explosive";		break;
		case "rpg_mp":						weapon = "RPG";					break;
		case "knife_mp":					weapon = "Knife";				break;
		// End Lepko
		default:							weapon = sWeapon;				break;
	}

	return weapon;
}

GetMapName( map )
{
	switch( map )
	{
		case "mp_backlot":		mapname = "Backlot";		break;
		case "mp_bloc":			mapname = "Bloc";			break;
		case "mp_bog":			mapname = "Bog";			break;
		case "mp_countdown":	mapname = "Countdown";		break;
		case "mp_cargoship":	mapname = "Wet Work";		break;
		case "mp_citystreets":	mapname = "District";		break;
		case "mp_convoy":		mapname = "Ambush";			break;
		case "mp_crash":		mapname = "Crash";			break;
		case "mp_crash_snow":	mapname = "Winter Crash";	break;
		case "mp_crossfire":	mapname = "Crossfire";		break;
		case "mp_farm":			mapname = "Downpour";		break;
		case "mp_overgrown":	mapname = "Overgrown";		break;
		case "mp_pipeline":		mapname = "Pipeline";		break;
		case "mp_shipment":		mapname = "Shipment";		break;
		case "mp_showdown":		mapname = "Showdown";		break;
		case "mp_strike":		mapname = "Strike";			break;
		case "mp_vacant":		mapname = "Vacant";			break;
		case "mp_subway":		mapname = "Subway";			break;

		default:				mapname = map;				break;
	}

	return mapname;
}

doStuff_all( msg, snd, clr, plr )
{
	players = getentarray( "player", "classname" );
	for( i = 0 ; i < players.size ; i++ )
	{
		if( self != players[i] )
			players[i] thread doStuff( msg, snd, clr, plr );
	}
}

doStuff( msg, snd, clr, plr )
{
	if( !isDefined( clr ) )		clr = ( 1, 1, 1 );
	else if( clr == "white" )   clr = ( 1, 1, 1 );
	else if( clr == "red" )     clr = ( 1, 0, 0 );
	else if( clr == "green" )   clr = ( 0, 1, 0 );
	else if( clr == "blue" )    clr = ( 0, 0, 1 );
	else if( clr == "black" )   clr = ( 0, 0, 0 );
	else if( clr == "cyan" )    clr = ( 0, 1, 1 );
	else if( clr == "magenta" ) clr = ( 1, 0, 1 );
	else if( clr == "yellow" )  clr = ( 1, 1, 0 );

	stuff = spawnstruct();;
	stuff.msg = msg;
	stuff.snd = snd;
	stuff.clr = clr;
	stuff.plr = plr;

	self thread doStuff_orQueue( stuff );
}

doStuff_orQueue( stuff )
{
	self endon("disconnect");

	if( self.doingStuff )
	{
		self.doStuffQueue[self.doStuffQueue.size] = stuff;
		return;
	}

	self.doingStuff = true;

	self.doStuffText.horzAlign = "center";
	self.doStuffText.vertAlign = "middle";
	self.doStuffText.alignY = "middle";
	self.doStuffText.alignX = "center";
	self.doStuffText.x = 0;
	self.doStuffText.y = 100;
	self.doStuffText.fontscale = 1.6;
	self.doStuffText.font = "objective";
	self.doStuffText setPulseFX( 40, 5000, 1000 );
	self.doStuffText.glowColor = stuff.clr;
	self.doStuffText.glowAlpha = 1;
	self.doStuffText.alpha = 1;

	if(isDefined(stuff.msg))
		self.doStuffText.label = stuff.msg;

	if(isDefined(stuff.plr))
		self.doStuffText setPlayerNameString( stuff.plr );
	else
		self.doStuffText setText( &"NULL_EMPTY" );
	
	if(isDefined(stuff.snd))
		self playLocalSound(stuff.snd);

	wait 1.5;

	self.doingStuff = false;

	if(self.doStuffQueue.size > 0)
	{
		stuff = self.doStuffQueue[0];

		for (i=1;i<self.doStuffQueue.size;i++)
			self.doStuffQueue[i-1] = self.doStuffQueue[i];
		self.doStuffQueue[i-1] = undefined;

		self thread doStuff_orQueue( stuff );
	}
}

deletePlacedEntity(entity)
{
	entities = getentarray(entity, "classname");
	for(i = 0; i < entities.size; i++)
		entities[i] delete();
}