/* ---- by Lepko ---- lepko.san@gmail.com ---- http://www.xt-net.info/ ---- */

#include gungame\utility;

Setup_GunGame()
{
	// - Set GunGame Vars -
	level.gg_kills_for_levelup = setDvarDefault("gg_kills_for_levelup", 1, 1, 50);
	level.gg_turbo = setDvarDefault("gg_turbo", 1, 0, 1);
	level.gg_level_down = setDvarDefault("gg_level_down", 1, 0, 3);
	level.gg_health_regen_time = setDvarDefault("gg_health_regen_time", 5, 0, 10);
	level.gg_health_text = setDvarDefault("gg_health_text", 1, 0, 1);
	level.gg_weapon_drop = setDvarDefault("gg_weapon_drop", 1, 0, 1);
	level.gg_knife_nerf = setDvarDefault("gg_knife_nerf", 0, 0, 1);
	level.gg_dont_cook_frags = setDvarDefault("gg_dont_cook_frags", 0, 0, 1);
	level.gg_end_music = setDvarDefault("gg_end_music", 1, 0, 1);
	level.gg_knife_pro = setDvarDefault("gg_knife_pro", 1, 0, 1);
	level.gg_deadly_snipers = setDvarDefault("gg_deadly_snipers", 1, 0, 2);
	level.gg_handicap = setDvarDefault("gg_handicap", 1, 0, 1);
	level.gg_ammo_frag = setDvarDefault("gg_ammo_frag", 2, 1, 10);
	level.gg_ammo_c4 = setDvarDefault("gg_ammo_c4", 2, 1, 10);
	level.gg_ammo_rpg = setDvarDefault("gg_ammo_rpg", 2, 1, 10);
	level.gg_rotate_empty = setDvarDefault("gg_rotate_empty", 10, 0, 300);
	level.gg_weapon_sequence = setDvarDefault("gg_weapon_sequence", "" );
	level.gg_second_weapon = setDvarDefault("gg_second_weapon", "" );
	level.gg_second_weapon_levels = setDvarDefault("gg_second_weapon_levels", "" );
	level.gg_bottom_text = setDvarDefault("gg_bottom_text", "gg_bottom_text not set -> check the readme for info!" );
	level.gg_remove_turrets = setDvarDefault("gg_remove_turrets", 1, 0, 1 );

	// - Dvars To Be Used Later On -
	

	// - Setup Weapon Sequence -
	gungame\weapons::Set_Sequence();

	// Don't count scores since it displays levels on the sb
    level.onPlayerScore = maps\mp\gametypes\_globallogic::blank;

	// - Set All Gametype Limits To Zero -
	if( level.gametype == "sd" )
        maps\mp\gametypes\_globallogic::registerTimeLimitDvar( level.gametype, 2, 0, 5 );
	else
	   	maps\mp\gametypes\_globallogic::registerTimeLimitDvar( level.gametype, 0, 0, 0 );

	maps\mp\gametypes\_globallogic::registerScoreLimitDvar( level.gametype, 0, 0, 0 );
	maps\mp\gametypes\_globallogic::registerRoundLimitDvar( level.gametype, 0, 0, 0 );
}

//this sets up some things that depended on modwarfare mod and are now screwd =3
Set_MW_Dvars()
{
	level.mw_hitblip = setDvarDefault("scr_enable_hiticon", 1, 0, 4);
	level.mw_music = setDvarDefault("scr_enable_music", 0, 0, 1);
	level.mw_forceuav = setDvarDefault("scr_game_forceuav", 0, 0, 1);
	level.mw_nightvision = setDvarDefault("scr_enable_nightvision", 1, 0, 1);
	level.mw_scoretext = setDvarDefault("scr_enable_scoretext", 1, 0, 1);
}

Remove_Turrets()
{
	if( level.gg_remove_turrets )
	{
		deletePlacedEntity("misc_turret");
		deletePlacedEntity("misc_mg42");
	}
}