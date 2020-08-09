/* ---- by Lepko ---- lepko.san@gmail.com ---- http://www.xt-net.info/ ---- */

Level_Up()
{
	self.pers["gg_level"]++;
	self.pers["gg_kills_this_level"] = 0;
	
	self playLocalSound( "gg_powerup" );
	
	if( level.gg_turbo )
		self gungame\weapons::Give_New_Weapon();
}

Level_Down()
{
	self.pers["gg_level"] = int( self.pers["gg_level"] - level.gg_level_down );
	self.pers["gg_kills_this_level"] = 0;

	if( self.pers["gg_level"] < 1 )
		self.pers["gg_level"] = 1;

	self playLocalSound( "gg_powerdown" );
	
	if( level.gg_turbo && isAlive( self ) )
		self gungame\weapons::Give_New_Weapon();
}

// Returns "kill", "melee", "knife", "nade" or "wrong".
Check_Weapon( attacker, sWeapon, sMeansOfDeath )
{
	attlevel = attacker.pers["gg_level"];

	if( sWeapon == game["gg_weaps"][attlevel] && sMeansOfDeath != "MOD_MELEE" )
		return "kill";

	if( game["gg_weaps"][attlevel] == "knife_mp" && sMeansOfDeath == "MOD_MELEE" )
		return "knife";

	if( game["gg_weaps"][attlevel] == "frag_grenade_mp" && sMeansOfDeath == "MOD_GRENADE_SPLASH" )
	    return "nade";

	if( sMeansOfDeath == "MOD_MELEE" )
		return "melee";

	return "wrong";
}

Check_Enough_Kills( attacker, victim )
{
	attkills = attacker.pers["gg_kills_this_level"];
	needed_kills = level.gg_kills_for_levelup;

	if( attkills >= needed_kills )
	{
		attlevel = attacker.pers["gg_level"];
		
		if( !isDefined( game["gg_weaps"][ attlevel + 1 ] ) )
			thread gungame\event::End_Game( attacker, victim );
		
		return true;
	}
	
	return false;
}

Check_Handicap()
{
	if( !isDefined(game["gg_placement"]) || !game["gg_placement"].size )
	    return;

	lastIndex = game["gg_placement"].size - 1;
	worstPlayer = game["gg_placement"][lastIndex];
	worstLevel = worstPlayer.pers["gg_level"];
	bestPlayer = game["gg_placement"][0];
	bestLevel = bestPlayer.pers["gg_level"];

	if( worstLevel > 3 )
	{
		self.pers["gg_level"] = worstLevel;
		iprintln( &"GUNGAME_HANDICAP_AUTOLEVEL", self.name, worstLevel );
	}
}

Gungame_Placement()
{
	if ( !isDefined(level.players) )
		return;

	game["gg_placement"] = [];
	
	if( !level.players.size )
	{
		map_restart(false);
		return;
	}

	for ( index = 0; index < level.players.size; index++ )
	{
		if ( level.players[index].team == "allies" || level.players[index].team == "axis" )
			game["gg_placement"][game["gg_placement"].size] = level.players[index];
	}

	gg_placement = game["gg_placement"];

	for ( i = 1; i < gg_placement.size; i++ )
	{
		player = gg_placement[i];

		for ( j = i - 1; j >= 0 && (player.pers["gg_level"] > gg_placement[j].pers["gg_level"] || (player.pers["gg_level"] == gg_placement[j].pers["gg_level"] && player.deaths < gg_placement[j].deaths)); j-- )
			gg_placement[j + 1] = gg_placement[j];

		gg_placement[j + 1] = player;
	}

	game["gg_placement"] = gg_placement;
}