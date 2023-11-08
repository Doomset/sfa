
local imgui = require('mimgui')

local ffi = require('ffi')
local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof
local gui = function ()

    local menu_bar = function(func)
        if imgui.BeginMenuBar() then
            func()
            imgui.EndMenuBar()
        end
    end


    imgui.SetCursorPos{6, 6}

    imgui.menu_bar_child(u8"����� � ���", {160, 100}, function()
        menu_bar(function() imgui.Text("metro i son") end)
        imgui.SetCursorPosY(25)
        for k, v in pairs(cfg["����� � ���"]["�������"]) do
            local bool = new.bool(v)
            if imgui.Checkbox(u8(k), bool) then
                cfg["����� � ���"]["�������"][k] = not cfg["����� � ���"]["�������"][k]	
                cfg()
            end				
        end
    end)

    imgui.SameLine( 160 + 20 )


    


    imgui.menu_bar_child(u8"������", {160, 100}, function()
        menu_bar(function() imgui.Text(u8"������") end)
        local b, b2 = new.bool(cfg["���� �������"]["�����"]), new.bool(cfg["���� �������"]["�������"])
        if imgui.Checkbox(u8("�����"), b) then
            cfg["���� �������"]["�����"] = not cfg["���� �������"]["�����"]
        end
        if imgui.Checkbox(u8("�������"), b2) then
            cfg["���� �������"]["�������"] = not cfg["���� �������"]["�������"]
        end
    end)

    imgui.Text(u8"��������")
    imgui.Text(u8"�������")

    imgui.Text(u8"")
    imgui.Text(u8"")
    imgui.Text(u8"")

    
end

return {"����� � ���", "��������� ���������� � ����� � ������ ����� �� ���", func = gui}