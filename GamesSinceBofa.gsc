#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_hud_message;

init()
{
    set_dvar_int_if_unset("gsb_counter", 0); 
    level endon("game_ended");
    level thread monitor_players();
}

monitor_players()
{
    for(;;)
    {
        level waittill("connected", player);
        player thread gsb_counter();
    }
}

gsb_counter()
{
    self endon("disconnect");
    self.gsb_hud = self createServerFontString("hudsmall", 1.20);
    self.gsb_hud setpoint("BOTTOMRIGHT", "BOTTOMRIGHT", 300, 227.5); 
    self.gsb_hud.alpha = 1;
    self.gsb_hud.color = (1, 0.8, 1); 
    self.gsb_hud.hidewheninmenu = 1;
    self.gsb_hud.label = &"Games Since Bofa: ";
    self.gsb_hud SetValue(GetDvarInt("gsb_counter"));

    flag_wait("initial_blackscreen_passed");
    
    wait(40);
    if (isdefined(self.gsb_hud))
    {
        self.gsb_hud.alpha = 0;
    }
    
    paralyzer = 0;
    timebomb = 0;
    counterincreased = 0;

    while(1)
    {
        if (self hasweapon("slowgun_zm"))
        {
            paralyzer = 1;
        }

        if (self hasweapon("time_bomb_zm"))
        {
            timebomb = 1;
        }

        if (paralyzer && timebomb)
        {
            setdvar("gsb_counter", 0);
            counterincreased = 0; 
        }

        else if (!counterincreased)
        {
            setdvar("gsb_counter", getdvarint("gsb_counter") + 1);
            counterincreased = 1;
        }

        wait(0.5);
    }
}

