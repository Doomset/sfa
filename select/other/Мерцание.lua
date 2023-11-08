local extra = require('sfa.imgui.extra')
local imgui = require('mimgui')
local ffi = require('ffi')
local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof



local Актор = function(id, gun)
    local bs = raknetNewBitStream()
    raknetBitStreamWriteBool(bs, false) -- bool
    raknetBitStreamWriteInt16(bs, id) -- actor id
    raknetBitStreamWriteFloat(bs, 1)   --damage
    raknetBitStreamWriteInt32(bs, gun) -- flowers
    raknetBitStreamWriteInt32(bs, 3)   -- tors
    raknetSendRpc(177, bs); raknetDeleteBitStream(bs)
end


local gui = function ()
    if not imgui then imgui = require('mimgui') end
    
    if not core["Прочее"]["Мерцание"] then
        core["Прочее"]["Мерцание"] = new.int(600)
    end

    local center = imgui.GetWindowSize().x / 2

    local burer = function(x)
        for i = 1, x do; Актор(cfg["Бюрер"], 24) end
    end

    extra.centerText(u8"Выбери, сколько отправить урон", false, false)

    imgui.NewLine()
    local mercanie = {100, 200, 300, 400, 500}
    imgui.SetCursorPosX(center - (80*5) / 2)
    imgui.PushStyleVarVec2(imgui.StyleVar.ItemSpacing, imgui.ImVec2(0.0, -1))
    for i = 1, #mercanie do
        if imgui.Button(tostring(mercanie[i]), imgui.ImVec2(80, 20)) then
            burer(mercanie[i])
        end
        if i >= 1 and i <= 4 then
            imgui.SameLine()
        end
    end
    imgui.PopStyleVar()
    imgui.NewLine()
    imgui.PushItemWidth(-1)
    --imgui.InputInt(u8'##money', core["Прочее"]["Мерцание"], 0, 0)


    imgui.SliderInt(u8'##money', core["Прочее"]["Мерцание"], 1, 600)

--			imgui.SliderInt2(u8'##money', core["Прочее"]["Мерцание"], 1, 600)

    imgui.PopItemWidth()

    if core["Прочее"]["Мерцание"][0] > 600 then core["Прочее"]["Мерцание"][0] = 600 end
    if core["Прочее"]["Мерцание"][0] < 1 then core["Прочее"]["Мерцание"][0] = 1 end
    imgui.NewLine()
    imgui.SetCursorPosX(center - 250 / 2)
    
    
    if imgui.Button(u8'Отправить', imgui.ImVec2(250, 20)) then
        burer(core["Прочее"]["Мерцание"][0])
    end
    imgui.NewLine()
end

return 
{"Мерцание ", 'CIRCLE_RADIATION',  true, "Если нажать мать не сдохнет и никого не заварнит, так же сама функция не варнит, но лучше хотя бы секунды ждать от предыдущей отправки урона", gui}