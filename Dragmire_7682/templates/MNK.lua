local Settings = {
    CurrentLevel = 0,
    TP = 'DD',
    LockFish = false,
};
local profile = {};
local sets = {
    Idle_Priority = {
        Head = {'Arh. Jinpachi +1'},
        Neck = {'Evasion Torque'},
        Ear1 = {'Ethereal Earring'},
        Ear2 = {'Suppanomimi'},
        Body = {'Arhat\'s Gi +1'},
        Hands ={'Dst. Mittens +1'},
        Ring1 ={'Jelly Ring'},
        Ring2 ={'Sattva ring'},
        Back = {'Boxer\'s Mantle'},
        Waist ={'Black Belt'},
        Legs = {'Dst. Subligar +1'},
        Feet = {'Dst. Leggings +1'},
    },

    EngagedTP_Priority = {
        Ammo = {'Tiphia Sting'},
	    Head = {'Panther Mask +1'},
	    Neck = {'Faith Torque'},
	    Ear1 = {'Brutal Earring'},
	    Ear2 = {'Diabolos\'s Earring'},
	    Body = {'Shura Togi'},
	    Hands ={'Bandomusha Kote'},
	    Ring1 ={'Toreador\'s Ring'},
	    Ring2 ={'Toreador\'s Ring'},
	    Back = {'Forager\'s Mantle'},
	    Waist ={'Black Belt'},
	    Legs = {'Byakko\'s Haidate'},
	    Feet = {'Fuma Kyahan'},
    },

    EngagedTank_Priority = {
        Ammo = {'Fenrir\'s Stone'},
        Head = {'Optical Hat'},
        Neck = {'Guarding Torque'},
        Ear1 = {'Ethereal Earring'},
        Ear2 = {'Guarding Earring'},
        Body = {'Scorpion Harness'},
        Hands ={'Raven Bracers'},
        Ring1 ={'Jelly Ring'},
        Ring2 ={'Sattva ring'},
        Back = {'Boxer\'s Mantle'},
        Waist ={ 'Black Belt'},
        Legs = {'Temple Hose'},
        Feet = {'Melee Gaiters'},
    },

    WyvernEarring_Priority = {
        Ear2 = {'Wyvern Earring'},
    },

    ChiBlast_Priority = {
        Head = {'Temple Crown'},
        Neck = {'Faith Torque'},
        Ear1 = {'Merman\'s Earring'},
        Ear2 = {'Merman\'s Earring'},
        Body = {'Kirin\'s Osode'},
        Hands ={'Bandomusha Kote'},
        Ring1 ={'Flame Ring'},
        Ring2 ={'Puissance Ring'},
        Back = {'Ryl. Army Mantle'},
        Waist ={'Friar\'s Rope'},
        Legs = {'Savage Loincloth'},
        Feet = {'Suzaku\'s Sune-Ate'},
    },

    Chakra_Priority = {
        Body = {'Temple Cyclas'},
        Hands = {'Melee Gloves'},
        Waist = {'Warwolf Belt'},
        Ring2 ={'Sattva ring'},
    },

    Boost_Priority = {
        Hands = {'Temple Gloves'},
    },

    Focus_Priority = {
        Head = {'Temple Crown'},
    },

    Dodge_Priority = {
        Feet = {'Temple Gaiters'},
    },

    Counterstance_Priority = {
        Feet = {'Melee Gaiters'},
    },

    HundredFists_Priority = {
        Head = {'Optical Hat'},
	    Neck = {'Faith Torque'},
	    Ear1 = {'Brutal Earring'},
	    Ear2 = {'Ethereal Earring'},
	    Body = {'Shura Togi'},
	    Hands ={'Bandomusha Kote'},
	    Ring1 ={'Toreador\'s Ring'},
	    Ring2 ={'Toreador\'s Ring'},
	    Back = {'Forager\'s Mantle'},
	    Waist ={'Life Belt'},
	    Legs = {'Shura Haidate'},
	    Feet = {'Savage Gaiters'},
    },

    Jump_Priority = {
	    Head = {'Optical Hat'},
	    Neck = {'Faith Torque'},
	    Ear1 = {'Brutal Earring'},
	    Ear2 = {'Diabolos\'s Earring'},
	    Body = {'Shura Togi'},
	    Hands = {'Bandomusha Kote'},
	    Ring1 = {'Toreador\'s Ring'},
	    Ring2 = {'Toreador\'s Ring'},
	    Back = {'Wyvern Mantle'},
	    Waist = {'Life Belt'},
	    Legs = {'Shura Haidate'},
	    Feet = {'Savage Gaiters'},
    },

    Charm_Priority = {
        Head = {'Panther Mask +1'},
	    Neck = {'Star Necklace'},
	    Body = {'Kirin\'s Osode'},
	    Ring1 = {'Hope Ring'},
	    Ring2 = {'Hope Ring'},
	    Back = {'Trimmer\'s Mantle'},
        Feet = {'Savage Gaiters'},
    },

    WeaponSkill_Priority = {
	    Head = {'Shura Zunari Kabuto'},
	    Neck = {'Faith Torque'},
	    Ear1 = {'Brutal Earring'},
	    Ear2 = {'Merman\'s Earring'},
	    Body = {'Kirin\'s Osode'},
	    Hands ={'Bandomusha Kote'},
	    Ring1 ={'Toreador\'s Ring'},
	    Ring2 ={'Flame Ring'},
	    Back = {'Forager\'s Mantle'},
	    Waist ={'Black Belt'},
	    Legs = {'Shura Haidate'},
	    Feet = {'Savage Gaiters'},
    },

    DragonKick_Priority = {
	    Head = {'Shura Zunari Kabuto'},
	    Neck = {'Faith Torque'},
	    Ear1 = {'Brutal Earring'},
	    Ear2 = {'Merman\'s Earring'},
	    Body = {'Kirin\'s Osode'},
	    Hands ={'Bandomusha Kote'},
	    Ring1 ={'Toreador\'s Ring'},
	    Ring2 ={'Flame Ring'},
	    Back = {'Forager\'s Mantle'},
	    Waist ={'Black Belt'},
	    Legs = {'Shura Haidate'},
	    Feet = {'Dune Boots'},
    },

    AsuranFists_Priority = {
        Head = {'Shura Zunari Kabuto'},
        Neck = {'Faith Torque'},
        Ear1 = {'Brutal Earring'},
        Ear2 = {'Merman\'s Earring'},
        Body = {'Shura Togi'},
        Hands ={'Bandomusha Kote'},
        Ring1 ={'Toreador\'s Ring'},
        Ring2 ={'Toreador\'s Ring'},
        Back = {'Forager\'s Mantle'},
        Waist ={'Life Belt'},
        Legs = {'Shura Haidate'},
        Feet = {'Savage Gaiters'},
    
    },

    Fishing = {
        Body = 'Angler\'s Tunica',
        Hands = 'Angler\'s Gloves',
        Legs = 'Angler\'s Hose',
        Feet = 'Angler\'s Boots',
    },
    
    Sneak = {
        Feet = 'Dream Boots +1',
    },

    Invisible = {
        Hands = 'Dream Mittens +1',
    },
};

profile.Sets = sets;

profile.Packer = {
};

profile.OnLoad = function()
    gSettings.AllowAddSet = true;

    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /tp /lac fwd tp ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /fsh /lac fwd fsh ');
end

profile.OnUnload = function()
end

profile.HandleCommand = function(args)
    if (args[1] == 'tp') then
        if Settings.TP == 'DD' then
            Settings.TP = 'Tank';
        else
            Settings.TP = 'DD';
        end

        gFunc.Message('tp ' .. Settings.TP);
    elseif (args[1] == 'fsh') then
        Settings.LockFish = not Settings.LockFish;

        gFunc.Message('Fishing: ' .. tostring(Settings.LockFish));
    end
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
    local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
    local hf = gData.GetBuffCount('Hundred Fists');
    local asleep = gData.GetBuffCount('Sleep');

    -- Evaluate my sets to account for a level sync
    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.Message('Syncing Gear - Lv. ' .. myLevel);
        Settings.CurrentLevel = myLevel;

        gFunc.EvaluateLevels(profile.Sets, Settings.CurrentLevel);
    end

    gFunc.EquipSet(sets.Idle);

    if player.Status == 'Engaged' then
        if Settings.TP == 'DD' then
            gFunc.EquipSet(sets.EngagedTP);
        elseif Settings.TP == 'Tank' then
            gFunc.EquipSet(sets.EngagedTank);
        end

        if player.SubJob == 'DRG' then
            gFunc.EquipSet(sets.WyvernEarring);
        end

        if hf == 1 then
            gFunc.EquipSet(sets.HundredFists);
        end
    end

    if asleep > 0 and Settings.CurrentLevel >= 61 then
        gFunc.Equip('Neck', 'Opo-opo Necklace');
    end

    if Settings.LockFish then
        gFunc.EquipSet(sets.Fishing);
    end
end

profile.HandleAbility = function()
    local action = gData.GetAction();

    if action.Name == 'Boost' then
        gFunc.EquipSet(sets.Boost);
    elseif action.Name == 'Focus' then
        gFunc.EquipSet(sets.Focus);
    elseif action.Name == 'Dodge' then
        gFunc.EquipSet(sets.Dodge);
    elseif action.Name == 'Chakra' then
        gFunc.EquipSet(sets.Chakra);
    elseif action.Name == 'Counterstance' then
        gFunc.EquipSet(sets.Counterstance);
    elseif action.Name == 'Chi Blast' then
        gFunc.EquipSet(sets.ChiBlast);
    elseif action.Name == 'Charm' then
        gFunc.EquipSet(sets.Charm);
    elseif action.Name == 'Jump' then
        gFunc.EquipSet(sets.Jump);
    elseif action.Name == 'High Jump' then
        gFunc.EquipSet(sets.Jump);
    end
end

profile.HandleItem = function()
    local item = gData.GetAction();

    gFunc.EquipSet(sets.EngagedTank);

	if item.Name == 'Silent Oil' then 
        gFunc.EquipSet(sets.Sneak);
    elseif item.Name == 'Prism Powder' then 
        gFunc.EquipSet(sets.Invisible);
    end
end

profile.HandlePrecast = function()
end

profile.HandleMidcast = function()
    local spell = gData.GetAction();

    if spell.Name == 'Invisible' then
        gFunc.EquipSet(sets.Invisible);
    elseif spell.Name == 'Sneak' then
        gFunc.EquipSet(sets.Sneak);
    end
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
    local action = gData.GetAction();

    gFunc.EquipSet(sets.WeaponSkill);

    if action.Name == 'Dragon Kick' then
        gFunc.EquipSet(sets.DragonKick);
    elseif action.Name == 'Asuran Fists' then
        gFunc.EquipSet(sets.AsuranFists);
    end
end

return profile;