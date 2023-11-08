local imgui = require('mimgui')

local ffi = require('ffi')
local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof
local extra = require('sfa.imgui.extra')

local gui = function ()
    for k, v in ipairs(cfg["Диалоги"]["Список"]) do
        local on, title, button, select, input = new.bool(v.on), new.char[38](u8(v.title)), new.int(v.button), new.int(v.select), new.char[38](u8(v.input))

        if imgui.Checkbox("", on) then
            v.on = not v.on
        end

        imgui.SameLine()

        imgui.PushItemWidth(135)

        --imgui.PushFont(font[12])

        if imgui.InputTextWithHint("##title"..k, u8"заголовок", title, sizeof(title)) then v.title = u8:decode(str(title)); end

        imgui.SameLine()
        
    
        if imgui.InputTextWithHint("##input"..k, "input", input, sizeof(input)) then
            v.input = u8:decode(str(input))
        end

        --imgui.PopFont()
        imgui.PopItemWidth()
        imgui.SameLine()


        imgui.PushItemWidth(25); if imgui.InputInt("##select"..k, select, 0, 0) then
            v.select = select[0]
        end; imgui.PopItemWidth()


        imgui.SameLine()


        imgui.PushItemWidth(18); if imgui.InputInt("##button"..k, button, 0, 0) then
            v.button = button[0]
        end; imgui.PopItemWidth()

    
        imgui.SameLine()
        local col = imgui.GetStyle().Colors[imgui.Col.FrameBg]
        imgui.PushStyleColor(imgui.Col.Button, col)
        if imgui.Button("X", {18, 18}) then table.remove(cfg["Диалоги"]["Список"], k) cfg() end
        imgui.PopStyleColor()

        extra.Separator()

    end



    if imgui.Button("add", {380,15	}) then
    --	msg(resPass)
        table.insert(cfg["Диалоги"]["Список"], lastdialogresponse)

        cfg()					
    end
end

return {"Диалоги", "Уберёт диалоговое окно при подтверждения ставки на лото, ибо нахуй не нужно оно", func = gui}