local imgui = require('mimgui')


local icon = require('sfa.imgui.icon')
local icon_checkbox = icon.Checkbox

local extra = require('sfa.imgui.extra')
local ffi = require('ffi')
local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof

imgui.BoolText = extra.BoolText

imgui.menu_bar_child = function(name, size, func)
	imgui.BeginChild(name, size, true, imgui.WindowFlags.MenuBar)
	func()
	imgui.EndChild()
end 


core = {
	["������"] = {
		["��� �����"] = new.bool(0),
		["������"] =
		{
			id = new.int(0),
			{'�������', 'PERSON',  false, "�������� ������ � ������, � ������� ����� ������ �� ���������, ��� ������"},
			{'���������', 'LOCATION_DOT', false,  "��� ��������� ����� ������������� �������� ��������� ������ ��, ������� ��������� ����� ��������� ���� �������"},
			{'���', 'XMARK',  false, "�������� �������� � ������ � ������� ���� ������ ����� ����� � ����� ����� � ������, ��� ���������"},
			{'���2', 'XMARK',  false, "���� �� ���������� �������� � �� � �������� � ����������"},
			{'����� � ���', 'ICON_EYE_SLASH',  false, "�� � ���� ������, �� �������"},				
			{'����� �����', 'LOW_VISION',  false, "����������� ����� ������ ���� ������"},
			{'���� �������', 'ICON_COINS',  false, "���� /������� ��� � �������"},							
			{'���� �������', 'ICON_COINS',  false, "����� ������ ������� /�������� � �������� ��� 1 - 3 �����"},				
			{'���', 'ICON_COINS',  false, "������� ������� ��� ������/���������/����������� ����������� �������"},
			

			
		},
	},
}
local ac = require('sfa.samp.zona.AntiCheat').scan
CHECK = function (veh)
                            

    timer('AntiCheat - prochee - checkcars', 0.9,

    function (self)
        local exist = self.exist('Anticheat-prochee-Surf-ON')
        veh = ac()
        if exist and veh then self.remove('Anticheat-prochee-Surf-ON') end

        if veh then
            core["������"].������[1][1] = "timeout(CAR)"

            core["������"].������[1][2] = "CAR"

            sampSendExitVehicle(veh)


            timer('Anticheat-prochee-CAR-ON', 6, function ()
                core["������"].������[1][1] = "CAR"
                core["������"].������[1][2] = "CAR"

                local veh = ac()

                if veh then CHECK(veh) else SURF() end
            end)

        else
          SURF()
        end
        
    end)

end




SURF = function ()
                        
    SurfingSync = true
    sampForceOnfootSync()
    core["������"].������[1][1] = "surf"
    core["������"].������[1][2] = "PERSON"

    timer('Anticheat - prochee--Surf-OFF', 2, function ()
         SurfingSync = false
         msg('pff')
         core["������"].������[1][2] = "PERSON"
         core["������"].������[1][1] = "timeout(SURF)"

        timer('Anticheat-prochee-Surf-ON', 6, CHECK)

    end)

end



local bank, sync2




local gui = function ()

    local sync_gui = function ()
        imgui.SetCursorPos{8, 6}
        imgui.menu_bar_child("Sync manipulate", {150, 260}, function()
            imgui.PushFont(font[13])
            if imgui.BeginMenuBar() then
                imgui.Text("HITLER ALIVE!!!!")
                imgui.EndMenuBar()
            end
            local p = imgui.GetCursorScreenPos()
            local col = imgui.GetColorU32Vec4(extra.setAlpha(imgui.GetStyle().Colors[imgui.Col.ChildBg], 0.5))
            local col2 = imgui.GetStyle().Colors[imgui.Col.ChildBg]
            local col2 = imgui.GetColorU32Vec4({col2.x, col2.y, col2.z, 0.3})
            imgui.GetWindowDrawList():AddRectFilledMultiColor(p, {p.x + imgui.GetWindowSize().x, p.y + imgui.GetWindowSize().y}, col, col, col2, col2);
            
            for k, v in ipairs(core["������"]["������"]) do
                local b = new.bool(v[3])
                
                local p = imgui.GetCursorPos()

                local res = icon_checkbox(u8(v[1]), b, v[2])

                if res then

                    v[3]= not v[3]
                    if v[1] == "�������" then

                        

                       


                       

                        CHECK()
                        
                        --    


                        if b[0] == false then -- nerabotait
                            msg('pf1f')
                            local exist = timer.exist('Anticheat-prochee-Surf-ON')
                            local exist2 = timer.exist('Anticheat-prochee-CAR-ON')

                            if exist then timer.remove('Anticheat-prochee-Surf-ON') end
                            core["������"].������[1][1] = "AntiCheat"
                            if exist2 then timer.remove('Anticheat-prochee-CAR-ON') end
                        end
                        
                        
                    end
                    print(res)
            
                end


                
                extra.Separator(-1.5)
            end
            imgui.PopFont()
        end)
    end


    local bank_gui = function ()
        local poschild = imgui.GetCursorPos()

        imgui.SameLine(poschild.x + 173)
    
        local mp = imgui.GetCursorPos()
    
    
        local two_childs = {249, 123.5}
    
        imgui.menu_bar_child("BANK INTERFACE", two_childs, function()
    
            if not bank then bank = {money = new.int(0), id = new.int(0)} end


            local id, mon = bank.id, bank.money

            local connect = false
            if sampIsPlayerConnected(id[0]) then connect = true end
            local text = connect and sampGetPlayerNickname(id[0]) or u8"��������� �����"
            local _, r, g, b = extra.explode_argb(sampGetPlayerColor(id[0]))
    
            if imgui.BeginMenuBar() then
                extra.centerText(text, -1.5, {r / 255, g / 255, b / 255, 1})
                imgui.EndMenuBar()
            end
    
        
            imgui.SetCursorPos{5, 35}
            imgui.PushFont(font[13])
            local mymoney = getPlayerMoney(PLAYER)
            imgui.SetCursorPosX(15)
            imgui.PushItemWidth(30); imgui.DragInt(u8"��## 221", id, 1, 0, sampGetMaxPlayerId(false)) ; imgui.PopItemWidth()
            imgui.SameLine()
    
            local p = imgui.GetCursorPos()
            imgui.PushItemWidth(70); imgui.DragInt(u8"## 1", mon, 1000, 0, 500000); imgui.PopItemWidth()
        
            imgui.PopFont()
    
            imgui.SetCursorPos{p.x + 75, p.y + 1};
            
            if imgui.BoolText(false, u8"������") then
                if imgui.IsMouseDoubleClicked(0) then
                    mon[0] = mymoney >= 500000 and 500000 or mymoney
                elseif imgui.IsMouseDoubleClicked(1) then
                    sampSendChat("/�������")
                end
            end
            
            local pos, c = imgui.GetCursorPos(), imgui.GetStyle().Colors[imgui.Col.Border]
            imgui.PushStyleColor(imgui.Col.Separator, {c.x, c.y, c.z, 0.8})
            
            extra.Separator(15,0)
            -- imgui.SetCursorPos(pos); extra.Separator()
            imgui.PopStyleColor()
    
            imgui.SetCursorPosY(60)
    
            local mon2, ���� = tostring(mon[0])
            if 1 then
    
               -- imgui.ProgressBar( (os.clock() - timers.tpickup[1]) / 3.05, {180, 20}, u8("��"))
            else
                ���� = function(n)
                    handler('dialog', {t = '����', s = n - 1, i = ''}, 5)
                    timers.tpickup = {os.clock(), 3.1}
                    local x, y, z = getCharCoordinates(PLAYER_PED)
                    if getDistanceBetweenCoords3d(1941, 451, 1023, x, y, z) < 15 then sampSendPickedUpPickup(529) return end
                    NoKick()
                    SendSync{ pos = {-1941, 451, 1023}, pick = cfg['������']['-466.91'].id, force = true}
                end
    
                local buttonsize = {65, 20}
                
    
                imgui.SetCursorPos{20, imgui.GetCursorPosY() + 25}
                if extra.BoolButton(connect, u8"�������", buttonsize) then
                    msg{mon[0], mon2, id[0]}
                    
                    handler('dialog', {t = '��� �������', s = -1, i = id[0]}, 5) --id
                    handler('dialog', {t = '��� ������� ������', s = -1, i = tostring(mon[0])}, 5) --money
                    ����(4)
    
                end; if imgui.IsItemHovered() then text = u8("���") end
    
                imgui.SameLine()
    
                if extra.BoolButton(mymoney >= mon[0], u8"��������", buttonsize) then
                    handler('dialog', {t = '��� �����', s = -1, i = mon2}, 5) -- money
                    ����(1)
                end; 
                
                imgui.SameLine()
                if imgui.Button(u8"�����", buttonsize) then
                    handler('dialog', {t = '��� �����', s = -1, i = mon2}, 5) -- money
                    ����(2)
                end
            end
        end)
        imgui.SetCursorPos{mp.x, 143}
    end



    local sync2_gui = function ()

        if not sync2 then
            sync2 = {
                {pos = {421, 2525, 16},     cmd = u8'��������'},
                {pos = {306 , 1832, 6},     cmd = u8'���������'},
                {pos = {306, 1832, 6},      cmd = u8'�������'},
                {pos = {1862, -2256, 1505}, cmd = u8'������'},
                {pos = {1862, -2256, 1505}, cmd = u8'������'},
                {pos = {254, 85, 2002},     cmd = u8'����������'},
                id = new.int(0),
            }
        end

        local two_childs = {249, 123.5}

        imgui.menu_bar_child("Sync2", two_childs, function()
            imgui.PushItemWidth(50)
            imgui.InputInt(u8"##id", sync2.id, 0, 0)
            imgui.PopItemWidth()
            imgui.PushFont(font[13])
        
            imgui.SetCursorPos{13, 60}
    
            for k, v in ipairs(sync2) do
                if imgui.Button(v.cmd,imgui.ImVec2(70,20)) then
                    NoKick()
                    SendSync{ pos = v.pos, mes = (string.format("/%s %d", u8:decode(v.cmd), sync2.id[0])), force = true}
                end
        
                if k == 3 then
                    imgui.SetCursorPosX(13)
                end
                if k%3 ~= 0 then
                    imgui.SameLine(nil)
                
                end
            end
    
            imgui.PopFont()
        end)
    end



    sync_gui()
    bank_gui()
    sync2_gui()
end



return {'������ ', 'COINS', true,  "��� ��������� ����� ������������� �������� ��������� ������ ��, ������� ��������� ����� ��������� ���� �������", gui}