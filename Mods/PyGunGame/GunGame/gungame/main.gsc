init()
{
	setdvar("_Mod", "GunGame", true);
	setdvar("_ModVer", "1.2", true);
//	setdvar("_ModWeb", "http://www.xt-net.info/", true);

	// - Setup GunGame -
	gungame\setup::Setup_GunGame();
	gungame\setup::Set_MW_Dvars(); //some mw dvars that are usable

	// - Server Hud -
	thread gungame\hud::Mod_Info_Hud();

	// - Message Center -
	thread gungame\messages::init();

	// - Map Rotation -
	thread gungame\maprotation::Rotate_Empty();

	// - Turret Removal -
	thread gungame\setup::Remove_Turrets();

	// - Admin Tools -
	thread gungame\admin_tools::init();

	// - Testing Threads -
	thread gungame\newbots::init();

	// - Monitor Connections -
	thread Connection_Monitor();
}

Connection_Monitor()
{
	for(;;)
	{
		level waittill ( "connected", player );
		player thread gungame\player::Connected();
	}
}