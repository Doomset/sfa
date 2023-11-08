local imgui = require('mimgui')

local ffi = require('ffi')
local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof
local extra = require('sfa.imgui.extra')

local gui = function ()
    local b, b2 = new.bool(cfg["����������"]["������"]), new.bool(cfg["����������"]["����� ���"].on)


    if imgui.Checkbox("status", b) then
        cfg["����������"]["������"] = not cfg["����������"]["������"]
        cfg()
    end

    extra.Separator()


    for k, v in pairs(cfg["����������"]["�������"]) do
        if type(v) ~= "table" then
            local b3 = new.bool(v)
            if imgui.Checkbox(u8(k), b3) then
                msg(v)
                cfg["����������"]["�������"][k] = not cfg["����������"]["�������"][k]
                cfg()
            end
            
        end
    end


    extra.Separator()
    if imgui.Checkbox(u8"����� ���", b2) then
        cfg["����������"]["����� ���"].on = not cfg["����������"]["����� ���"].on
        cfg()
    end


    imgui.SameLine()

    local pass = new.char[24](cfg["����������"]["����� ���"].pass)


    imgui.PushItemWidth(110)
    if imgui.InputText("##ap", pass, sizeof(pass)) then
        cfg["����������"]["����� ���"].pass = str(pass)
        cfg()
    end
    imgui.PopItemWidth()


    imgui.Text("pass, nick, state, del")
    extra.Separator()

    
    for k, v in ipairs(cfg["����������"]["�������"]["����"]) do

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
            table.remove(cfg["����������"]["�������"]["����"], k)
            cfg()
        end
        extra.Separator()
    end


    if imgui.Button("add", {400, 15}) then
    --	msg(resPass)
        table.insert(cfg["����������"]["�������"]["����"], {pass = str(resPass), nick = str(resNick), on = false})

        cfg()					
    end
end

return {"����������", "����������� ����������, ��� ��������� ������� ����� ��, ��� � ������", func = gui}