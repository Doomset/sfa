
return
{
    name = 'Бензин',
    icon = 'GAS_PUMP',
    hint = [[Бензин, не кикает, варнит и отправляет H на военные склады для заправки ]],
    func =
    function()
        handler('dialog', {t = 'Заправка'})
        if isCharInAnyCar(PLAYER_PED) then
            local _, carId = sampGetVehicleIdByCarHandle(storeCarCharIsInNoSave(PLAYER_PED))
            sampSendExitVehicle(carId)
            SendSync{ pos = {609.53570556641, 1699.6492919922, 6.5921440124512}, key =  2}
        else
            error('Надо быть в транспорте', 3)
        end
    end
}