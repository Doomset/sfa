local imgui = nil

local icon_button = require('sfa.imgui.icon').Button
local input = require('sfa.imgui.extra').input()






local t = {}
for k, v in pairs(cfg["������"]) do
    table.insert(t, {p = {v.pos[1], v.pos[2], v.pos[3]}, n = v.name, id = v.id})
end
table.sort(t, function(a,b ) return a.n < b.n end)


local gui = function ()

    if not imgui then imgui = require("mimgui") end
    
    imgui.PushFont(font[16])
    
    imgui.SetCursorPos{100, 3}
    input:render({200, 15})	

    local sb = {input:active() and 430 or 135, 15}

    
    if not input:active() then

        imgui.SetCursorPos{60, 3}
        if imgui.BoolText(selectMesta == 1, u8"�����") then selectMesta = 1 end

        imgui.SameLine(290)
        if imgui.BoolText(selectMesta == 2, u8"������") then selectMesta = 2 end
    end

    imgui.PopFont()

    
    imgui.PushStyleVarVec2(imgui.StyleVar.ItemSpacing, imgui.ImVec2(5, 0.5))

    imgui.BeginChild("Mesta")

    imgui.PushFont(font[14])	



    for k, v in ipairs(selectMesta == 1 and cfg["�����"] or t) do
        imgui.PushIDInt(k)
        if input:filt(v.n) then
            if input:active() then imgui.SetCursorPosX(imgui.GetWindowSize().x /2 - sb[1] / 2) end

            if ((input.is_clicked and #input.chars > 0) and imgui.IsItemClicked(0) or (icon_button(u8(v.n), sb))) then
                input:null()
                NoKick()
                setCharCoordinates(PLAYER_PED, v.p[1], v.p[2], v.p[3])

                Noti(string.format('�������� �� ���������� - %1.f, %1.f, %1.f %s[%d]', v.p[1], v.p[2], v.p[3], v.n, v.id), OK)
            elseif imgui.IsItemHovered() and imgui.IsMouseDoubleClicked(1) then
                NoKick()
                Noti(string.format('��������� ����� c ���� �������� - %s[%d]', v.n, v.id), INFO)
                SendSync{pos = {v.p[1], v.p[2], v.p[3]}, pick = v.id, force = true}
            end




            if k%3 ~= 0  and not input:active() then imgui.SameLine() end
        end
        imgui.PopID()
    end

    if imgui.Button(u8("�������� ����� +"), sb) then 
        mesta_name, mesta_text = new.char[28](u8""), new.char[28](u8"")
        imgui.OpenPopup("mesta")
    end

    if imgui.BeginPopupModal("mesta", _, imgui.WindowFlags.NoCollapse) then
        imgui.Text(u8'����??��� �����:')
        imgui.SameLine(138)
        imgui.PushItemWidth(175)
        imgui.InputText('##mesteditor', mesta_name, sizeof(mesta_name))
        imgui.PopItemWidth()
        imgui.Text(u8'���������� �����: ')
        imgui.SameLine()
        imgui.PushItemWidth(135)
        imgui.InputText('##mesteditortext', mesta_text, sizeof(mesta_text))
        imgui.PopItemWidth()  
        imgui.SetCursorPosX( (imgui.GetWindowWidth() - 300 - imgui.GetStyle().ItemSpacing.x) / 2 )
        local myposX, myposY, myposZ = getCharCoordinates(PLAYER_PED)
        if not core["������"]["��� �����"][0] then imgui.StrCopy(mesta_text, string.format("%.0f, %.0f, %.0f, %d", myposX, myposY, myposZ, 0)) end
        imgui.SameLine(282)
        icon_checkbox(u8"##���� ����������", core["������"]["��� �����"])
    --	imgui.Hint(u8"���� ������, ����� ����������, ��� �� ���������� ���������� ������ � �??����� x, y, z, 0, ������������� �������, ������ � ������� ��� �����", u8"���� ������, ����� ����������, ��� �� ���������� ���������� ������ � ������� x, y, z, 0, ������������� �������, ������ � ������� ��� �����")
        if #str(mesta_name) > 0 and #str(mesta_text) > 0 then
            if imgui.Button(u8'���������##mesteditor', imgui.ImVec2(150, 25)) then
                table.insert(cfg["�����"], {
                    n = u8:decode(str(mesta_name)),
                    p = {myposX, myposY, myposZ}
                })

                cfg()
                imgui.CloseCurrentPopup()
            end
        else
        --	imgui.LockedButton(u8'���������', imgui.ImVec2(150, 25))
        --	imgui.Hint(u8'������� �� ��� ���������', u8'������� �� ��� ���������')
        end
        ---imgui.SameLine()
        if imgui.Button(u8'��������', imgui.ImVec2(200, 15)) then imgui.CloseCurrentPopup() end
    
        imgui.EndPopup()
    end
    imgui.PopFont()
    imgui.EndChild()
    
    imgui.PopStyleVar()
end



return {'����� ', 'MAP', true,  "��� ��������� ����� ������������� �������� ��������� ������ ��, ������� ��������� ����� ��������� ���� �������", gui}