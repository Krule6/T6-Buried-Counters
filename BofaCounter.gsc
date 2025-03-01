#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_hud_message;
#include maps\mp\zombies\_zm_weapons;

init()
{
    set_dvar_int_if_unset("bofa_counter", 0); 
    level endon("game_ended");
    level thread monitor_players();
}

monitor_players()
{
    for(;;)
    {
        level waittill("connected", player);
        player thread bofa_counter();
    }
}

bofa_counter()
{
    self endon("disconnect");
    self.bofa_hud = self createServerFontString("hudsmall", 1.20);
    self.bofa_hud setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", 0, 227.5); 
    self.bofa_hud.alpha = 1;
    self.bofa_hud.color = (1, 0.8, 1); 
    self.bofa_hud.hidewheninmenu = 1;
    self.bofa_hud.label = &"Bofa Counter: ";
    self.bofa_hud SetValue(GetDvarInt("bofa_counter"));

    flag_wait("initial_blackscreen_passed");
    wait(40);
    
    if (isdefined(self.bofa_hud))
    {
        self.bofa_hud.alpha = 0;
    }

    counter_increased = 0;

    while(1)
{
    has_paralyzer = self hasweapon("slowgun_zm"); 
    has_time_bomb = self hasweapon("time_bomb_zm");

    if (has_paralyzer && has_time_bomb && !counter_increased)
    {
        setdvar("bofa_counter", getdvarint("bofa_counter") + 1);
        
        counter_increased = 1;
    }
    else if (!has_paralyzer || !has_time_bomb)
    {
        counter_increased = 0;
    }

    wait(0.5);
}
}

