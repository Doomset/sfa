local t, imgui, ffi = {}, require('mimgui'), require('ffi')
local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof
--
t.gui = function ()
	imgui.PushStyleVarFloat(imgui.StyleVar.ChildRounding, 0)
   
	imgui.SetCursorPos{20, 50}
	imgui.BeginChild("CIRCLE", imgui.ImVec2(550, 290), true)


	for k, v in pairs(cfg.cirle) do
		local bool = imgui.new.bool(v)
		if imgui.Checkbox(u8(k), bool) then
			cfg.cirle[k] = bool[0]
			cfg()
		end
	end

	
	


	imgui.PopStyleVar()
	imgui.EndChild()
end


local gui_circle = function ()
	
end



local getBonePosition = ffi.cast("int (__thiscall*)(void*, float*, int, bool)", 0x5E4280)
local function GetBodyPartCoordinates(id, handle)
	local pedptr = getCharPointer(handle)
	local vec = ffi.new("float[3]")
	getBonePosition(ffi.cast("void*", pedptr), vec, id, true)
	return vec[0], vec[1], vec[2]
end

local LabelText  =
{
	[1] = {"ПИКАПЫ", 0xffFFFF00,
		{
			{key = VK_1, name = '1 - Взять пикап с фейк позицией', func = 
			function(x, y, z, pickupId, dist)
				
			    if dist < 15 then msg("+") return sampSendPickedUpPickup(pickupId)  end
				SendSync{ pos = {x, y, z}, pick = pickupId, force = true}
			end},

			{key = VK_2, name = '2 - Скопировать координаты пикапа', func =    
			function(_, _, _, id)
				local pickup = sampGetPickupHandleBySampId(id)
				local x, y, z = getPickupCoordinates(pickup)
				sampAddChatMessage(string.format("%.f, %.f, %.f", x, y, z), 0x84FF09)
				setClipboardText(string.format("%.f, %.f, %.f", x, y, z))
			end},

			{key = VK_3, name = '3 - Тепнуться рядом с пикапом', func = 
			function(x, y, z, _)
				setCharCoordinatesDontResetAnim(PLAYER_PED, x, y, z)
			end},

			{key = VK_4, name = '4 - Скопировать ид пикапа', func = 
			function(_, _, _, pickupId)
				sampAddChatMessage(string.format("{EB4E20}[Dev-Help]{FFFFFF} Pickup %d (Coped to clipboard)", pickupId), 0x84FF09)
				setClipboardText(string.format("%d", pickupId))
			end},	
		},
	},

	[2] = {"ИГРОКИ", 0xFFf542d4, 
		{
			{key = VK_1, name = '1 - На исполку', func =
			function(x, y, z, id, dist, hand)
				if not isCarModel(storeCarCharIsInNoSave(PLAYER_PED), 470) then return msg2("ne tot modelid") end

				lua_thread.create(function()
					local mX, mY, mZ = getCharCoordinates(PLAYER_PED)
					local id2 = select(2, sampGetVehicleIdByCarHandle(storeCarCharIsInNoSave(PLAYER_PED)))
					sampSendExitVehicle(id2)
			        timerIspolka = os.time() + 1
					repeat 
						local x, y, z = getCharCoordinates(hand)
						setCharCoordinates(playerPed, x, y, z - 2.5)
						sampForceVehicleSync(id2)
						wait(0)
					until timerIspolka == 0
					repeat
						setCharCoordinates(playerPed, 2892.875, 2714.875, 1142.875 - 2.5)
						sampForceVehicleSync(id2)
						local mX2, mY2, mZ2 = getCharCoordinates(PLAYER_PED)
						wait(0)
					until math.floor(getDistanceBetweenmain.coords3d(mX2, mY2, mZ2, 2892.875, 2714.875, 1142.875 - 2.5)) < 5 and (not doesCharExist(hand))
					wait(200)
					setCharCoordinates(playerPed, mX, mY, mZ)
				end)
			end},

			{key = VK_2, name = '2 - кинуть пулю',  func =
			function(x, y, z, id, _, hand)
				NoKick()
				local function rand() return math.random(-50, 50) / 100 end
				for i=1, 1 do
					local data = samp_create_sync_data('bullet', false)
					data.targetType = 1
					data.targetId = id
					data.center = {x = rand(), y = rand(), z = rand()}
					data.origin.x, data.origin.y, data.origin.z = getActiveCameraCoordinates()
					data.target.x, data.target.y, data.target.z = x, y, z
					data.weaponId = 24
					data.send()
				end
			end},

			{key = VK_3, name = '3 - хуй',  func =
			function(x, y, z)
				for i=1, 2000 do
					local _, veh = sampGetCarHandleBySampVehicleId(i)
					if doesVehicleExist(veh) and not doesCharExist(getDriverOfCar(veh)) then
						--sampSendExitVehicle(i)
						local sync = samp_create_sync_data("unoccupied")
						sync.vehicleId = 1284
						sync.seatId = 0
						sync.vehicleHealth = getCarHealth(veh)
						sync.roll = {-0.99413418769836, 0, 0}
						sync.direction = {0.10740028321743, 0, 0}
						sync.moveSpeed = {0,0,0}
						sync.turnSpeed = {0.1, 0.1, 0.99}
						sync.position = {x, y, z}
						sync.send()
						break
					end 
				end
			end},
			
			{key = VK_4, name = '4 - Скопировать ид пикапа',         func =
			function(x, y, z, id)
				SendSync(x, y, z, key, pic, sampSendChat("/украсть "..id), true)
			end},
			
			{key = VK_5, name = '5 - Скопировать координаты пикапа',    func =
			function(_, _, _, id)
				getoos(id)
			end},
		},
	},

	[3] = {"ТРАНСПОРТ", 0xFFFFAB00,
		{
			{key = VK_1, name = '1 - Сесть в транспорт', func =
			function(x, y, z, carId, _, car)
				local bool, seat = jumpIntoCar(car, true) -- warp

				if not bool then vCount = os.clock() return end -- xyu

				BlockSync = true
				sampSendEnterVehicle(carId, seat ~= 0)

				if seat == 0 then
					msg("форс водителя "..seat ~= 0)
					SendSync{ manual = "vehicle", id = carId }
					if not isCarLightsOn(car) then SendSync{ manual = "vehicle", key = 512, id = carId } end
				else
					msg("форс пассажирки "..seat)
					SendSync{ manual = "passenger", id = carId, seat = seat }
				end
				BlockSync = false
			end},

			{key = VK_2, name = '2 - Сесть в чужую', func =
			function(x, y, z, carId, _, car)
				local f = function()
					if isCharInAnyCar(PLAYER_PED) then return true end 
					local m = isCarModel
					for k, v in ipairs(getAllVehicles()) do	
						if doesVehicleExist(v) and doesVehicleExist(car) and car ~= v and (m(v, 462) or m(v, 468))then
							local b, i = sampGetVehicleIdByCarHandle(v)
							if not b then return false end
							BlockSync = true
							sampSendEnterVehicle(i, false)
							sampSendExitVehicle(i)
							SendSync{ manual = "vehicle", id = i }
							return i
						end
					end
					BlockSync = false
					return false
				end

			
				if not f() then sCount = os.clock() return end

				



				local bool, seat = jumpIntoCar(car, false)
				if not bool or seat ~= 0 then vCount = os.clock() return end

			
				sampSendEnterVehicle(carId, false)
				SendSync{ manual = "vehicle", id = carId }
				if not isCarLightsOn(car) then
					SendSync{ manual = "vehicle", key = 512, id = carId }
				end

				BlockSync = false
			end},

			{key = VK_3, name = '3 - Заспавнить транспорт',func =
			function(_, _, _, carId, _, car)
				if tableHandlers[car] then return msg2("Уже респавниться") end
				if not isCarFree(car) then return msg2("Машина не пустая") end
				sampSendVehicleDestroyed(carId)
				tableHandlers[car] = {timer = os.time() + 11, car = car}
			end},
		},
	},
	
	[4] = {"ОБЪЕКТЫ", 0xFFFFAB00,
		{
			{key = VK_1, name = '1 wwwww- Тепнуться ко объекту', func =
			function(x, y, z)
				setCharCoordinatesDontResetAnim(PLAYER_PED, x, y, z)
			end},

			{key = VK_2, name = '2 - Тепнуться рядом с пикапом', func =
			function(x, y, z, _, _)
				
				
			end},

			{key = VK_3, name = '3 - Тепнуться рядом с пикапом',  func =
			function(x, y, z)
				print(x, y, z)
				SendSync(x, y, z, 16)
			end},
			
			{key = VK_4, name = '4 - Скопировать ид пикапа', func =
			function(_, _, _, id)
				sampAddChatMessage(string.format("{EB4E20}[Dev-Help]{FFFFFF} object %d (Coped to clipboard)", id), 0x84FF09)
				setClipboardText(string.format("%d", id))
			end},
			
			{key = VK_5, name = '5 - Скопировать координаты пикапа',  func =
			function(_, _, _, id)
				getoos(id)
			end},
		},
	},
}

local cRadius, sound, as = 150, {['bool'] = true }, require('moonloader').audiostream_state
local sw, sh = getScreenResolution()
local target = {
	['car'] = nil,
	['ped'] = nil,
	['pickup'] = nil,
	['object'] = nil,
 }

local circle_mode = 1


local allPick,allObj, sampev = {}, {}, require('lib.samp.events')

sampev.onCreatePickup = function(id, model, pickupType, pos)
    if not allPick[id] then allPick[id] = {pos.x, pos.y, pos.z, model} end
end

sampev.onDestroyPickup = function(id)
	if allPick[id] then allPick[id] = nil end
end


local tab = {allPick, getAllChars, getAllVehicles, allObj}

local getNearCharToCenter = function(sx, sy, radius)
	local arr, m, x, y, z = {}, circle_mode

	local mode = (m == 1 or m == 4)
	for k, v in (mode and pairs or ipairs)(mode and tab[m] or tab[m]())  do

		if mode then
			x, y, z = v[1], v[2], v[3]
		elseif m == 2 then
			x, y, z = GetBodyPartCoordinates(3, v)
		else
			x, y, z = getCarCoordinates(v)
		end

        if isPointOnScreen(x, y, z, 0) and v ~= PLAYER_PED then

            local cX, cY = convert3DCoordsToScreen(x, y, z)
            local dist = getDistanceBetweenCoords2d(sx / 2, sy / 2, cX, cY)
            if dist <= tonumber(radius) then
				local xyi, xyi2 = mode and k or (m == 2 and select(2, sampGetPlayerIdByCharHandle(v)) or (select(2, sampGetVehicleIdByCarHandle(v)))), 
				mode and v[4] or (m == 2 and getCharModel(v) or getCarModel(v))
                table.insert(arr, {dist, xyi, xyi2, cX, cY, x, y, z, not mode and v or nil})
            end


        end
    end
    if #arr > 0 then
		table.sort(arr, function(a, b) return (a[1] < b[1]) end)
		return table.unpack(arr[1])
    end
    return false
end



local canDraw = function()
	local c = readMemory(0xB6F1A8, 1, false)
	return isSampAvailable() and isKeyDown(VK_RBUTTON) and c ~= 53 and c ~= 7 and c ~= 8 and c ~= 51
end


local addText = function(pos, color, text)
	imgui.GetBackgroundDrawList():AddText(imgui.ImVec2(pos.x + 1, pos.y + 1), 0xFF000000, text)
    imgui.GetBackgroundDrawList():AddText(pos, color, text)
end

local debugPic  = imgui.new.char[256]("")




local mainFrame = imgui.OnFrame(function() return canDraw() end,
function(can)
	can.HideCursor = true;


    if imgui.IsKeyReleased(VK_E) then
        circle_mode = (circle_mode < 4) and circle_mode + 1 or 1
		addOneOffSound(0, 0, 0, 1058)
    end

    local io = imgui.GetIO()
    io.WantCaptureKeyboard = false
    local cx, cy = io.DisplaySize.x, io.DisplaySize.y
    
    local dl = imgui.GetForegroundDrawList()

   

    local color = circle_mode == 2 and sampGetPlayerColor(colorPId) or LabelText[circle_mode][2]


	local label = function ()
		local text = u8(LabelText[circle_mode][1])

		imgui.PushFont(font[54])
		addText(imgui.ImVec2(cx / 2 - (imgui.CalcTextSize(text).x / 2), cy / 5), color, text)
		imgui.PopFont()
	end

	label()
    

    local res, id, model, cX, cY, x, y, z, hand = getNearCharToCenter(cx, cy, cRadius)
    if res then

        colorPId = circle_mode == 2 and id or LabelText[circle_mode][2]

        local shortcut = tostring(shortPos(x, y, z))


            
        local mx, my, mz = getCharCoordinates(PLAYER_PED)
        local camX, camY, camZ = getActiveCameraCoordinates()


        local text = string.format(u8"%d[%d]%s", id, model, shortcut)


            addText(imgui.ImVec2( (cX - (imgui.CalcTextSize(text).x / 2)), cY - 40), color, text)

            if circle_mode == 3 or circle_mode == 2 then
            local nametarget = circle_mode == 3 and getNameOfVehicleModel(model) or (id == -1 and "NPC" or sampGetPlayerNickname(id))
            -- addText(imgui.ImVec2( (cX - (imgui.CalcTextSize(nametarget).x / 2)), cY - 24), color, nametarget)
            end


        
    

        local dist = math.floor(getDistanceBetweenCoords3d(mx, my, mz, x, y, z))


        dl:AddLine(imgui.ImVec2(cx/2 + 1, cy/2 +1), imgui.ImVec2(cX + 1, cY + 1), 0xFF000000, 2.0) -- обводка
        dl:AddLine(imgui.ImVec2(cx / 2, cy / 2), imgui.ImVec2(cX, cY), color, 2.0);

        if circle_mode == 1 then
            LabelText[1][3][1].name = dist > 5 and "1 - Взять пикап с фейк позицией(варн)" or "1 - Взять пикап"
            local text3 = cfg["Пикапы"][shortcut] ~= nil and u8(cfg["Пикапы"][shortcut].name) or ((model == 701 or model == 1213 or model == 1602) and u8"Артефакт?" or "Net")
            addText(imgui.ImVec2((cX - (imgui.CalcTextSize(text3).x / 2)), cY - 22), color, text3)


            if imgui.IsMouseClicked(0) then -- add pickup
                addPick = {
                    x = x,
                    y = y,
                    z = z,
                    id = id,
                }
                ffi.C.SetCursorPos(resX/2, resY/2)
                cricle = false

                imgui.StrCopy(debugPic, cfg["Пикапы"][shortcut] and u8(cfg["Пикапы"][shortcut].name) or "")

                pickwindow = true

            end
        end

        dl:AddCircleFilled(imgui.ImVec2(cx / 2 + 1, cy / 2 + 1), 4, 0xFF000000, 20);
        dl:AddCircleFilled(imgui.ImVec2(cx / 2, cy / 2), 4, color, 20);

        dl:AddCircleFilled(imgui.ImVec2(cX + 1, cY + 1), 4, 0xFF000000, 20);
        dl:AddCircleFilled(imgui.ImVec2(cX, cY), 4, color, 20);

        local cnY = cY - (10  * 4)
        for k, v in ipairs(LabelText[circle_mode][3]) do
            imgui.PushFont(font[12])
            addText(imgui.ImVec2(cX + 70 + 1, cnY + 1), 0xFF000000, u8(v.name))
            addText(imgui.ImVec2(cX + 70, cnY), color, u8(v.name))
            imgui.PopFont()

            if imgui.IsKeyReleased(v.key) then
                v.func(x, y, z, id, dist, hand)
            end

            cnY = cnY + 10
        end
        

    end
end)



local frameDrawerDebug = imgui.OnFrame(function() return pickwindow end,
function(self)
	self.LockPlayer = pickwindow
	local debugX, debugY, debugZ, idpic =  addPick.x, addPick.y, addPick.z, addPick.id
	local shortcut = tostring(shortPos(debugX, debugY, debugZ))

	imgui.SetNextWindowPos(imgui.ImVec2(resX / 2 , resY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
	imgui.Begin(cfg["Пикапы"][shortcut] == nil and u8"Этого пикапа нет в таблице" or u8(cfg["Пикапы"][shortcut].name), _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoMove)
	imgui.BeginChild('Left panela', imgui.ImVec2(220, 80), true)

	imgui.InputText(u8"Название", debugPic, sizeof(debugPic), imgui.InputTextFlags.EnterReturnsTrue)
    if imgui.IsKeyReleased(imgui.GetKeyIndex(imgui.Key.Enter))  then
        --if u8:decode(str(debugPic)):find("%A") then return msg2("Название содержит русские символы, не сохранено") end
        if cfg["Пикапы"][shortcut] == nil then
            msg(string.format("Добавлен %s", u8:decode(str(debugPic))))
            cfg["Пикапы"][shortcut] = {
                pos = {debugX, debugY, debugZ},
                name = u8:decode( str(debugPic) ),
                id = idpic
            }
            cfg()
        else
            msg(string.format("Перезаписан %s", u8:decode(str(debugPic))))
            cfg["Пикапы"][shortcut] = {
                pos = {debugX, debugY, debugZ},
                name = u8:decode(str(debugPic)),
                id = idpic
            }
            cfg() 
        end
        pickwindow = false
        addPick = nil
        imgui.SetClipboardText(u8(string.format("SendSync{ pos = {%.f, %.f, %.f}, pick = cfg['Пикапы']['%s'].id, force = true}", debugX, debugY, debugZ, shortcut)))
        imgui.StrCopy(debugPic, "")
    end
	imgui.EndChild()
	imgui.End()
end)




if not cfg.circle then
	cfg.cirle = {Статус = true}
	cfg()
end

return t