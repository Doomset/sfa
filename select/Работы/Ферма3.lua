
return
{
    name = 'Ферма3',
    icon = 'TRACTOR',
    hint = [[возьмёт работу с тыквами, нужно будет быть на ферме и самостоятельно сесть в трактор и подцепить сеялку, дальше нажать Тыковки в этой же вкладке ]],
    func =
    function()
        handler('dialog', {t = 'Фермер'})

        local car = carIdByModel(478)


        -- if not doesCharExist(pedFerma) then
        -- 	requestModel(158) -- Запрашиваем модель педа (скин) с нужным id. В данном случае id скина - это скин Messer (Челик в панамке).
        -- 	loadAllModelsNow() -- Загружаем все запрошенные модели
        -- 	handleferma = createCar(478, 0, 0, 0)
        -- 	pedFerma = createCharInsideCar(handleferma, 4, 158)
        -- end

        for k, v in ipairs(getAllObjects()) do
            if doesObjectExist(v) and isObjectInArea3d(v, -1065, -1256, 126, -1122, -1290, 133, false) and getObjectModel(v) == 19320 then
                sampSendExitVehicle(car)
                local _, x, y, z = getObjectCoordinates(v)
                sendCar(car, x, y, z)
                setCarCoordinates(handleferma, x, y, z)
                wait(110)
            end
        end
    end
}