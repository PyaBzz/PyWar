/* ---- by Lepko ---- lepko.san@gmail.com ---- http://www.xt-net.info/ ---- */

#include gungame\utility;

init()
{
	game["mc_enable"] = setDvarDefault("mc_enable", 0, 0, 2);
	game["mc_delay"] = setDvarDefault("mc_delay", 30, 15, 60);
	game["mc_max_msg"] = setDvarDefault("mc_max_msg", 5, 1, 20);

	game["wc_enable"] = setDvarDefault("wc_enable", 0, 0, 1);
	game["wc_array"] = strTok( getDvar("wc_message"), "\\" );

	if( game["wc_array"].size < 1 )
		game["wc_enable"] = 0;

	if( game["mc_enable"] )
		thread Server_Messages();
}

Server_Messages()
{
	level endon("game_ended");

	setDvarDefault("mc_msg_0", "^1Set the messages! Check ReadMe for info!");
	if( !isDefined( game["mc_last_msg"] ) ) game["mc_last_msg"] = 0;

    wait( game["mc_delay"] );

	for(;;)
	{
		last = game["mc_last_msg"];

		if( last == (game["mc_max_msg"]-1) )
		    last = -1;

		msg = getdvar( "mc_msg_" + (last+1) );

		if( !isDefined( msg ) || msg == "" )
		    continue;

		game["mc_last_msg"] = last + 1;

		if( game["mc_enable"] > 1 )
		    iprintln( msg );
		else
			level thread Show_Message( msg );

		wait( game["mc_delay"] );
	}
}

Show_Message( msg )
{
	if( !isDefined( level.gg_server_message ) )
	{
	    level.gg_server_message = newHudElem();
		level.gg_server_message.horzAlign = "right";
		level.gg_server_message.vertAlign = "top";
		level.gg_server_message.alignY = "middle";
		level.gg_server_message.alignX = "right";
		level.gg_server_message.x = -10;
		level.gg_server_message.y = -10;
		level.gg_server_message.archived = false;
		level.gg_server_message.alpha = 1;
		level.gg_server_message.color = ( 1, 1, 1 );
		level.gg_server_message.glowColor = (0.2, 0.3, 0.7);
		level.gg_server_message.glowAlpha = 1;
		level.gg_server_message.fontscale = 1.4;
		level.gg_server_message.font = "objective";
		level.gg_server_message.hideWhenInMenu = true;
	}

	level.gg_server_message setText( msg );
	level.gg_server_message moveOverTime( 1.5 );
	level.gg_server_message.y = 40;
	wait 12;
	level.gg_server_message moveOverTime( 1.5 );
	level.gg_server_message.y = -10;
}


Welcome_Messages()
{
	self endon( "disconnect" );

	self waittill( "spawned_player" );

	self.gg_welcome_message = newClientHudElem( self );
	self.gg_welcome_message.horzAlign = "center";
	self.gg_welcome_message.vertAlign = "top";
	self.gg_welcome_message.alignY = "middle";
	self.gg_welcome_message.alignX = "center";
	self.gg_welcome_message.x = 0;
	self.gg_welcome_message.y = 120;
	self.gg_welcome_message.archived = false;
	self.gg_welcome_message.alpha = 1;
	self.gg_welcome_message.color = ( 1, 1, 1 );
	self.gg_welcome_message.glowColor = (0.2, 0.3, 0.7);
	self.gg_welcome_message.glowAlpha = 1;
	self.gg_welcome_message.fontscale = 1.6;
	self.gg_welcome_message.font = "objective";
	self.gg_welcome_message.hideWhenInMenu = true;

	for( i = 0; i < game["wc_array"].size; i++ )
	{
        replaced = string_replace( game["wc_array"][i], "<name>", self.name );
		self.gg_welcome_message setText( replaced );
		self.gg_welcome_message setPulseFX( 100, 6000, 1000 );
		wait(7);
	}

	self.gg_welcome_message destroy();
}