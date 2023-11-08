
local imgui = require('mimgui')

local ffi = require('ffi')
local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof
local extra = require('sfa.imgui.extra')
local gui = function ()
    imgui.PushItemWidth(300)

    for k, v in ipairs(cfg["Спам"]["Строки"]) do
        local char = new.char[200](u8(v.text))

        
        local c = extra.U32ToImVec4(bit.rshift(v.color, 8))


        local col = imgui.GetStyle().Colors[imgui.Col.FrameBg]


        imgui.PushStyleColor(imgui.Col.Button, col)
        if imgui.Button("X", {18, 18}) then table.remove(cfg["Спам"]["Строки"], k) cfg() end
        imgui.PopStyleColor()


        imgui.SameLine()


        imgui.PushStyleColor(imgui.Col.Text, c)

        local p = imgui.GetCursorPos()
        if imgui.InputText("##words"..k, char, sizeof(char)) then
            v.text = u8:decode(str(char))
        end
        extra.Separator()


        imgui.PopStyleColor()

        
    end	
    imgui.PopItemWidth()


    if imgui.Button("add") then
        table.insert(cfg["Спам"]["Строки"], lastservermsg)
        cfg()
    end


end

return {"Спам", "Строчки про тайник цербера и урок обж от дежурного, и сообщение о сделаной ставке на лото не будут показываться", func = gui}