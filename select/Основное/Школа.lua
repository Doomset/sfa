


local act = {
    dialogs = {
        {info = 'ожидание первого диалога', name = 'Школа', pos = {269.54354858398, 120.4239730835, 3004.6171875}, wait = true },
        {info = 'Первый компьютре', name = 'Компьютер', pos = {277.24374389648, 110.52352142334, 3008.8203125}, wait = true },
        {info = 'Второй компьютре', name = 'Компьютер', pos = {255, 115, 3009}, wait = true },
        {info = 'Потушить пожар', name = 'Записка забытая в копире', pos = {277.83584594727, 125.22169494629, 3008.8203125}, wait = true },
        {info = 'Получить метку', name = 'Карта', pos = {260.84017944336, 109.93097686768, 3004.6171875}, wait = true },
    },
    check_def = {
        {info = 'Взять метку', name = 1630.3, pos = {-349.14218139648, 1921.7875976563, 59.548782348633}, wait = true },
    }
}



local raise_error
local catch = function (index, info)
    info = info..' '..act.dialogs[index].name
    pL(info)

    timer('exception', 5)
    while act.dialogs[index].wait do
        -- if not  then error(info..' << ошибка ', 0) end
        assert(timer.exist('exception'), info..' ТАЙМАУТ', 0)
        wait(0)
        assert(not raise_error, raise_error, 0)
    end
    return true
end


local curent_index_for_handler = 0

local last_delay = 0


addEventHandler('onReceiveRpc', function(id, bs)
    if IsAnyFuncActiove then
        if id == 61 then
            local did = raknetBitStreamReadInt16(bs)
            local style = raknetBitStreamReadInt8(bs)
            local title = raknetBitStreamReadString(bs, raknetBitStreamReadInt8(bs))
            local btn1 = raknetBitStreamReadString(bs, raknetBitStreamReadInt8(bs))
            local btn2 = raknetBitStreamReadString(bs, raknetBitStreamReadInt8(bs))
            local stri = raknetBitStreamDecodeString(bs, 4096)

            if title:find(act.dialogs[curent_index_for_handler].name) then
                sampSendDialogResponse(did, 1, 0, '')
                local is_cd = stri:match(': Осталось (%d+)')

                if is_cd then raise_error = 'В школе кд! Ещё осталось '..is_cd return false end

                last_delay = 4000
                act.dialogs[curent_index_for_handler].wait = false
               
              
                return false
            end
        elseif id == 107 then
            local x, y, z = raknetBitStreamReadFloat(bs), raknetBitStreamReadFloat(bs), raknetBitStreamReadFloat(bs)
            if shortPos(x, y, z) == act.check_def[1].name then
                Noti('Checkpoint')
                act.check_def[1].wait = false
            end
        end
    end
end)


local body = {
    name = 'Школа',
    icon = 'SCHOOL',
    hint = [[Тайник школьника, делается примерно секунд за 15,отправляет раз в 3.3 секунды фейк позицию
    на время выполнения функции можно какать, пукать, играть]],
    func =
    function()
        handler('player_pos', {3389.5})

        local parse = function (t)
            for k, v in ipairs(t) do
                curent_index_for_handler = k
                NoKick()
                wait(0)
                SendSync{pos = v.pos, key = 1024, force = true}
                if catch(k, v.info) then wait(last_delay) end
            end
        end
        parse(act.dialogs)

        parse(act.check_def)
       
        -- handler("player_pos", {3389.5})
        -- for k, v in ipairs{"Школа", "Компьютер", "Компьютер", "Записка", "Карта"} do
        --     handler("dialog", {t = v}, 55)
        -- end
        -- sendPos{t = coords, delay = 5000, key = 1024}
    end
}

return body


