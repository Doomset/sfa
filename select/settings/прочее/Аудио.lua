local imgui = require('mimgui')

local ffi = require('ffi')
local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof
local gui = function ()
    for k, v in ipairs(cfg["����������� � �����"]["������"]) do

        local url, on = new.char[28](u8(v.url)), new.bool(v.on)

        if imgui.Checkbox("", on) then v.on = not v.on end


        imgui.SameLine()
        

    
        imgui.PushItemWidth(70); if imgui.InputText("##input"..k, url, sizeof(url)) then v.url = str(url) end; imgui.PopItemWidth()

    end


    imgui.SameLine()

    for k, v in ipairs(cfg["����������� � �����"]["�����"]) do
        local id, on = new.int(v.id), new.bool(v.on)

        if imgui.Checkbox("", on) then v.on = not v.on cfg() end


        imgui.SameLine()
        

    
        imgui.PushItemWidth(43); if imgui.InputInt("##select"..k, id, 0, 0) then v.id = id[0] cfg() end; imgui.PopItemWidth()
    end


    if imgui.Button("add", {120,20	}) then


        table.insert(cfg["����������� � �����"]["�����"], lastSoundId)
        table.insert(cfg["����������� � �����"]["������"], lastAudioStream)

        cfg()					
    end

end

return  {"�����",  "��������� �������� ����� ���� �����������, � ������� � ������� �� ����� ������ ������ ������", func =  gui}