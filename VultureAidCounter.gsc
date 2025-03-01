#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_hud_message;

init()
{
    set_dvar_int_if_unset("vulture_count", 0);
    level waittill("connected", player);
    player vulture_counter();
}

vulture_counter()
{
    self.vulture_hud = self createServerFontString("hudsmall", 1.20);
    if (isdefined(self.vulture_hud))
    {
        self.vulture_hud setpoint("BOTTOMLEFT", "BOTTOMLEFT", -300, 227.5); 
        self.vulture_hud.alpha = 1; 
        self.vulture_hud.color = (1, 0.8, 1); 
        self.vulture.hidewheninmenu = 1;
        self.vulture_hud.label = &"Vulture Aid Count: ";
        self.vulture_hud SetValue((GetDvarFloat("vulture_count")));
    }
    
    flag_wait("initial_blackscreen_passed");
    wait(40);
    
    if (isdefined(self.vulture_hud))
    {
        self.vulture_hud.alpha = 0;
    }
    while (1)
    {
    self waittill("perk_acquired");

    if (isdefined(self.perk_vulture) && self.perk_vulture.active && !self.has_vulture)
    {
        setdvar("vulture_count", getdvarint("vulture_count") + 1);
        self.has_vulture = true;
    }
    
    }
}
