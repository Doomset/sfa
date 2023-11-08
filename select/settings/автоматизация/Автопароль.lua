local imgui = require('mimgui')

local ffi = require('ffi')
local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof
local extra = require('sfa.imgui.extra')

local gui = function ()
    local b, b2 = new.bool(cfg["Автопароль"]["Статус"]), new.bool(cfg["Автопароль"]["Любой акк"].on)


    if imgui.Checkbox("status", b) then
        cfg["Автопароль"]["Статус"] = not cfg["Автопароль"]["Статус"]
        cfg()
    end

    extra.Separator()


    for k, v in pairs(cfg["Автопароль"]["Функции"]) do
        if type(v) ~= "table" then
            local b3 = new.bool(v)
            if imgui.Checkbox(u8(k), b3) then
                msg(v)
                cfg["Автопароль"]["Функции"][k] = not cfg["Автопароль"]["Функции"][k]
                cfg()
            end
            
        end
    end


    extra.Separator()
    if imgui.Checkbox(u8"Любой акк", b2) then
        cfg["Автопароль"]["Любой акк"].on = not cfg["Автопароль"]["Любой акк"].on
        cfg()
    end


    imgui.SameLine()

    local pass = new.char[24](cfg["Автопароль"]["Любой акк"].pass)


    imgui.PushItemWidth(110)
    if imgui.InputText("##ap", pass, sizeof(pass)) then
        cfg["Автопароль"]["Любой акк"].pass = str(pass)
        cfg()
    end
    imgui.PopItemWidth()


    imgui.Text("pass, nick, state, del")
    extra.Separator()

    
    for k, v in ipairs(cfg["Автопароль"]["Функции"]["Акки"]) do

        local pass = new.char[24](v.pass)
        local nick = new.char[24](v.nick)
        local on = new.bool(v.on)

        imgui.PushItemWidth(170)
        if imgui.InputTextWithHint("##nick"..k, "nick" ,nick, sizeof(nick)) then
            v.nick = str(nick)
            cfg()
        end
        imgui.PopItemWidth()	

        imgui.SameLine()

        imgui.PushItemWidth(170)
        

        if imgui.InputTextWithHint("##pass"..k, "pass", pass, sizeof(pass)) then
            v.pass = str(pass)
            cfg()
        end
    
        imgui.PopItemWidth()
        imgui.SameLine()

        if imgui.Checkbox("", on) then
            v.on = not v.on
            cfg()
        end
        imgui.SameLine()

        if imgui.Button("X", {18, 18}) then
            table.remove(cfg["Автопароль"]["Функции"]["Акки"], k)
            cfg()
        end
        extra.Separator()
    end


    if imgui.Button("add", {400, 15}) then
    --	msg(resPass)
        table.insert(cfg["Автопароль"]["Функции"]["Акки"], {pass = str(resPass), nick = str(resNick), on = false})

        cfg()					
    end
end

return {"Автопароль", "Примитивный автопароль, при появлении диалога введёт то, что в инпуте", func = gui}