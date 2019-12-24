/* ---- by Lepko ---- lepko.san@gmail.com ---- http://www.xt-net.info/ ---- */

/* --- --- --- --- --- --- --- --- --- -- --- --- --- --- --- --- --- --- --- */
/* --- --- Server Info HUD : When a player connects this is displayed --- --- */
/* --- --- --- --- --- --- --- --- --- -- --- --- --- --- --- --- --- --- --- */
/*Server_Info()
{
	self endon( "disconnect" );
	self waittill( "spawned_player" );

	// - GunGame Version Info -
	if( isdefined( self.gg_Hud_Server_Info_Line1 ) )	self.gg_Hud_Server_Info_Line1 destroy();
	self.gg_Hud_Server_Info_Line1 = newClientHudElem( self );
	self.gg_Hud_Server_Info_Line1.x = -240;
	self.gg_Hud_Server_Info_Line1.y = 145;
	self.gg_Hud_Server_Info_Line1.horzAlign = "right";
	self.gg_Hud_Server_Info_Line1.vertAlign = "top";
	self.gg_Hud_Server_Info_Line1.alignX = "left";
	self.gg_Hud_Server_Info_Line1.alignY = "middle";
	self.gg_Hud_Server_Info_Line1.fontScale = 1.4;
	self.gg_Hud_Server_Info_Line1.font = "default";
	self.gg_Hud_Server_Info_Line1.color = (1, 1, 1);
	self.gg_Hud_Server_Info_Line1.hidewheninmenu = true;
	self.gg_Hud_Server_Info_Line1 setText( &"GUNGAME_VERSION_INFO" );

	// - Custom lines that depend on server settings -
	num_lines = 0;
	if( level.gg_knife_pro )
	{
		if( isdefined( self.gg_Hud_Server_Info_Line2 ) )	self.gg_Hud_Server_Info_Line2 destroy();
		self.gg_Hud_Server_Info_Line2 = newClientHudElem( self );
		self.gg_Hud_Server_Info_Line2.x = -240;
		self.gg_Hud_Server_Info_Line2.y = 175;
		self.gg_Hud_Server_Info_Line2.horzAlign = "right";
		self.gg_Hud_Server_Info_Line2.vertAlign = "top";
		self.gg_Hud_Server_Info_Line2.alignX = "left";
		self.gg_Hud_Server_Info_Line2.alignY = "middle";
		self.gg_Hud_Server_Info_Line2.fontScale = 1.4;
		self.gg_Hud_Server_Info_Line2.font = "default";
		self.gg_Hud_Server_Info_Line2.color = (0, 1, 0);
		self.gg_Hud_Server_Info_Line2.hidewheninmenu = true;
		self.gg_Hud_Server_Info_Line2 setText( &"GUNGAME_KNIFE_PRO_ENABLED" );

		num_lines++;
	}

	if( level.gg_turbo )
	{
		if( isdefined( self.gg_Hud_Server_Info_Line3 ) )	self.gg_Hud_Server_Info_Line3 destroy();
		self.gg_Hud_Server_Info_Line3 = newClientHudElem( self );
		self.gg_Hud_Server_Info_Line3.x = -240;
		self.gg_Hud_Server_Info_Line3.y = 175 + (num_lines * 15);
		self.gg_Hud_Server_Info_Line3.horzAlign = "right";
		self.gg_Hud_Server_Info_Line3.vertAlign = "top";
		self.gg_Hud_Server_Info_Line3.alignX = "left";
		self.gg_Hud_Server_Info_Line3.alignY = "middle";
		self.gg_Hud_Server_Info_Line3.fontScale = 1.4;
		self.gg_Hud_Server_Info_Line3.font = "default";
		self.gg_Hud_Server_Info_Line3.color = (0, 1, 0);
		self.gg_Hud_Server_Info_Line3.hidewheninmenu = true;
		self.gg_Hud_Server_Info_Line3 setText( &"GUNGAME_TURBO_ENABLED" );

		num_lines++;
	}

	if( level.gg_health_regen_time == 0 )
	{
		if( isdefined( self.gg_Hud_Server_Info_Line4 ) )	self.gg_Hud_Server_Info_Line4 destroy();
		self.gg_Hud_Server_Info_Line4 = newClientHudElem( self );
		self.gg_Hud_Server_Info_Line4.x = -240;
		self.gg_Hud_Server_Info_Line4.y = 175 + (num_lines * 15);
		self.gg_Hud_Server_Info_Line4.horzAlign = "right";
		self.gg_Hud_Server_Info_Line4.vertAlign = "top";
		self.gg_Hud_Server_Info_Line4.alignX = "left";
		self.gg_Hud_Server_Info_Line4.alignY = "middle";
		self.gg_Hud_Server_Info_Line4.fontScale = 1.4;
		self.gg_Hud_Server_Info_Line4.font = "default";
		self.gg_Hud_Server_Info_Line4.color = (1, 0, 0);
		self.gg_Hud_Server_Info_Line4.hidewheninmenu = true;
		self.gg_Hud_Server_Info_Line4 setText( &"GUNGAME_HEALTH_REGEN_DISABLED" );

		num_lines++;
	}
	// - End Custom Lines -

	if( isdefined( self.gg_Hud_Server_Info_Line5 ) )	self.gg_Hud_Server_Info_Line5 destroy();
	self.gg_Hud_Server_Info_Line5 = newClientHudElem( self );
	self.gg_Hud_Server_Info_Line5.x = -240;

	if( !num_lines )	self.gg_Hud_Server_Info_Line5.y = 175;
	else				self.gg_Hud_Server_Info_Line5.y = 190 + (num_lines * 15);

	self.gg_Hud_Server_Info_Line5.horzAlign = "right";
	self.gg_Hud_Server_Info_Line5.vertAlign = "top";
	self.gg_Hud_Server_Info_Line5.alignX = "left";
	self.gg_Hud_Server_Info_Line5.alignY = "middle";
	self.gg_Hud_Server_Info_Line5.fontScale = 1.4;
	self.gg_Hud_Server_Info_Line5.font = "default";
	self.gg_Hud_Server_Info_Line5.color = (1, 1, 1);
	self.gg_Hud_Server_Info_Line5.hidewheninmenu = true;
	self.gg_Hud_Server_Info_Line5 setText( &"GUNGAME_PRESS_FOR_MORE_INFO" );


	// - Hud BackGround	-
	if( isdefined( self.gg_Hud_Server_Info ) )	self.gg_Hud_Server_Info destroy();
	self.gg_Hud_Server_Info = newClientHudElem( self );
	self.gg_Hud_Server_Info.x = -250;
	self.gg_Hud_Server_Info.y = 130;
	self.gg_Hud_Server_Info.horzAlign = "right";
	self.gg_Hud_Server_Info.vertAlign = "top";
	self.gg_Hud_Server_Info.alignX = "left";
	self.gg_Hud_Server_Info.alignY = "top";
	self.gg_Hud_Server_Info.xOffset = 0;
	self.gg_Hud_Server_Info.yOffset = 0;
	self.gg_Hud_Server_Info.sort = -1;

	if( !num_lines )	height = 60;
	else				height = 15 + (num_lines * 15) + 60; // box spacing + 15 x number of lines + 4x15=60 for other 4 lines

	self.gg_Hud_Server_Info setShader( "black", 240, height );
	self.gg_Hud_Server_Info.alpha = .4;
	self.gg_Hud_Server_Info.hidden = false;
	self.gg_Hud_Server_Info.hidewheninmenu = true;

	wait ( 7 );

	self thread Fade_And_Destroy( self.gg_Hud_Server_Info, 1 );
	self thread Fade_And_Destroy( self.gg_Hud_Server_Info_Line1, 1 );
	self thread Fade_And_Destroy( self.gg_Hud_Server_Info_Line2, 1 );
	self thread Fade_And_Destroy( self.gg_Hud_Server_Info_Line3, 1 );
	self thread Fade_And_Destroy( self.gg_Hud_Server_Info_Line4, 1 );
	self thread Fade_And_Destroy( self.gg_Hud_Server_Info_Line5, 1 );
}*/
/* --- --- --- --- --- --- --- --- --- -- --- --- --- --- --- --- --- --- --- */
/* --- --- Server Info HUD : End Code --- --- --- --- --- --- --- --- --- --- */
/* --- --- --- --- --- --- --- --- --- -- --- --- --- --- --- --- --- --- --- */


/* --- --- --- --- --- --- --- --- --- -- --- --- --- --- --- --- --- --- --- */
/* - Game Info HUD : This displays game info (leader, current weapon, level)- */
/* --- --- --- --- to a player when he presses bash + use button for 1 secs - */
/* --- --- --- --- --- --- --- --- --- -- --- --- --- --- --- --- --- --- --- */
Game_Info_Wait()
{
	level endon( "game_ended" );
	self endon( "disconnect" );
	
	for(;;)
	{
		while( !self meleeButtonPressed() || !self useButtonPressed() )
			wait( 0.05 );

		wait( 0.5 );
		if( !self meleeButtonPressed() || !self useButtonPressed() )
			continue;

		self thread Game_Info_Show( 7 );
		self waittill( "gg_gameinfo" );
	}
}

Game_Info_Show( time )
{
	self endon( "disconnect" );

	// Setup Hud
	self Game_Info_Setup();
	// Set Text
	self Game_Info_Text();

	// Fade In
	self.gg_Hud_Game_Info fadeOverTime(.3);
	self.gg_Hud_Game_Info.alpha = .4;
	self.gg_Hud_Leader fadeOverTime(.3);
	self.gg_Hud_Leader.alpha = 1;
	self.gg_Hud_LeaderLevel fadeOverTime(.3);
	self.gg_Hud_LeaderLevel.alpha = 1;
	self.gg_Hud_Behind_Leader fadeOverTime(.3);
	self.gg_Hud_Behind_Leader.alpha = 1;
	self.gg_Hud_On_Level fadeOverTime(.3);
	self.gg_Hud_On_Level.alpha = 1;
	self.gg_Hud_Weapon fadeOverTime(.3);
	self.gg_Hud_Weapon.alpha = 1;
	self.gg_Hud_Kills fadeOverTime(.3);
	self.gg_Hud_Kills.alpha = 1;
	self.gg_Hud_Wins fadeOverTime(.3);
	self.gg_Hud_Wins.alpha = 1;

	// Wait
	wait time;

	// Fade Out
	self.gg_Hud_Game_Info fadeOverTime(1);
	self.gg_Hud_Game_Info.alpha = 0;
	self.gg_Hud_Leader fadeOverTime(1);
	self.gg_Hud_Leader.alpha = 0;
	self.gg_Hud_LeaderLevel fadeOverTime(1);
	self.gg_Hud_LeaderLevel.alpha = 0;
	self.gg_Hud_Behind_Leader fadeOverTime(1);
	self.gg_Hud_Behind_Leader.alpha = 0;
	self.gg_Hud_On_Level fadeOverTime(1);
	self.gg_Hud_On_Level.alpha = 0;
	self.gg_Hud_Weapon fadeOverTime(1);
	self.gg_Hud_Weapon.alpha = 0;
	self.gg_Hud_Kills fadeOverTime(1);
	self.gg_Hud_Kills.alpha = 0;
	self.gg_Hud_Wins fadeOverTime(1);
	self.gg_Hud_Wins.alpha = 0;
	wait 1;

	// Destroy
	self.gg_Hud_Game_Info destroy();
	self.gg_Hud_Leader destroy();
	self.gg_Hud_LeaderLevel destroy();
	self.gg_Hud_Behind_Leader destroy();
	self.gg_Hud_On_Level destroy();
	self.gg_Hud_Weapon destroy();
	self.gg_Hud_Kills destroy();
	self.gg_Hud_Wins destroy();
	
	self notify( "gg_gameinfo" );
}

Game_Info_Setup()
{
	if( isdefined( self.gg_Hud_Leader ) )	self.gg_Hud_Leader destroy();
	self.gg_Hud_Leader = newClientHudElem( self );
	self.gg_Hud_Leader.x = 20;
	self.gg_Hud_Leader.y = 145;
	self.gg_Hud_Leader.horzAlign = "left";
	self.gg_Hud_Leader.vertAlign = "top";
	self.gg_Hud_Leader.alignX = "left";
	self.gg_Hud_Leader.alignY = "middle";
	self.gg_Hud_Leader.fontScale = 1.4;
	self.gg_Hud_Leader.font = "default";
	self.gg_Hud_Leader.color = (1, 1, 1);
	self.gg_Hud_Leader.hidewheninmenu = false;
	self.gg_Hud_Leader.alpha = 0;

	if( isdefined( self.gg_Hud_LeaderLevel ) )	self.gg_Hud_LeaderLevel destroy();
	self.gg_Hud_LeaderLevel = newClientHudElem( self );
	self.gg_Hud_LeaderLevel.x = 20+155;
	self.gg_Hud_LeaderLevel.y = 145;
	self.gg_Hud_LeaderLevel.horzAlign = "left";
	self.gg_Hud_LeaderLevel.vertAlign = "top";
	self.gg_Hud_LeaderLevel.alignX = "left";
	self.gg_Hud_LeaderLevel.alignY = "middle";
	self.gg_Hud_LeaderLevel.fontScale = 1.4;
	self.gg_Hud_LeaderLevel.font = "default";
	self.gg_Hud_LeaderLevel.color = (1, 1, 1);
	self.gg_Hud_LeaderLevel.hidewheninmenu = false;
	self.gg_Hud_LeaderLevel.alpha = 0;

	if( isdefined( self.gg_Hud_Behind_Leader ) )	self.gg_Hud_Behind_Leader destroy();
	self.gg_Hud_Behind_Leader = newClientHudElem( self );
	self.gg_Hud_Behind_Leader.x = 20;
	self.gg_Hud_Behind_Leader.y = 160;
	self.gg_Hud_Behind_Leader.horzAlign = "left";
	self.gg_Hud_Behind_Leader.vertAlign = "top";
	self.gg_Hud_Behind_Leader.alignX = "left";
	self.gg_Hud_Behind_Leader.alignY = "middle";
	self.gg_Hud_Behind_Leader.fontScale = 1.4;
	self.gg_Hud_Behind_Leader.font = "default";
	self.gg_Hud_Behind_Leader.color = (1, 1, 1);
	self.gg_Hud_Behind_Leader.hidewheninmenu = false;
	self.gg_Hud_Behind_Leader.alpha = 0;

	if( isdefined( self.gg_Hud_On_Level ) )	self.gg_Hud_On_Level destroy();
	self.gg_Hud_On_Level = newClientHudElem( self );
	self.gg_Hud_On_Level.x = 20;
	self.gg_Hud_On_Level.y = 175;
	self.gg_Hud_On_Level.horzAlign = "left";
	self.gg_Hud_On_Level.vertAlign = "top";
	self.gg_Hud_On_Level.alignX = "left";
	self.gg_Hud_On_Level.alignY = "middle";
	self.gg_Hud_On_Level.fontScale = 1.4;
	self.gg_Hud_On_Level.font = "default";
	self.gg_Hud_On_Level.color = (1, 1, 1);
	self.gg_Hud_On_Level.hidewheninmenu = false;
	self.gg_Hud_On_Level.alpha = 0;

	if( isdefined( self.gg_Hud_Weapon ) )	self.gg_Hud_Weapon destroy();
	self.gg_Hud_Weapon = newClientHudElem( self );
	self.gg_Hud_Weapon.x = 20;
	self.gg_Hud_Weapon.y = 190;
	self.gg_Hud_Weapon.horzAlign = "left";
	self.gg_Hud_Weapon.vertAlign = "top";
	self.gg_Hud_Weapon.alignX = "left";
	self.gg_Hud_Weapon.alignY = "middle";
	self.gg_Hud_Weapon.fontScale = 1.4;
	self.gg_Hud_Weapon.font = "default";
	self.gg_Hud_Weapon.color = (1, 1, 1);
	self.gg_Hud_Weapon.hidewheninmenu = false;
	self.gg_Hud_Weapon.alpha = 0;

	if( isdefined( self.gg_Hud_Kills ) )	self.gg_Hud_Kills destroy();
	self.gg_Hud_Kills = newClientHudElem( self );
	self.gg_Hud_Kills.x = 20;
	self.gg_Hud_Kills.y = 205;
	self.gg_Hud_Kills.horzAlign = "left";
	self.gg_Hud_Kills.vertAlign = "top";
	self.gg_Hud_Kills.alignX = "left";
	self.gg_Hud_Kills.alignY = "middle";
	self.gg_Hud_Kills.fontScale = 1.4;
	self.gg_Hud_Kills.font = "default";
	self.gg_Hud_Kills.color = (1, 1, 1);
	self.gg_Hud_Kills.hidewheninmenu = false;
	self.gg_Hud_Kills.alpha = 0;

	if( isdefined( self.gg_Hud_Wins ) )	self.gg_Hud_Wins destroy();
	self.gg_Hud_Wins = newClientHudElem( self );
	self.gg_Hud_Wins.x = 20;
	self.gg_Hud_Wins.y = 220;
	self.gg_Hud_Wins.horzAlign = "left";
	self.gg_Hud_Wins.vertAlign = "top";
	self.gg_Hud_Wins.alignX = "left";
	self.gg_Hud_Wins.alignY = "middle";
	self.gg_Hud_Wins.fontScale = 1.4;
	self.gg_Hud_Wins.font = "default";
	self.gg_Hud_Wins.color = (1, 1, 1);
	self.gg_Hud_Wins.hidewheninmenu = false;
	self.gg_Hud_Wins.alpha = 0;

	//Background
	if( isdefined( self.gg_Hud_Game_Info ) )	self.gg_Hud_Game_Info destroy();
	self.gg_Hud_Game_Info = newClientHudElem( self );
	self.gg_Hud_Game_Info.x = 10;
	self.gg_Hud_Game_Info.y = 130;
	self.gg_Hud_Game_Info.horzAlign = "left";
	self.gg_Hud_Game_Info.vertAlign = "top";
	self.gg_Hud_Game_Info.alignX = "left";
	self.gg_Hud_Game_Info.alignY = "top";
	self.gg_Hud_Game_Info.xOffset = 0;
	self.gg_Hud_Game_Info.yOffset = 0;
	self.gg_Hud_Game_Info.sort = -1;
	self.gg_Hud_Game_Info setShader( "black", 290, 105 );
	self.gg_Hud_Game_Info.hidden = false;
	self.gg_Hud_Game_Info.hidewheninmenu = false;
	self.gg_Hud_Game_Info.alpha = 0;
}

Game_Info_Text()
{
	if( isDefined( game["gg_placement"] ) && game["gg_placement"].size &&
		isDefined( game["gg_placement"][0] ) && isPlayer( game["gg_placement"][0] ) )
	{
		leader = game["gg_placement"][0];
		leaderLevel = game["gg_placement"][0].pers["gg_level"];
	}
	else
	{
		leader = undefined;
		leaderLevel = 0;
	}
	maxLevel = int(game["gg_weaps"].size - 1);
	maxKills = level.gg_kills_for_levelup;
	player = self;
	playerLevel = player.pers["gg_level"];
	playerKills = player.pers["gg_kills_this_level"];


	player.gg_Hud_Leader.label = &"GUNGAME_CURRENT_LEADER";
	if( isDefined( leader ) && isPlayer( leader ) )
		player.gg_Hud_Leader setPlayerNameString( leader );
		
	player.gg_Hud_LeaderLevel.label = &"GUNGAME_LEADER_LEVEL";
	player.gg_Hud_LeaderLevel setValue( leaderLevel );

	if( isDefined( leader ) && player == leader )
		player.gg_Hud_Behind_Leader.label = &"GUNGAME_YOU_ARE_THE_LEADER";
	else if( playerLevel == leaderLevel)
		player.gg_Hud_Behind_Leader.label = &"GUNGAME_YOU_ARE_TIED_LEADER";
	else
	{
		player.gg_Hud_Behind_Leader.label = &"GUNGAME_YOU_ARE_NUM_BEHIND_LEADER";
		player.gg_Hud_Behind_Leader setValue( int( leaderLevel - playerLevel ) );
	}

	player.gg_Hud_On_Level.label = &"GUNGAME_YOU_ARE_ON_LEVEL";
	player.gg_Hud_On_Level setText( playerLevel + "^7 / ^2" + maxLevel );

	weapon_name = gungame\utility::convertWeaponName( game["gg_weaps"][playerLevel] );
	player.gg_Hud_Weapon.label = &"GUNGAME_YOU_NEED_WEAPON_KILL";
	player.gg_Hud_Weapon setText( weapon_name );

	player.gg_Hud_Kills.label = &"GUNGAME_KILLS_THIS_LEVEL";
	player.gg_Hud_Kills setText( playerKills + "^7 / ^2" + maxKills );

	if( !isDefined( player getStat( 3150 ) ) )
		numWins = 0;
	else
		numWins = player getStat( 3150 );

	player.gg_Hud_Wins.label = &"GUNGAME_HOW_MANY_WINS";
	player.gg_Hud_Wins setValue( numWins );
}
/* --- --- --- --- --- --- --- --- --- -- --- --- --- --- --- --- --- --- --- */
/* - Game Info HUD : End Code --- --- --- --- --- --- --- --- --- --- --- --- */
/* --- --- --- --- --- --- --- --- --- -- --- --- --- --- --- --- --- --- --- */

/* --- --- --- --- --- --- --- --- --- -- --- --- --- --- --- --- --- --- --- */
/* - Weapon Info That Shows when you kill someone  -- --- --- --- --- --- --- */
/* --- --- --- --- --- --- --- --- --- -- --- --- --- --- --- --- --- --- --- */
Weapon_Info()
{
	self endon( "disconnect" );
	self notify( "gg_weapon_info" );
	wait .05;
	self endon( "gg_weapon_info" );

	weapon_name = gungame\utility::convertWeaponName( game["gg_weaps"][ self.pers["gg_level"] ] );
	if( !isDefined( weapon_name ) || weapon_name == "" )
		return;

	if( isdefined( self.gg_Hud_Weapon_Info ) )	self.gg_Hud_Weapon_Info destroy();
	self.gg_Hud_Weapon_Info = newClientHudElem( self );
	self.gg_Hud_Weapon_Info.x = 0;
	self.gg_Hud_Weapon_Info.y = -70;
	self.gg_Hud_Weapon_Info.horzAlign = "center";
	self.gg_Hud_Weapon_Info.vertAlign = "bottom";
	self.gg_Hud_Weapon_Info.alignX = "center";
	self.gg_Hud_Weapon_Info.alignY = "middle";
	self.gg_Hud_Weapon_Info.xOffset = 0;
	self.gg_Hud_Weapon_Info.yOffset = 0;
	self.gg_Hud_Weapon_Info.sort = -1;
	if(	level.gg_kills_for_levelup > 1 )
		self.gg_Hud_Weapon_Info setShader( "black", 250, 45 );
	else
		self.gg_Hud_Weapon_Info setShader( "black", 250, 40 );
	self.gg_Hud_Weapon_Info.alpha = 0;
	self.gg_Hud_Weapon_Info fadeOverTime(.7);
	self.gg_Hud_Weapon_Info.alpha = .4;
	self.gg_Hud_Weapon_Info.hidden = false;
	self.gg_Hud_Weapon_Info.hidewheninmenu = true;

	if( isdefined( self.gg_Hud_Weapon_Info_Text ) )	self.gg_Hud_Weapon_Info_Text destroy();
	self.gg_Hud_Weapon_Info_Text = newClientHudElem( self );
	self.gg_Hud_Weapon_Info_Text.x = 0;
	self.gg_Hud_Weapon_Info_Text.y = -70;
	self.gg_Hud_Weapon_Info_Text.horzAlign = "center";
	self.gg_Hud_Weapon_Info_Text.vertAlign = "bottom";
	self.gg_Hud_Weapon_Info_Text.alignX = "center";
	self.gg_Hud_Weapon_Info_Text.alignY = "middle";
	self.gg_Hud_Weapon_Info_Text.fontScale = 1.4;
	self.gg_Hud_Weapon_Info_Text.font = "default";
	self.gg_Hud_Weapon_Info_Text.color = (1, 1, 1);
	self.gg_Hud_Weapon_Info_Text.hidewheninmenu = true;
	self.gg_Hud_Weapon_Info_Text.label = &"GUNGAME_WEAPON_INFO";
	self.gg_Hud_Weapon_Info_Text setText( self.pers["gg_level"] + "^7: ^2" + weapon_name );

	if(	level.gg_kills_for_levelup > 1 )
	{
		self.gg_Hud_Weapon_Info_Text.y = -80;

		if( isdefined( self.gg_Hud_Weapon_Info_Text2 ) )	self.gg_Hud_Weapon_Info_Text2 destroy();
		self.gg_Hud_Weapon_Info_Text2 = newClientHudElem( self );
		self.gg_Hud_Weapon_Info_Text2.x = 0;
		self.gg_Hud_Weapon_Info_Text2.y = -60;
		self.gg_Hud_Weapon_Info_Text2.horzAlign = "center";
		self.gg_Hud_Weapon_Info_Text2.vertAlign = "bottom";
		self.gg_Hud_Weapon_Info_Text2.alignX = "center";
		self.gg_Hud_Weapon_Info_Text2.alignY = "middle";
		self.gg_Hud_Weapon_Info_Text2.fontScale = 1.4;
		self.gg_Hud_Weapon_Info_Text2.font = "default";
		self.gg_Hud_Weapon_Info_Text2.color = (1, 1, 1);
		self.gg_Hud_Weapon_Info_Text2.hidewheninmenu = true;
		self.gg_Hud_Weapon_Info_Text2.label = &"GUNGAME_WEAPON_INFO_KILLS";
		self.gg_Hud_Weapon_Info_Text2 setText( self.pers["gg_kills_this_level"] + "^7 / ^2" + level.gg_kills_for_levelup );
	}

	wait( 7 );

	self thread Fade_And_Destroy( self.gg_Hud_Weapon_Info, 1 );
	self thread Fade_And_Destroy( self.gg_Hud_Weapon_Info_Text, 1 );
	self thread Fade_And_Destroy( self.gg_Hud_Weapon_Info_Text2, 1 );
}
/* --- --- --- --- --- --- --- --- --- -- --- --- --- --- --- --- --- --- --- */
/* - Weapon Info That Shows when you kill someone : End Code  --- --- --- --- */
/* --- --- --- --- --- --- --- --- --- -- --- --- --- --- --- --- --- --- --- */

/* --- --- --- --- --- --- --- --- --- -- --- --- --- --- --- --- --- --- --- */
/* - Mod Info HUD (bottom of the screen)  --- --- --- --- --- --- --- --- --- */
/* --- --- --- --- --- --- --- --- --- -- --- --- --- --- --- --- --- --- --- */
Mod_Info_Hud()
{
	if( isDefined( level.gg_Hud_Mod_Info ) )	level.gg_Hud_Mod_Info destroy();
	level.gg_Hud_Mod_Info = newHudElem();
	level.gg_Hud_Mod_Info.x = 7;
	level.gg_Hud_Mod_Info.y = 473;
	level.gg_Hud_Mod_Info.horzAlign = "left";
	level.gg_Hud_Mod_Info.vertAlign = "top";
	level.gg_Hud_Mod_Info.alignX = "left";
	level.gg_Hud_Mod_Info.alignY = "middle";
	level.gg_Hud_Mod_Info.alpha = 1;
	level.gg_Hud_Mod_Info.fontScale = 1.4;
	level.gg_Hud_Mod_Info.hidewheninmenu = true;
	level.gg_Hud_Mod_Info.color = ( 1, 1, 1 );
	level.gg_Hud_Mod_Info setText( level.gg_bottom_text );
}
/* --- --- --- --- --- --- --- --- --- -- --- --- --- --- --- --- --- --- --- */
/* - Mod Info HUD (bottom of the screen) : End Code - --- --- --- --- --- --- */
/* --- --- --- --- --- --- --- --- --- -- --- --- --- --- --- --- --- --- --- */

Fade_And_Destroy( element, time )
{
	self endon( "disconnect" );

	if( isDefined( element ) )
	{
		element fadeOverTime(time);
		element.alpha = 0;
	}
	wait time;
	if( isDefined( element ) )
	{
		element destroy();
	}
}