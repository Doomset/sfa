
return
{
    name = 'Лесопилка',
    icon = 'TREE',
    hint = [[Нужно быть на лесопилке, аккуратней с людьми рядом]],
    func =
    function()
        NoKick()
        handler('dialog', {t = 'Лесоповал'})
        SendSync{ pos = {-564, -181, 78}, pick = cfg['Пикапы']['-666.68'].id, force = true}

        for i=1, 25 do
            for k, v in ipairs(getAllObjects()) do
                if doesObjectExist(v) and  getObjectModel(v) == 696 then
                    local _, x, y, z  = getObjectCoordinates(v)
                    --msg(v)
                    SendSync{pos = {x, y, z}, key = 126, weapon = 9}
                    SendSync{pos = {x, y, z}, key = 0, weapon = 0}
                    --SendSync{pos = {-1571, 2247, 57}}
                end
            end
            wait(40)
        end

        job(function()
            local id, x, y, z = InCar(578)
            SendSync{pos = {-555.32574462891 , -85.297897338867 , 64.372024536133}, manual = "vehicle", id = id}
            SendSync{pos = {808.12365722656 , 1661.1018066406 , 5.9064102172852}, manual = "vehicle", id = id}
            SendSync{pos = {-534.85546875 , -177.46928405762 , 78.404663085938}, manual = "vehicle", id = id}
        end)
    end
}