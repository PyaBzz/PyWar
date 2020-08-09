Rotate_Empty()
{
	if( level.gg_rotate_empty >= 1 )
	{
		game["gg_emptytime"] = 0; // Minutes

		while( game["gg_emptytime"] < level.gg_rotate_empty )
		{
			wait 30;

			num = 0;
			players = getentarray("player", "classname");
			for( i = 0 ; i < players.size ; i++ )
			{
				if( isAlive( players[i] ) && ( players[i].pers["team"] == "allies" || players[i].pers["team"] == "axis" ) )
					num++;
			}

			if( num >= 1 )
				game["gg_emptytime"] = 0;
			else
				game["gg_emptytime"] += .5;
		}

		exitLevel(false);
	}
}