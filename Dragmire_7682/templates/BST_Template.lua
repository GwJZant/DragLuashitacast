local profile = {};

-- START SETTINGS
local Settings = {
    -- Default settings for jug/food preferences
    -- LullabyMelodia SaberFamiliar CourierCarrie
    JugPetSettings = {
        -- This toggle configures which jugs the 'JugChange' command will loop through
        DefaultJugs = {JugPetConfig.LullabyMelodia, JugPetConfig.VoraciousAudrey, JugPetConfig.CourierCarrie},
        CurrentJug = 1,
    },
    -- Settings used for a delay initilization of macro books and style locking since those aren't always populated the moment you load a Lua file
    LateInitialized = {
        Initialized = false,
        TimeToUse = 0,
    },

    -- Used for handling Priority gear swapping
    CurrentLevel = 0,
};
-- END SETTINGS

local sets = {
    Default_Priority = {
        Ammo = {'Happy Egg'},
        Head = {'Optical Hat','Shep. Bonnet',},
        Neck = {'Temp. Torque', 'Peacock Amulet'},
        Ear1 = {'Ethereal Earring', 'Dodge Earring'},
        Ear2 = {'Novia Earring'},
        Body = {'Scorpion Harness', 'Elder\'s Surcoat',},
        Hands = {'Monster Gloves', 'Elder\'s Bracers'},
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Blitz Ring', 'Bastokan Ring'},
        Back = {'Boxer\'s Mantle',},
        Waist = {'Sonic Belt', 'Ryl.Kgt. Belt'},
        Legs = {'Byakko\'s Haidate', 'Elder\'s Braguette'},
        Feet = {'Monster Gaiters', 'Elder\'s Sandals'},
    },

    IdleTown_Priority = {
        Ammo = {'Tiphia Sting'},
        Head = {'Monster Helm'},
        Neck = {'Temp. Torque'},
        Ear1 = {'Beastly Earring'},
        Ear2 = {'Brutal Earring'},
        Body = {'Hecatomb Harness'},
        Hands = {'Monster Gloves'},
        Ring1 = {'Jelly Ring'},
        Ring2 = {'Blitz Ring'},
        Back = {'Forager\'s Mantle'},
        Waist = {'Sonic Belt'},
        Legs = {'Byakko\'s Haidate'},
        Feet = {'Hct. Leggings'},
    },

    Engaged_Priority = { -- 19% Haste (Missing: Dusk Gloves +1, Dusk Boots +1, Panther Mask +1)
        Ammo = {'Tiphia Sting'},
        Head = {'Panther Mask'}, --2%
        Ear1 = {'Beastly Earring', 'Dodge Earring'},
        Ear2 = {'Brutal Earring', 'Merman\'s Earring'},
        Body = {'Kirin\'s Osode'},
        Hands = {'Dusk Gloves'}, --3%
        Ring2 = {'Blitz Ring'}, --1%
        Back = {'Forager\'s Mantle'},
        Waist = {'Sonic Belt'}, --6%
        Legs = {'Byakko\'s Haidate'}, --5%
        Feet = {'Dusk Ledelsens'}, --2%
    },

    PetAcc_Priority = { -- Prioritize Pet Accuracy
        Head = {'Shep. Bonnet'}, -- PetAcc +5
        Ear1 = {'Beastly Earring'}, -- PetAcc +10
    },

    PetAccWHM_Priority = { -- Prioritize Pet Accuracy
        Head = {'Shep. Bonnet'}, -- PetAcc +5
        Ear1 = {'Beastly Earring'}, -- PetAcc +10
    },

    MP_Priority = { -- Only comes on while idling so put as much MP gear in here as I have
        Ammo = {'Hedgehog Bomb', 'Phtm. Tathlum', 'Fortune Egg'},
        Head = {},
        Neck = {},
        Ear1 = {},
        Ear2 = {'Loquac. Earring'},
        Body = {'Kirin\'s Osode', 'Elder\'s Surcoat',},
        Hands = {'Elder\'s Bracers'},
        Ring1 = {},
        Ring2 = {},
        Back = {},
        Waist = {},
        Legs = {'Elder\'s Braguette'},
        Feet = {'Elder\'s Sandals'},
    },

    Evasion_Priority = {
        Head = {'Optical Hat'},
        Neck = {}, 
        Ear1 = {}, 
        Ear2 = {}, 
        Hands = {},
        Back = {}, 
        Waist = {},
        Legs = {}, 
        Feet = {}, 
    },

    EvasionWHM_Priority = {
        Ammo = {'Fortune Egg',},
        Head = {'Optical Hat'},
        Neck = {},
        Ear1 = {},
        Ear2 = {},
        Hands = {},
        Back = {},
        Waist = {},
        Legs = {},
        Feet = {},
    },

    WeaponSkill_Priority = { -- Prioritize Player Accuracy and Damage; STR > ACC > DEX > ATK
        Ammo = {'Tiphia Sting',},
        Head = {'Optical Hat',},
        Neck = {'Temp. Torque', 'Peacock Amulet'},
        Ear1 = {'Beastly Earring', 'Spike Earring'},
        Ear2 = {'Brutal Earring', 'Merman\'s Earring'},
        Body = {'Hecatomb Harness'},
        Hands = {'Ogre Gloves', 'Battle Gloves',},
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Toreador\'s Ring'},
        Back = {'Forager\'s Mantle'},
        Waist = {'Warwolf Belt', 'Ryl.Kgt. Belt'},
        Legs = {'Byakko\'s Haidate'},
        Feet = {'Hct. Leggings',},
    },

    WeaponSkillLight_Priority = {
        Neck = {'Light Gorget'},
    },

    Gaudy_Priority = {
        Body = {'Gaudy Harness'},
    },

    Midcast_Priority = {
        Ear2 = {'Loquac. Earring'},
    },

    Precast_Priority = {
        Ear2 = {'Loquac. Earring'},
    },

    Enhancing_Priority = {
        Neck = {'Enhancing Torque'},
    },

    Healing_Priority = {
        
    },

    WeaponsTPNIN_Priority = {
        Main = {'Martial Axe'},
        Sub = {'Temperance Axe'},
    },

    WeaponsGaudyNIN_Priority = {
        Main = {'Rune Axe'},
        Sub = {'Rune Axe'},
    },

    WeaponsTP_Priority = {
        Main = {'Temperance Axe'},
    },

    WeaponsGaudy_Priority = {
        Main = {'Rune Axe'},
    },

    Relaxing_Priority = {
        Ear2 = {'Relaxing Earring'},
    },

    StealthEarring_Priority = {
        Ear1 = 'Stealth Earring',
    },

    StyleLockAF = {
        Head = 'Beast Helm',
        Body = 'Beast Jackcoat',
        Hands = 'Beast Gloves',
        Legs = 'Beast Trousers',
        Feet = 'Beast Gaiters',
    },

    StyleLockGeneric = {
        --Head = 'Zoolater Hat',
        Head = 'Genbu\'s Kabuto',
        --Body = 'Hecatomb Harness',
        Body = 'Kirin\'s Osode',
        Hands = 'Dusk Gloves',
        Legs = 'Byakko\'s Haidate',
        Feet = 'Suzaku\'s Sune-Ate',
    },

    StyleLockRSE = {
        Head = 'Egg Helm',
        Body = 'Elder\'s Surcoat',
        Hands = 'Elder\'s Bracers',
        Legs = 'Elder\'s Braguette',
        Feet = 'Elder\'s Sandals'
    },

    StyleLockWinter = {
        Main = 'Barbaroi Axe',
        Sub = 'Tungi',
        Head = 'Snowman Cap',
        Body = 'Dream Robe +1',
        Hands = 'Dream Mittens +1',
        Legs = 'Dream Trousers +1',
        Feet = 'Dream Boots +1',
    },

    StyleLockBeastok = {
        Head = 'President. Hairpin',
        Body = 'Republic Aketon',
        Hands = 'Dusk Gloves',
        Legs = 'Ryl.Kgt. Breeches',
        Feet = 'Dusk Ledelsens'
    },

    StyleLockHydra = {
        Head = 'President. Hairpin',
        Body = 'Hydra Jupon',
        Hands = 'Scp. Gauntlets',
        Legs = 'Hydra Tights',
        Feet = 'Hydra Boots',
    },

    -- Uses Relic body to remove status ailments
    RewardSTATUS_Priority = { -- MND
        Ammo = {'Pet Food Zeta', 'Pet Fd. Epsilon', 'Pet Food Delta', 'Pet Fd. Gamma', 'Pet Food Beta', 'Pet Food Alpha'},
        --Head = {'Beast Helm'},
        Hands = {'Ogre Gloves'},
        Body = {'Mst. Jackcoat +1'},
        Waist = {'Ryl.Kgt. Belt'},
        Feet = {'Monster Gaiters', 'Beast Gaiters'},
    },

    -- Uses Kirin's Osode to maximize healing, does not remove status ailments
    RewardHP_Priority = { -- MND
        Ammo = {'Pet Food Zeta', 'Pet Fd. Epsilon', 'Pet Food Delta', 'Pet Fd. Gamma', 'Pet Food Beta', 'Pet Food Alpha'},
        --Head = {'Beast Helm'},
        Hands = {'Ogre Gloves'},
        Body = {'Kirin\'s Osode'},
        Waist = {'Ryl.Kgt. Belt'},
        Feet = {'Monster Gaiters', 'Beast Gaiters'},
    },

    Call_Priority = { -- Default Jug
        Ammo = Settings.JugPetSettings.DefaultJugs[Settings.JugPetSettings.CurrentJug].DefaultJug,
        Hands = {'Monster Gloves'},
    },

    Charm_Priority = {
        Head = {'Monster Helm', 'Beast Helm'},
        Neck = {'Flower Necklace'},
        Hands = {'Monster Gloves', 'Beast Gloves'},
        Ear1 = {'Beastly Earring'},
        Ear2 = {'Melody Earring'},
        Body = {'Kirin\'s Osode'},
        --Waist = {'Monster Belt'},
        Feet = {'Monster Gaiters', 'Beast Gaiters'},
        Legs = {'Beast Trousers'},
    },

    Tame = {
        Head = 'Beast Helm',
    },

    EXPRing = {
        Ring1 = 'Chariot Band',
    },

    Warp = {
        Main = 'Warp Cudgel',
    },

    Sneak = {
        Hands = 'Dream Mittens +1',
    },

    Invisible = {
        Feet = 'Dream Boots +1',
    },
};

profile.Sets = sets;

local Towns = T{'Tavnazian Safehold','Al Zahbi','Aht Urhgan Whitegate','Nashmau','Southern San d\'Oria [S]','Bastok Markets [S]','Windurst Waters [S]','San d\'Oria-Jeuno Airship','Bastok-Jeuno Airship','Windurst-Jeuno Airship','Kazham-Jeuno Airship','Southern San d\'Oria','Northern San d\'Oria','Port San d\'Oria','Chateau d\'Oraguille','Bastok Mines','Bastok Markets','Port Bastok','Metalworks','Windurst Waters','Windurst Walls','Port Windurst','Windurst Woods','Heavens Tower','Ru\'Lude Gardens','Upper Jeuno','Lower Jeuno','Port Jeuno','Rabao','Selbina','Mhaura','Kazham','Norg','Mog Garden','Celennia Memorial Library','Western Adoulin','Eastern Adoulin'};

-- Can use these with JugPetSettings so you don't have to delete and re-find move names
local JugPetConfig = {
    LullabyMelodia = {
        Name = 'LullabyMelodia',
        DefaultJug = 'S. Herbal Broth',
        DefaultSTA = 'Lamb Chop',
        DefaultAOE = 'Sheep Song',
        DefaultSpecial = 'Rage',
        DurationMinutes = 60,
    },
    CourierCarrie = {
        Name = 'CourierCarrie',
        DefaultJug = 'Fish Oil Broth',
        DefaultSTA = 'Big Scissors',
        DefaultAOE = 'Bubble Shower',
        DefaultSpecial = 'Scissor Guard',
        --DefaultSpecial = 'Bubble Curtain',
        DurationMinutes = 30,
    },
    CrabFamiliar = {
        Name = 'CrabFamiliar',
        DefaultJug = 'Fish Broth',
        DefaultSTA = 'Big Scissors',
        DefaultAOE = 'Bubble Shower',
        DefaultSpecial = 'Scissor Guard',
        --DefaultSpecial = 'Bubble Curtain',
        DurationMinutes = 30,
    },
    SaberSiravarde = {
        Name = 'SaberSiravarde',
        DefaultJug = 'W. Meat Broth',
        DefaultSTA = 'Razor Fang',
        DefaultAOE = 'Claw Cyclone',
        DefaultSpecial = 'Roar',
        DurationMinutes = 60,
    },
    SaberFamiliar = { --NQ Saber lv. 28
        Name = 'SaberFamiliar',
        DefaultJug = 'Meat Broth',
        DefaultSTA = 'Razor Fang',
        DefaultAOE = 'Claw Cyclone',
        DefaultSpecial = 'Roar',
        DurationMinutes = 60,
    },
    MiteFamiliar = { --NQ Diremite lv. 55
        Name = 'MiteFamiliar',
        DefaultJug = 'Blood Broth',
        DefaultSTA = 'Double Claw',
        DefaultAOE = 'Spinning Top',
        DefaultSpecial = 'Filamented Hold',
        DurationMinutes = 60,
    },
    KeenearedSteffi = {
        Name = 'KeenearedSteffi',
        DefaultJug = 'F. Carrot Broth',
        DefaultSTA = 'Foot Kick',
        DefaultAOE = 'Whirl Claws',
        DefaultSpecial = 'Dust Cloud',
        DurationMinutes = 90,
    },
    FunguarFamiliar = {
        Name = 'FunguarFamiliar',
        DefaultJug = 'Seedbed Soil',
        DefaultSTA = 'Frogkick',
        DefaultAOE = 'Silence Gas',
        DefaultSpecial = 'Dark Spore',
        DurationMinutes = 60,
    },
    FlowerpotBill = {
        Name = 'FlowerpotBill',
        DefaultJug = 'C. Carrion Broth',
        DefaultSTA = 'Head Butt',
        DefaultAOE = '',
        DefaultSpecial = 'Dream Flower',
        DurationMinutes = 60,
    },
    FlowerpotBen = {
        Name = 'FlowerpotBen',
        DefaultJug = 'C. Carrion Broth',
        DefaultSTA = 'Head Butt',
        DefaultAOE = '',
        DefaultSpecial = 'Dream Flower',
        DurationMinutes = 60,
    },
    ShellbusterOrob = {
        Name = 'ShellbusterOrob',
        DefaultJug = 'Q. Bug Broth',
        DefaultSTA = 'Venom',
        DefaultAOE = 'Cursed Sphere',
        DefaultSpecial = 'Venom',
        DurationMinutes = 60,
    },
    ColdbloodComo = {
        Name = 'ColdbloodComo',
        DefaultJug = 'C. Carrion Broth',
        DefaultSTA = 'Blockhead',
        DefaultAOE = 'Fireball',
        DefaultSpecial = 'Secretion',
        DurationMinutes = 60,
    },
    Homunculus = {
        Name = 'Homunculus',
        DefaultJug = 'C. Carrion Broth',
        DefaultSTA = 'Head Butt',
        DefaultAOE = '',
        DefaultSpecial = 'Dream Flower',
        DurationMinutes = 60,
    },
    VoraciousAudrey = {
        Name = 'VoraciousAudrey',
        DefaultJug = 'N. Grass. Broth',
        DefaultSTA = '',
        DefaultAOE = 'Soporific',
        DefaultSpecial = 'Gloeosuccus',
        DurationMinutes = 60,
    },
    AmbusherAllie = {
        Name = 'AmbusherAllie',
        DefaultJug = 'L. Mole Broth',
        DefaultSTA = 'Nimble Snap',
        DefaultAOE = 'Cyclotail',
        DefaultSpecial = 'Toxic Spit',
        DurationMinutes = 60,
    },
    PanzerGalahad = {
        Name = 'PanzerGalahad',
        DefaultJug = 'Scarlet Sap',
        DefaultSTA = 'Rhino Attack',
        DefaultAOE = 'Hi-Freq Field',
        DefaultSpecial = 'Rhino Guard',
        DurationMinutes = 60,
    },
    LifedrinkerLars = {
        Name = 'LifedrinkerLars',
        DefaultJug = 'C. Blood Broth',
        DefaultSTA = 'Double Claw',
        DefaultAOE = 'Spinning Top',
        DefaultSpecial = 'Filamented Hold',
        DurationMinutes = 60,
    },
    ChopsueyChucky = {
        Name = 'ChopsueyChucky',
        DefaultJug = 'F. Antica Broth',
        DefaultSTA = 'Mandibular Bite',
        DefaultAOE = 'Venom Spray',
        DefaultSpecial = 'Sandblast',
        DurationMinutes = 60,
    },
    AmigoSabotender = {
        Name = 'AmigoSabotender',
        DefaultJug = 'Sun Water',
        DefaultSTA = 'Needleshot',
        DefaultAOE = '',
        DefaultSpecial = '1000 Needles',
        DurationMinutes = 30,
    },
};

local function HandlePetAction(PetAction)
    gFunc.EquipSet(sets.PetAcc);
end

profile.OnLoad = function()
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /jug /lac fwd zoneinfo JugChange');
end

profile.OnUnload = function()

end

profile.HandleCommand = function(args)
    if (args[1] == 'JugChange') then
        Settings.JugPetSettings.CurrentJug = Settings.JugPetSettings.CurrentJug + 1;

        -- If that index we made is out of bounds of the actual set (like if it's 4 but there's only 3)
        if (Settings.JugPetSettings.CurrentJug > #Settings.JugPetSettings.DefaultJugs) then

            -- Set it back to 1
            Settings.JugPetSettings.CurrentJug = 1;
        end

        sets.Call.Ammo = Settings.JugPetSettings.DefaultJugs[Settings.JugPetSettings.CurrentJug].DefaultJug;
        gFunc.Message('Current Jug: ' .. Settings.JugPetSettings.DefaultJugs[Settings.JugPetSettings.CurrentJug].Name); --display the set
    end
end

--This function is used because when you load the game and for brief moments, like when switching jobs, your levels are counted as 0
--This means if you put your Style Lock in profile.OnLoad(), it'll fail when you first start the game up
profile.LateInitialize = function()
    local timestamp = os.time();
    local player = gData.GetPlayer();

    if timestamp >= Settings.LateInitialized.TimeToUse then
        -- Setting a Style Lock prevents the character from blinking
        -- The delay in setting this is to prevent a failure to set the stylelock on first load
        gFunc.LockStyle(sets.StyleLockGeneric);

        Settings.LateInitialized.Initialized = true;
        gFunc.Message('LateInitialized');
    end
end

profile.HandleDefault = function()
    local timestamp = os.time();
    local zone = gData.GetEnvironment();
    local pet = gData.GetPet();
    local petAction = gData.GetPetAction();
    local player = gData.GetPlayer();
    local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
    local mainWeapon = gData.GetEquipment().Main;
    local subWeapon = gData.GetEquipment().Sub;

    -- Evaluate my sets to account for a level sync
    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.Message('Syncing Gear - Lv. ' .. myLevel);
        Settings.CurrentLevel = myLevel;

        gFunc.EvaluateLevels(profile.Sets, Settings.CurrentLevel);
    end

    -- Check if we need to LateInitialize
    -- If we have not LateInitialize'd, set a timer for 11 seconds then do it after that time has elapsed and never again
    if Settings.LateInitialized.Initialized == false then
        if Settings.LateInitialized.TimeToUse == 0 then
            Settings.LateInitialized.TimeToUse = timestamp + 11;
        else
            profile.LateInitialize();
        end
    end

    gFunc.EquipSet(sets.Default);
    if player.Status == 'Engaged' then
        gFunc.EquipSet(sets.Engaged);
    end
    
    if player.SubJob == 'WHM' or player.SubJob == 'RDM' or player.SubJob == 'BLM' then
        if player.MP >= 70 and player.Status ~= 'Engaged' then
            gFunc.EquipSet(sets.MP);
        elseif player.MP < 50 then
            gFunc.EquipSet(sets.Gaudy);
        end
        if player.Status == 'Resting' then
            gFunc.EquipSet(sets.Relaxing);
        end
    elseif player.SubJob == 'NIN' then
        if player.Status == 'Engaged' then
            gFunc.EquipSet(sets.StealthEarring);
        end
    end

    -- Check if my pet is readying a Ready/Sic move
    if (pet ~= nil) then
        if (petAction ~= nil) then
            HandlePetAction(petAction);
            return;
        end
    end

    -- Equip Gaudy Harness if a Rune Axe is in hand and we have less than 50 mp
    if ((mainWeapon ~= nil and mainWeapon.Name == 'Rune Axe') or (subWeapon ~= nil and subWeapon.Name == 'Rune Axe')) and player.MP < 50 and player.Status == 'Engaged' then
        gFunc.EquipSet(sets.Gaudy);
    end

    -- Put town gear on
    if (zone.Area ~= nil) and (Towns:contains(zone.Area)) then 
        gFunc.EquipSet(sets.IdleTown);
    end
end

profile.HandleAbility = function()
    local pet = gData.GetPet();
    local ability = gData.GetAction();

    gFunc.Message(ability.Name);

    if string.match(ability.Name, 'Call Beast') then
        gFunc.EquipSet(sets.Call);
    elseif string.match(ability.Name, 'Reward') then
        gFunc.EquipSet(sets.RewardHP);
    elseif string.match(ability.Name, 'Charm') then
        gFunc.EquipSet(sets.Charm);
    end
end

profile.HandleItem = function()
    local item = gData.GetAction();
end

profile.HandlePrecast = function()
    local spell = gData.GetAction();

    gFunc.EquipSet(sets.Precast);
end

profile.HandleMidcast = function()
    local spell = gData.GetAction();

    gFunc.Message('Midcast');

    if spell.Skill == 'Enhancing Magic' then
        gFunc.EquipSet(sets.Enhancing);

        if spell.Name == 'Invisible' then
            gFunc.EquipSet(sets.Invisible);
        elseif spell.Name == 'Sneak' then
            gFunc.EquipSet(sets.Sneak);
        end
    elseif spell.Skill == 'Healing Magic' then
        gFunc.EquipSet(sets.Healing);
    end
end

profile.HandlePreshot = function()
    local player = gData.GetPlayer();
end

profile.HandleMidshot = function()
    local player = gData.GetPlayer();
end

profile.HandleWeaponskill = function()
    local action = gData.GetAction();
    local player = gData.GetPlayer();

    gFunc.EquipSet(sets.WeaponSkill);

    if string.contains(action.Name, 'Decimation') or string.contains(action.Name, 'Mistral') or string.contains(action.Name, 'Vorpal') then
        gFunc.EquipSet(sets.WeaponSkillLight);
    end
end

return profile;