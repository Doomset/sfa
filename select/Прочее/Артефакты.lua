
return
{
    name = 'Артефакты',
    icon = 'WAND_MAGIC_SPARKLES',
    hint = [[Артефакты со сдачей на базе учёных, для учёных онли, не советую вообще что-то из артов юзать(может бан)]],
    func =
    function()
        sampSendChat("/детектор")
        for k, v in pairs(арты_для_сбора) do
            --Сдать_Арты()
            NoKick()
            exSync{pos = {v[1], v[2], v[3]}, p = k, key = 0}
            msg{v[1], v[2], v[3], k}
        end
    end
}