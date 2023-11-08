
return
{
    name = 'ресы',
    icon = 'TRUCK_PICKUP',
    hint = [[Масла масла для учёных масла,не кикает, варнит]],
    func =
    function()
        for i = 1, 100 do
            handler('onServerMessage', {text = 'Но военным это вряд ли понравится!', color = 267386880})
            handler('onServerMessage', {text = 'Загрузитесь ресурсами на Военных складах!', color = 267386880})
            handler('dialog', {t = 'Кража ресурсов'})

            local t = decodeJson('[[339.78118896484,1986.2492675781,17.878799438477],[-765.43530273438,1557.2924804688,27.026699066162]]')
            local id, x, y, z = InCar(448)
            SendSync{ pos = {339.78118896484,1986.2492675781,17.878799438477}, manual = "vehicle", id = id}
            SendSync{ pos = {-765.43530273438,1557.2924804688,27.026699066162}, manual = "vehicle", id = id}
            SendSync{pos = {-759, 1557, 27}, key = 1024}
            wait(30)
        end
    end
}