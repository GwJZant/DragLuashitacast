local profile = {};
local sets = {
    TP = {
        Head = 'Horus\'s Helm',
        Body = 'Scorpion Harness',
    },

    SeiganThirdEye = {
        Head = 'Horus\'s Helm',
        Body = 'Scorpion Harness',
    },

    Gekko = {
        Body = 'Hecatomb Harness',
    },

    Ikasha = {
        Body = 'Hecatomb Harness',
    },

    Yukikaze = {
        Body = 'Hecatomb Harness',
    },

    WeaponSkill = {
        Body = 'Hecatomb Harness',
    },
};
profile.Sets = sets;

profile.Packer = {
};

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
end

profile.OnUnload = function()
end

profile.HandleCommand = function(args)
end

profile.HandleDefault = function()
    local thirdEye = gData.GetBuffCount('Third Eye');
    local seigan = gData.GetBuffCount('Seigan');

    gFunc.EquipSet(sets.TP);

    if thirdEye > 0 then
        gFunc.EquipSet(sets.ThirdEye);
    elseif seigan > 0 then
        gFunc.EquipSet(sets.Seigan);
    end
end

profile.HandleAbility = function()
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
end

profile.HandleMidcast = function()
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
    local action = gData.GetAction();

    if action.Name == 'Tachi: Gekko' then
        gFunc.EquipSet(sets.Gekko);
    elseif action.Name == 'Tachi: Yukikaze' then
        gFunc.EquipSet(sets.Yukikaze);
    elseif action.Name == 'Tachi: Ikasha' then
        gFunc.EquipSet(sets.Ikasha);
    else
        gFunc.EquipSet(sets.WeaponSkill);
    end
    
end

return profile;