/* ---- by Lepko ---- lepko.san@gmail.com ---- http://www.xt-net.info/ ---- */

Connected()
{
	if( !isDefined( self.pers["gg_level"] ) )				self.pers["gg_level"] = 1;
	if( !isDefined( self.pers["gg_kills_this_level"] ) )	self.pers["gg_kills_this_level"] = 0;
	if( !isDefined( self.pers["gg_killstreak"] ) )			self.pers["gg_killstreak"] = 0;
	if( !isDefined( self.pers["gg_voted"] ) )				self.pers["gg_voted"] = 0;
	if( !isDefined( self.pers["gg_multikill"] ))            self.pers["gg_multikill"] = 0;
	if( !isDefined( self.pers["gg_first_connect"] ))        self.pers["gg_first_connect"] = 1;

	// Setup Menu Info
	self setClientDvars( "ui_favoriteAddress", getdvar("net_ip")+":"+getdvar("net_port"),
						"ui_gg_turbo", getdvar("gg_turbo"),
						"ui_gg_knife_pro", getdvar("gg_knife_pro"),
						"ui_gg_health_regen_time", getdvar("gg_health_regen_time"),
						"ui_maxhealth", getdvar("scr_player_maxhealth") );
	
	// To show on scoreboard
	self.pers["score"] = self.pers["gg_level"];
	self.score = self.pers["gg_level"];

	self thread On_Spawn();
	self thread On_Joined_Spectators();
	self thread On_Disconnect();

	// - Connection Threads Here -	
	if( self.pers["gg_first_connect"] )
	{
		if( level.gg_handicap )
			self thread gungame\levels::Check_Handicap();

		if( game["wc_enable"] )
	    	self thread gungame\messages::Welcome_Messages();

		//Removed since we now have a welcome menu
		//self thread gungame\hud::Server_Info();
	}
	self.pers["gg_first_connect"] = 0;
	
	level gungame\levels::Gungame_Placement();

	// - Do Stuff Stuff -
	self.doStuffText = newClientHudElem(self);
	self.doStuffText.alpha = 0;
	self.doingStuff = false;
	self.doStuffQueue = [];

	// - Setup Hud -
	self thread gungame\hud::Game_Info_Wait();
}

On_Spawn()
{
	self endon( "disconnect" );
	
	for(;;)
	{
		self waittill( "spawned_player" );
		
		// - Spawn Threads Here -
		self thread gungame\weapons::Give_New_Weapon();
		self thread gungame\hud::Weapon_Info();
	}
}

On_Joined_Spectators()
{
	self endon( "disconnect" );

	for(;;)
	{
		self waittill( "joined_spectators" );
		
		// - Spectator Threads Here -
	}
}

On_Disconnect()
{
	self waittill( "disconnect" );
	
	// - Disconnect threads there -
	level gungame\levels::Gungame_Placement();
}