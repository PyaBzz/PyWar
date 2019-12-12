/* ---- by Lepko ---- lepko.san@gmail.com ---- http://www.xt-net.info/ ---- */

#include maps\mp\gametypes\_hud_util;
#include gungame\utility;

Killed_Player( attacker, sWeapon, sMeansOfDeath )
{
	self.pers["gg_killstreak"] = 0;

	if( isPlayer( attacker ) )
	{
		if( attacker == self ) //selfkill
		{
			if( !isDefined( self.switching_teams ) || !self.switching_teams )
			{
				self gungame\levels::Level_Down();
				iprintln( &"GUNGAME_LEVEL_DOWN_SUICIDE", self.name, level.gg_level_down );
			}
		}
		else if( level.teambased && attacker.team == self.team ) //teamkill
		{
			attacker.pers["gg_killstreak"] = 0;
			
			level PlaySoundOnPlayers("gg_teamkiller");

			attacker gungame\levels::Level_Down();
			iprintln( &"GUNGAME_LEVEL_DOWN_TEAMKILL", attacker.name, level.gg_level_down );
		}
		else //other kill
		{
			attacker.pers["gg_killstreak"]++;

			weapon_check = gungame\levels::Check_Weapon( attacker, sWeapon, sMeansOfDeath );

			if( weapon_check == "kill" || weapon_check == "nade" )
			{
				attacker.pers["gg_kills_this_level"]++;
				
				enough_kills = gungame\levels::Check_Enough_Kills( attacker, self );
				
				if( enough_kills )
					attacker gungame\levels::Level_Up();
				else
					attacker gungame\weapons::Reload_Weapon();
			}
			else if( weapon_check == "knife" )
			{
				attacker.pers["gg_kills_this_level"]++;
				self gungame\levels::Level_Down();

				enough_kills = gungame\levels::Check_Enough_Kills( attacker, self );

				if( enough_kills )
					attacker gungame\levels::Level_Up();

				iprintln( &"GUNGAME_STOLE_A_LEVEL", attacker.name, self.name );
			}
			else if( weapon_check == "melee" && level.gg_knife_pro )
			{
				attacker gungame\levels::Level_Up();
				self gungame\levels::Level_Down();

				iprintln( &"GUNGAME_STOLE_A_LEVEL", attacker.name, self.name );
			}
			else
				attacker gungame\weapons::Reload_Weapon();

			attacker thread gungame\sounds::Check( self, sMeansOfDeath );
		}

		attacker thread gungame\hud::Weapon_Info();

		attacker.score = attacker.pers["gg_level"];
		attacker.pers["score"] = attacker.pers["gg_level"];
	}
	else
	{
		if( sMeansOfDeath == "MOD_FALLING" || sMeansOfDeath == "MOD_TRIGGER_HURT" )
		{
			self gungame\levels::Level_Down();
			iprintln( &"GUNGAME_LEVEL_DOWN_SUICIDE", self.name, level.gg_level_down );
		}
		else if( sMeansOfDeath == "MOD_EXPLOSIVE" )
		{
			//self gungame\levels::Level_Down();
			//iprintln( self.name + "^7 exploded!" );
		}
		else
		{
			text = "^1[Debug]: attacker is not a player -> sMeansOfDeath: "+ sMeansOfDeath;
			Debug_Print( text );
		}
	}

	self.score = self.pers["gg_level"];
	self.pers["score"] = self.pers["gg_level"];

	gungame\levels::Gungame_Placement();
}

End_Game( winner, lastkilled )
{
	// return if already ending via host quit or victory
	if ( game["state"] == "postgame" )
		return;

	game["state"] = "postgame";
	level.gameEndTime = getTime();
	level.gameEnded = true;
	level.inGracePeriod = false;
	level notify ( "game_ended" );

	wait 3;

	setGameEndTime( 0 ); // stop/hide the timers

	maps\mp\gametypes\_globallogic::updatePlacement();
	maps\mp\gametypes\_globallogic::updateMatchBonusScores( winner );
	maps\mp\gametypes\_globallogic::updateWinLossStats( winner );

	if( level.gg_end_music )
		level PlaySoundOnPlayers( "gg_end" );

	// freeze players
	players = level.players;
	for ( index = 0; index < players.size; index++ )
	{
		player = players[index];
		
		player maps\mp\gametypes\_globallogic::freezePlayerForRoundEnd();
		player thread maps\mp\gametypes\_globallogic::roundEndDoF( 4.0 );
		
		player maps\mp\gametypes\_globallogic::freeGameplayHudElems();
		
		player thread winnerNotify( winner, lastkilled );
		
		player setClientDvars(	"ui_hud_hardcore", 1,
								"g_compassShowEnemies", 0 );

		player setClientDvars(	"cg_deadChatWithDead", 1,
								"cg_deadChatWithTeam", 1,
								"cg_deadHearTeamLiving", 1,
								"cg_deadHearAllLiving", 1,
								"cg_everyoneHearsEveryone", 1,
								"g_deadChat", 1 );
	}

	logPrint("GG_WINNER;" + winner.name + "\n");

	wait 3;

	// Set Winner Stats
	if( !isDefined( winner getStat( 3150 ) ) )
		statNum = 0;
	else
		statNum = winner getStat( 3150 );

	winner maps\mp\gametypes\_rank::giveRankXP( "challenge" );
	winner setStat( 3150, statNum + 1 ); // Sets the number of times the player has won

	switch( winner getStat( 3150 ) )
	{
		case 1:		numberstring = "1st";	break;
		case 2:		numberstring = "2nd";	break;
		case 3:		numberstring = "3rd";	break;
		default:	numberstring = ""+winner getStat( 3150 )+"th";	break;
	}

	iprintln("^2[GunGame]:^7 "+winner.name+" ^7has won for the ^2"+numberstring+"^7 time!");
	// Set Winner Stats END

	maps\mp\gametypes\_globallogic::roundEndWait( 8, false );

	level.intermission = true;

	players = level.players;
	for ( index = 0; index < players.size; index++ )
	{
		player = players[index];
		
		player closeMenu();
		player closeInGameMenu();
		player notify ( "reset_outcome" );
		player [[level.spawnIntermission]]();
		player setClientDvar( "ui_hud_hardcore", 0 );
	}
	
	logString( "game ended" );
	wait 10.0; //scoreboard time

	exitLevel( false );
}

winnerNotify( winner, lastkilled )
{
	self endon ( "disconnect" );

	while ( self.doingNotify )
		wait 0.05;

	titleSize = 3.0;
	winnerSize = 2.0;
	otherSize = 1.5;
	iconSize = 30;
	spacing = 20;
	font = "objective";

	duration = 9500;

	outcomeTitle = createFontString( font, titleSize );
	outcomeTitle setPoint( "TOP", undefined, 0, spacing );

	if ( isDefined( winner ) && self == winner )
	{
		outcomeTitle.label = game["strings"]["victory"];
//		outcomeTitle setText( game["strings"]["victory"] );
		outcomeTitle.glowColor = (0.2, 0.3, 0.7);
	}
	else
	{
		outcomeTitle.label = game["strings"]["defeat"];
//		outcomeTitle setText( game["strings"]["defeat"] );
		outcomeTitle.glowColor = (0.7, 0.3, 0.2);
	}

	outcomeTitle.glowAlpha = 1;
	outcomeTitle.hideWhenInMenu = false;
	outcomeTitle.archived = false;
	outcomeTitle setPulseFX( 100, duration, 1000 );

	outcomeText = createFontString( font, 2.0 );
	outcomeText setParent( outcomeTitle );
	outcomeText setPoint( "TOP", "BOTTOM", 0, 0 );
	outcomeText.glowAlpha = 1;
	outcomeText.hideWhenInMenu = false;
	outcomeText.archived = false;
	outcomeText.glowColor = (0.2, 0.3, 0.7);
	//outcomeText setText( "" );

	firstTitle = createFontString( font, winnerSize );
	firstTitle setParent( outcomeText );
	firstTitle setPoint( "TOP", "BOTTOM", 0, spacing );
	firstTitle.glowColor = (0.3, 0.7, 0.2);
	firstTitle.glowAlpha = 1;
	firstTitle.hideWhenInMenu = false;
	firstTitle.archived = false;
	if ( isDefined( winner ) )
	{
		firstTitle.label = &"GUNGAME_WON";
		firstTitle setPlayerNameString( winner );
		firstTitle setPulseFX( 100, duration, 1000 );
	}

	secondTitle = createFontString( font, otherSize );
	secondTitle setParent( firstTitle );
	secondTitle setPoint( "TOP", "BOTTOM", 0, spacing );
	secondTitle.glowColor = (0.2, 0.3, 0.7);
	secondTitle.glowAlpha = 1;
	secondTitle.hideWhenInMenu = false;
	secondTitle.archived = false;
	if ( isDefined( lastkilled ) )
	{
		secondTitle.label = &"GUNGAME_HUMILIATED";
		secondTitle setPlayerNameString( lastkilled );
		secondTitle setPulseFX( 100, duration, 1000 );
	}
}
