local get_abobus = function () if not isSampAvailable() then return end end

require('lib.samp.events').onVehicleStreamIn = function ()
    
end


return
{
    name = 'Автобус',
    icon = 'BUS',
    hint = [[Масла масла для учёных масла,не кикает, варнит]],
    func =
    function()
        sampSendInteriorChange(1)

        BlockSyncJob = true


        
        local x, y, z =  getCharCoordinates(1)
        
        local mimic_pos = {x, y, z }
        local enter_buss = function(id) SendSync{pos = mimic_pos, manual = "vehicle", id = id} end --отправить данные серверу о том, что чар автобусе для получения диалога


        local autobus = function() -- поиск автобуса в зоне стрима и дальнейшая посадка в него
            for i = 0, 2000 do
                local bool, veh = sampGetCarHandleBySampVehicleId(i)
                if bool and doesVehicleExist(veh) and isCarModel(veh, 431) then
                    local x, y, z = getCarCoordinates(veh)
                    sampSendExitVehicle(i)
                    enter_buss(i)

                    return i, x, y, z
                end
            end
            return false
        end


        local dialog_handler = function ()--ОТВЕТ_ДИЛАОГ = nil handler('dialog', {t = 'Автобус'}, 30)
            ОТВЕТ_ДИЛАОГ = nil
            handler('dialog', {t = 'Автобус'}, 30)
        end


        local block_messages = function () -- 'Больше всего народу смогло укрыться в метро.'
            handler('onServerMessage', {text = 'Больше всего народу смогло укрыться в метро.', color = 267386880}, 30)
            handler('onServerMessage', {text = 'Двигайтесь по меткам, останавливайтесь на остановках', color = 267386880}, 30)
            handler('onServerMessage', {text = 'Ваша задача %- эвакуация выживших людей!', color = 267386880}, 30)
        end

        local timer_exit = function (veh_id)
            if not timer.exist("ехит") then
                timer("ехит ", 7, function()
                    if not veh_id then BlockSyncJob = false return end
                    sampSendExitVehicle(veh_id)
                end)
            end
        end

        local t = decodeJson('[[327.48141479492,1347.5455322266,8.2523002624512],[73.975700378418,1200.9187011719,18.081499099731], [-259.15530395508,1198.1284179688,19.190399169922],[-410.47470092773,1015.6484985352,10.630999565125],[-587.46527099609,1100.5399169922,10.77379989624],[-760.25329589844,996.19598388672,15.920499801636],[-1087.3992919922,1445.0825195313,27.73030090332],[-1019.0875854492,1595.1086425781,34.283699035645],[-1176.4724121094,1796.8071289063,39.949401855469],[-1427.4544677734,1849.626953125,34.118900299072],[-1732.3088378906,1823.759765625,23.416999816895],[-1825.9897460938,2142.3132324219,7.1894001960754],[-2002.5010986328,2420.4921875,33.473201751709],[-1793.3894042969,2695.3647460938,57.784801483154],[-1495.1209716797,2730.0004882813,65.29280090332],[-1195.0491943359,2689.0532226563,45.464401245117],[-578.31518554688,2745.3349609375,61.134201049805],[-533.19702148438,2609.72265625,53.010398864746]]')
        local send_pos = function (veh_id)
            for s = 1, #t do
                if (s == #t) or (s > 1) then
                    
                    SendSync{pos = {t[s][1], t[s][2], t[s][3]}, manual = "player"} -- забираем её с ног, чтоб не кикнуло за автобус
                else
                    SendSync{pos = {t[s][1], t[s][2], t[s][3] - 1}, manual = "vehicle", id = veh_id}
                    enter_buss(veh_id) -- my pos save from desaper
                end
            end
        end




     

        local veh_id, x, y, z = autobus()

        if not veh_id then error('Рядом нет автобуса!') return end
        

        
        local how_many = 50
        for i = 1, how_many do

            dialog_handler()

            block_messages()

            timer_exit(veh_id)

            if i ~= 1 then enter_buss(veh_id) end

            while not ОТВЕТ_ДИЛАОГ do wait(0) end

            send_pos(veh_id)
        end

        timer("restore_snc", 3, function()
            BlockSyncJob = false
        end)


        
    end
}


