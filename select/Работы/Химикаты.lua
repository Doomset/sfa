
return
{
    name = 'Химикаты',
    icon = 'BIOHAZARD',
    hint = [[Надо взять работу привезти нефть и прицепить прицеп, не кикает]],
    func =
    function()
        BlockSync = true
        if isCharInAnyCar(PLAYER_PED) then
            local _, carId = sampGetVehicleIdByCarHandle(storeCarCharIsInNoSave(PLAYER_PED))
            sampSendExitVehicle(carId)
            SendSync(248.04029846191 , 1480.2321777344 , 11.588335037231)
            SendSync(224.65727233887 , 1438.2658691406 , 11.566467285156)
            SendSync(-1034.9621582031 , -631.73413085938 , 32.0078125)
            wait(200)
            setCharCoordinates(playerPed, 174.55279541016 , 1454.8707275391 , 10.591223716736)
        end
        BlockSync = false
    end
}