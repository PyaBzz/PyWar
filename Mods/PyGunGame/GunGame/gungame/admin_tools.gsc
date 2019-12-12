/* ---- by Lepko ---- lepko.san@gmail.com ---- http://www.xt-net.info/ ---- */

init()
{
	thread switch_team();
	thread switch_spec();
	thread set_gg_level();
}

switch_team()
{
	level endon( "game_ended" );
	
	for(;;)
	{
		setdvar("gg_switch_team", "");

		while( getdvar("gg_switch_team") == "" )
			wait .5;

		thisPlayerNum = getdvarint("gg_switch_team");
		setdvar("gg_switch_team", "");
		
		players = getentarray("player", "classname");
		for( i=0; i<players.size; i++ )
		{
			if( players[i] getEntityNumber() == thisPlayerNum && players[i].pers["team"] != "spectator" )
			{
				players[i] thread switch_me("team");
				break;
			}
		}

		wait .5;
	}
}

switch_spec()
{
	level endon( "game_ended" );

	for(;;)
	{
		setdvar("gg_switch_spec", "");

		while( getdvar("gg_switch_spec") == "" )
			wait .5;

		thisPlayerNum = getdvarint("gg_switch_spec");
		setdvar("gg_switch_spec", "");

		players = getentarray("player", "classname");
		for( i=0; i<players.size; i++ )
		{
			if( players[i] getEntityNumber() == thisPlayerNum )
			{
				players[i] thread switch_me("spec");
				break;
			}
		}

		wait .5;
	}
}

switch_me( where_to )
{
	if( where_to == "spec" && self.pers["team"] != "spectator" )
	{
		self thread maps\mp\gametypes\_globallogic::menuSpectator();
		iprintln("^6[Admin]:^7 " + self.name + " ^7was forced to spectate!");
	}
	else
	{
		if( self.pers["team"] == "axis" )
			self thread maps\mp\gametypes\_globallogic::menuAllies();
		else if( self.pers["team"] == "allies" )
			self thread maps\mp\gametypes\_globallogic::menuAxis();
        iprintln("^6[Admin]:^7 " + self.name + " ^7was forced to switch teams!");
	}
}

set_gg_level()
{
	level endon( "game_ended" );

	for(;;)
	{
		setdvar("gg_set_level", "");

		while( getdvar("gg_set_level") == "" )
			wait .5;

		tokens = strTok( getdvar("gg_set_level"), ":" );
		setdvar("gg_set_level", "");

		if( tokens.size == 2 )
		{
			players = getentarray("player", "classname");
			for( i=0; i<players.size; i++ )
			{
				if( players[i] getEntityNumber() == int( tokens[0] ) )
				{
					if( int( tokens[1] ) < game["gg_weaps"].size )
					{
						players[i].pers["gg_level"] = int( tokens[1] );
						iprintln("^6[Admin]:^7 " + players[i].name + "^7's level has beed changed to "+tokens[1]+"!");
						if( level.gg_turbo )
							players[i] gungame\weapons::Give_New_Weapon();
						players[i] thread gungame\hud::Weapon_Info();
						players[i].score = players[i].pers["gg_level"];
						players[i].pers["score"] = players[i].pers["gg_level"];
					}
					break;
				}
			}
		}
		wait .5;
	}
}
