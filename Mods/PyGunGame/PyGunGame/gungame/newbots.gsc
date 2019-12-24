/***********************************************************************************

BotMod for adding Bots on an unranked Server so you can test your own Mods.
Some of the code was taken from the CoD2 Meatbot-Mod.

************************************************************************************

New commands:

addbot <team> [<class>]
<team> could be auto, allies or axis
<class> is optional and could be assault, specops, heavygunner, demolitions or sniper
=====================================================================================
Examples:
addbot auto               : bot autojoin a team with a random class
addbot allies             : bot join the allied team with a random class
addbot axis specops       : bot join the axis team as specops

-------------------------------------------------------------------------------------

removebot <team|all|name>
Removes a bot by team, all bots or a specific bot.
They will switched to spectator. If you add a bot again, one from the spectating bots
will join a team instead of a new bot.
=====================================================================================

Examples:
removebot allies          : removes a bot from the allied team
removebot all             : removes all bots
removebot bot2            : removes the bot with playername bot2

************************************************************************************/

init()
{

	setDvar("loc_warnings", 0);

	setDvar("addbot", "");
	setDvar("removebot", "");
	
	level.bot_allies = 0;
	level.bot_axis = 0;
	
	level thread dvarcheck();
	level thread addingbots();
	
}
	
dvarcheck()
{
	level endon("intermission");
	
	for (;;)
	{
		tmp = getDvar("addbot");
		if(tmp != "")
		{
			addBot(tmp);
			setDvar("addbot", "");
		}
		tmp = getDvar("removebot");
		if(tmp != "")
		{
			removebot(tmp);
			setDvar("removebot", "");
		}
	
		wait 0.25;
	}
}

addbot(team)
{
	class = "";
	param = [];
	param = strtok(team, " ");
	if (param.size > 0)
		team = param[0];
	if (param.size == 2)
		class = param[1];
		
	if (param.size < 1 || param.size > 2 || (team != "auto" && team != "axis" && team != "allies"))
	{
		iprintln("^2USAGE: ^7addbot <auto|allies|axis> [^3<assault|specops|heavygunner|demolitions|sniper>^7]");
		return;
	}
	
	addBotToQueue(team, class);
}

addBotToQueue(team, class)
{
	for(i = 0; i < level.addingbots.size; i++)
	{
		if (!isDefined(level.addingbots[i]))
			break;
	}
	level.addingbots[i] = spawnstruct();
	level.addingbots[i].team = team;
	level.addingbots[i].class = class;	
}

removeBot(team)
{
	players = getentarray("player", "classname");
  
	switch(team)
	{
		case "allies":
			for(i = 0; i < players.size; i++)
			{
				if (!isDefined(players[i].isBot))
					continue;
				if(players[i].pers["team"] == "allies")
				{
					level.bot_allies--;
					players[i] thread botJoin("spectator", "");
					break;
				}
			}
		break;
		
		case "axis":
			for(i = 0; i < players.size; i++)
			{
				if (!isDefined( players[i].isBot))
					continue;
				if(players[i].pers["team"] == "axis")
				{
					level.bot_axis--;
					players[i] thread botJoin("spectator", "");
					break;
				}
			}
		break;
		
		case "all":
			for(i = 0; i < players.size; i++)
			{
				if (!isDefined(players[i].isBot))
					continue;
				players[i] notify("killed_player");
				players[i] thread botJoin("spectator", "");
			}

			level.bot_allies = 0;
			level.bot_axis = 0;
		break;
		
		default:
			for(i = 0; i < players.size; i++)
			{
				if(players[i].name == team)
				{
					if(!isdefined(players[i].isBot))
					{
						iprintln(players[i].name + " ^1is not a bot^7!");
						continue;
					}

					if(players[i].pers["team"] == "allies")
						level.bot_allies--;
					else if(players[i].pers["team"] == "axis")
						level.bot_axis--;

					players[i] notify("killed_player");
					players[i] thread botJoin("spectator", "");
					break;
				}
			}
		break;
	}
}

addingbots()
{
	
	level.addingbots = [];

	while(1)
	{
		for (j = 0; j < level.addingbots.size; j++)
		{
			if(isDefined(level.addingbots[j]))
			{
				team = level.addingbots[j].team;
				class = level.addingbots[j].class;
				level.addingbots[j] = undefined;
				
				bot = undefined;
				players = getentarray("player", "classname");
				for(i = 0;i < players.size; i++)
				{
					if(players[i].pers["team"] == "spectator" && isDefined(players[i].isBot))
					{
						bot = players[i];
						break;
					}
				}
				if(!isdefined(bot))
					bot = addtestclient();

				if(isdefined(bot))
				{
					bot.isBot = true;
		
					switch(team)
					{
						case "auto":	bot thread botJoin("autoassign", class); break;
						case "axis":  	bot thread botJoin("axis", class); break;
						case "allies":	bot thread botJoin("allies", class); break;
					}
				}
				else
				{
					for (i = 0; i < level.addingbots.size; i++)
						level.addingbots[i] = undefined;
					iprintlnbold("^1Can't add more bots!");
					break;
				}
				
				wait 0.5;
			}
		}
		wait 0.5;
	}
}

botJoin(team, class)
{
	
	while(!isdefined(self.pers["team"]))
		wait .05;

	self notify("menuresponse", game["menu_team"], team);
	
	wait 0.5;

	if( team == "allies" )
	self notify("menuresponse", "changemodel_marines", "0");
	else if( team == "axis" )
	self notify("menuresponse", "changemodel_opfor", "0");
	
	self waittill("joined_team");
	
	if(team == "autoassign")
		team = self.pers["team"];
	
	new_class = "";
	
	if(team == "allies")
	{
		level.bot_allies++;

		switch(class)
		{
			case "assault"      : new_class = "assault"; break;
			case "specops"      : new_class = "specops"; break;
			case "heavygunner"  : new_class = "heavygunner"; break;
			case "demolitions"  : new_class = "demolitions"; break;
			case "sniper"       : new_class = "sniper"; break;

			default:
				rnd = randomint(4);
				switch(rnd)
				{
					case 0:	new_class = "assault"; break;
					case 1: new_class = "specops"; break;
					case 2: new_class = "heavygunner"; break;
					case 3: new_class = "demolitions"; break;
					case 4: new_class = "sniper"; break;
				}
			break;
		}

		self waittill("spawned_player");
		wait 0.10;
	}
	else if(team == "axis")
	{
		level.bot_axis++;

		switch(class)
		{
			case "assault"      : new_class = "assault"; break;
			case "specops"      : new_class = "specops"; break;
			case "heavygunner"  : new_class = "heavygunner"; break;
			case "demolitions"  : new_class = "demolitions"; break;
			case "sniper"       : new_class = "sniper"; break;

			default:
				rnd = randomint(4);
				switch(rnd)
				{
					case 0:	new_class = "assault"; break;
					case 1: new_class = "specops"; break;
					case 2: new_class = "heavygunner"; break;
					case 3: new_class = "demolitions"; break;
					case 4: new_class = "sniper"; break;
				}
			break;
		}

		self waittill("spawned_player");
		wait 0.10;
	}
	
	iprintln(self.name , " joined the ", game[team] , " as ", new_class ,".");
}