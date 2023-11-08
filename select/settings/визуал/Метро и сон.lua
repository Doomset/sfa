
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

    imgui.menu_bar_child(u8"Метро и сон", {160, 100}, function()
        menu_bar(function() imgui.Text("metro i son") end)
        imgui.SetCursorPosY(25)
        for k, v in pairs(cfg["Метро и сон"]["Функции"]) do
            local bool = new.bool(v)
            if imgui.Checkbox(u8(k), bool) then
                cfg["Метро и сон"]["Функции"][k] = not cfg["Метро и сон"]["Функции"][k]	
                cfg()
            end				
        end
    end)

    imgui.SameLine( 160 + 20 )


    


    imgui.menu_bar_child(u8"пикапы", {160, 100}, function()
        menu_bar(function() imgui.Text(u8"пикапы") end)
        local b, b2 = new.bool(cfg["Блок пикапов"]["Радар"]), new.bool(cfg["Блок пикапов"]["Исполка"])
        if imgui.Checkbox(u8("Радар"), b) then
            cfg["Блок пикапов"]["Радар"] = not cfg["Блок пикапов"]["Радар"]
        end
        if imgui.Checkbox(u8("Исполка"), b2) then
            cfg["Блок пикапов"]["Исполка"] = not cfg["Блок пикапов"]["Исполка"]
        end
    end)

    imgui.Text(u8"зарплата")
    imgui.Text(u8"антиафк")

    imgui.Text(u8"")
    imgui.Text(u8"")
    imgui.Text(u8"")

    
end

return {"Метро и сон", "Отключить затемнение в метро и черный экран от сна", func = gui}