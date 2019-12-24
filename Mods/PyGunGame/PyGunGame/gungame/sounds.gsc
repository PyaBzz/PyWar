/* ---- by Lepko ---- lepko.san@gmail.com ---- http://www.xt-net.info/ ---- */

#include gungame\utility;

Check( victim, death )
{
	self endon( "disconnect" );
	self endon( "death" );

	// FirstBlood Check
	if( !isDefined( level.gg_firstblood ) || !level.gg_firstblood )
	{
		level doStuff_all( &"GUNGAME_FIRST_BLOOD", "gg_firstblood", "red", self );
		level.gg_firstblood = true;
	}
	// -----------------
	// HeadShot Check
	else if( death == "MOD_HEAD_SHOT" )
		self doStuff( &"GUNGAME_HEADSHOT", "gg_headshot", "red" );
	// -----------------
	// Melee Check
	else if( death == "MOD_MELEE" )
		level PlaySoundOnPlayers( "gg_humiliation" );
	// -----------------

	// MultiKills Check
	self.pers["gg_multikill"]++;
	switch( self.pers["gg_multikill"] )
	{
		case 2:
			self doStuff( &"GUNGAME_MULTI_DOUBLE_KILL", "gg_doublekill", "red" );
			break;
		case 3:
			self doStuff( &"GUNGAME_MULTI_MULTI_KILL", "gg_multikill", "red" );
			break;
		case 4:
			self doStuff( &"GUNGAME_MULTI_MEGA_KILL", "gg_megakill", "red" );
			break;
		case 5:
			self doStuff( &"GUNGAME_MULTI_ULTRA_KILL", "gg_ultrakill", "red" );
			break;
		case 6:
			self doStuff( &"GUNGAME_MULTI_MONSTER_KILL", "gg_monsterkill", "red" );
			break;
		case 7:
			level doStuff_all( &"GUNGAME_MULTI_HOLY_SHIT", "gg_holyshit", "red", self );
			break;
		default:
			break;
	}
	self notify( "gg_multikill" );
	self thread Multikill_wait();
	// --------------------

	// KillingSpree Check
	streak = self.pers["gg_killstreak"];
	switch( streak )
	{
		case 5:
			level doStuff_all( &"GUNGAME_SPREE_KILLING_SPREE", "gg_killingspree", "red", self );
			break;
		case 10:
			level doStuff_all( &"GUNGAME_SPREE_RAMPAGE", "gg_rampage", "red", self );
			break;
		case 15:
			level doStuff_all( &"GUNGAME_SPREE_DOMINATING", "gg_dominating", "red", self );
			break;
		case 20:
			level doStuff_all( &"GUNGAME_SPREE_UNSTOPPABLE", "gg_unstoppable", "red", self );
			break;
		case 25:
			level doStuff_all( &"GUNGAME_SPREE_GOD_LIKE", "gg_godlike", "red", self );
			break;
		default:
			break;
	}
	// --------------------
}

Multikill_wait()
{
	self endon( "disconnect" );
	self endon( "gg_multikill" );

	wait 3;

	self.pers["gg_multikill"] = 0;
}
