local sampev_exist, sampev     = pcall(require, 'lib.samp.events')
local lastservermsg = {color = -1, text = ""}
local ffi = require 'ffi'
local lastattached = {
}

local lastdialogresponse = {title = "", button = 1, select = 1, input = "", on = false}

local lastAudioStream = {url = "", on = false}
local lastSoundId = {id = -1, on = false}


function sampev.onVehicleStreamIn(vehId, data)
    lua_thread.create(function()
        wait(0)
        local res, handle = sampGetCarHandleBySampVehicleId(vehId)
        if res and isCarInArea2d(handle, 1270, -2564, 1223, -2489, false) then
            cfg["�����"].id = vehId
            cfg()
        end
    end)
end



function sampev.onShowDialog(id, style, title, button1, button2, text)

	-- if id == 6 then
	-- 	list_inv = {}
	-- 	for line in text:gmatch('[^\n]+') do
	-- 		list_inv[#list_inv + 1] = line
	-- 	end
		
	-- 	inventar.switch()
	-- 	sampSendDialogResponse(id, 0, -1, "")
	-- 	return false
	-- end


	
	for k, v in ipairs(cfg["�������"]["������"]) do
		if v.on and title:find(v.title) then
			sampSendDialogResponse(id, v.button, v.select, v.input)
			print('settings["�������"]["������"]', "������ ����� ������� ", id, v.button, v.select, v.input) 
			return false
		end
	end

	if cfg["����������"]["�������"]["������ �����"] and title:find("������� ������������") then
		local t = timer.exist("�����")
		
		timer("���� � ������", t and t + 1.1 or 0.0, function()
			handler('dialog', {t = '���������'})
			handler('dialog', {t = '������� ���������', s = 2, i = '���������� ��������'})
			--timer.exist(@) ��� �� �������� �� ���� ����������
			sampSendChat("/�����")
		end)
		return false
	end


	if ������:����(title, text, id) then return false end

	if title:find("�����������") then
		������.������["�������"], ������.������["���������"] = text:match("�������	(%d+)"), text:match("���������	(%d+)")
	elseif title:find("��������") then
		������.������["��������"], ������.������["�����"] = text:match("��������	(%d+)"), text:match("�����	(%d+)")
	elseif title:find("���������") then
		������.������["����"] = text:match("����	(%d+)")
	elseif title:find("�����������") then
		������.������["���������"], ������.������["��������"], ������.������["�������"] = text:match("���������	(%d+)"), text:match("��������	(%d+)"), text:match("�������	(%d+)")
	end

    if handler.has("dialog", {id, title}) then return false end

	local f = title
	if cfg["����������"]["������"] and ( f:find('���� �����������') or f:find('�������� ��� ���������') or f:find('����������� ��������') or f:find('���� �����') ) then
		if cfg["����������"]["����� ���"].on then sampSendDialogResponse(id, 1, -1, f:find('����������� ��������') and " " or cfg["����������"]["����� ���"].pass)  print("AUTOLOGIN") return false end
		local myid = select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))
		for k, v in ipairs(cfg["����������"]["�������"]["����"]) do
			if v.on and (string.lower(v.nick) == string.lower(sampGetPlayerNickname(myid))) then
				print("AUTOLOGIN")
				sampSendDialogResponse(id, 1, -1, f:find('����������� ��������') and " " or v.pass)
				return false 
			end
		end
	end
end 


ds = {

	[685] = {n = "rad", on = cfg.rad.������},
	[605] = {n = "gol", on = cfg.gol.������},
}

function sampev.onShowTextDraw(id, data)
	local ez = data.position.x + data.position.y
	local ind = ds[ez]
	if ind then
		local res, _, i = data.text:find("%w+ (%d+)")
		if tonumber(i) >= 80 and ind.on then
			if sampIsDialogActive() then return end
			���������( ind.n == "rad" and 8 or 10 )
		end
		if cfg[ind.n]["��"] ~= id then cfg[ind.n]["��"] = id; msg{"���������� ", ind.n}; cfg() end
	end 

	if ez == 945 then indicatorArts = id end

	if ez == 2 and cfg["����� � ���"]["�������"]["����������"] then print('["����� � ���"]["�������"]["����������"]', "������������ ��������� � �����������") return false end



	if ez == 201 and cfg["���������"]["�������"] ~= id then
		cfg["���������"]["�������"] = id -- �������
		print("��������� ���������� �������")
		cfg()
	elseif ez == -50 and cfg["���������"]["������� �������"] ~= id then
		cfg["���������"]["������� �������"] = id -- �������
		print("��������� ���������� �����")
		cfg()
	end

	if (data.position.x == 16 and data.position.y == -20) and cfg["���������"]["������"] then
		if blockNextTd then blockNextTd = nil return false end
		if cfg["���������"]["�������"]["��������"] < 0.01 then sampSendClickTextdraw(cfg["���������"]["�������"]) return end
		timers.timoutOtm = {os.clock(), cfg["���������"]["�������"]["��������"]}
	end
end


function sampev.onPlaySound(soundId, position)
	lastSoundId = { id = soundId, on = false }
	if soundId == 36401 and sampTextdrawIsExists(cfg["���������"]["������� �������"]) and cfg["���������"]["������"] then
		blockNextTd = true
		print("��������� ������������� �������")
		sampSendClickTextdraw(cfg["���������"]["������� �������"]) --open
	end
end



function sampev.onTextDrawSetString(id, text)
	for k, v in pairs(ds) do
		if text:find(v.n) then
			local res, _, i = text:find("%w+ (%d+)")

			if tonumber(i) >= 80 and v.on then
				if sampIsDialogActive() then return end
				���������( v.n == "rad" and 8 or 10 )
			end

		end
	end
end







function sampev.onPlayAudioStream(url, p, radius, up)
	lastAudioStream = {url = url, on = false}
	print(url, p.x, p.y, p.z, radius, up)
end



function sampev.onSendDialogResponse(dialogId, button, listboxId, input)
	timer("���� � ������", 3.6, function()
		msg("GO�")
	end)
	local t = sampGetDialogCaption()
	lastdialogresponse = {title = t, button = button, select = listboxId, input = input, on = false}
	if t:find('���� �����') or t:find('���� �����������') then
		imgui.StrCopy(resPass, u8(input))
		imgui.StrCopy(resNick, sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))))
	end
end



function sampev.onSetPlayerPos(pos)
    if handler.has("player_pos", {pos}) then return false end

    if shortPos(pos.x, pos.y, pos.z) == 1310.6 then msg("���� ������ �� ���������)") return false end

    print("player_pos ������ ��������� ������� ",pos.x, pos.y, pos.z, shortPos(pos.x, pos.y, pos.z))

    print("player_pos ",pos.x, pos.y, pos.z, shortPos(pos.x, pos.y, pos.z))

    if BlockSyncJob then return false end
end



function sampev.onSetVehiclePosition(vehicleId, pos)
	print("onSetVehiclePosition ������ ��������� ������� ",pos.x, pos.y, pos.z, shortPos(pos.x, pos.y, pos.z))
	if BlockSyncJob then return false end
end



function sampev.onSendExitVehicle(veh)
    timer("abuse", 7)
	timers.timeoutAC = {os.clock(), 7}
end



function sampev.onSendSpawn()
    timer("abuse", 7)
    timers.timeoutAC = {os.clock(), 7}
end



function sampev.onSetCheckpoint(p, radius)
	takecheck(p)
	handler("checkpoints", {p})
	CheckpointsDebug[#CheckpointsDebug + 1] = {p.x, p.y, p.z}
end



function sampev.onSetRaceCheckpoint(type, p, nextPosition, size)
	takecheck(p)
	handler("checkpoints", {p})
	CheckpointsDebug[#CheckpointsDebug + 1] = {p.x, p.y, p.z}
end

-- -176.05770874023, 1163.03125, 24.686134338379
-- 627.96325683594, 2181.9912109375, 24.102262496948
function sampev.onCreateActor(actorId, skinId, p, rotation, health)
	if skinId == 78 then
		-- placeWaypoint(p.x, p.y, p.z)
	end


	if skinId == 33 and cfg["�����"] ~= actorId then
		cfg["�����"] = actorId
		msg{'settings["�����"]', actorId}
		cfg()
	end 
end



function sampev.onSetPlayerAttachedObject(playerId, index, create, object)
	if playerId == select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)) then
		if not lastattached[index] and  object.modelId ~= 0 then
			lastattached[index] =
			{
				data = 
				{
					id = object.modelId,
					bone = object.bone,
					offset = {object.offset.x, object.offset.y, object.offset.z},
					rotation = {object.rotation.x, object.rotation.y, object.rotation.z},
					scale = {object.scale.x, object.scale.y, object.scale.z},
					color1 = object.color1,
					color2 = object.color2,
				}
			}
			msg(index)
		elseif lastattached[index] and object.modelId == 0 and not create then lastattached[index] = nil end
	end

	for k, v in ipairs(cfg["������"]["������"]) do
		if not v.on then return end
		for _, obj in pairs(v.list) do
			if object.modelId == obj.data.id then
				print("PlayerAttachedObject", object.modelId, "�����")
				return false
			end
		end
	end
end



local antimuteflodd = function()
	local has = timer.exist("��������")
	if not has then timer("��������", 1.1) end
	return has
end
function sampev.onSendChat(message)
	if antimuteflodd() then msg("� �����") return false end
end
function sampev.onSendCommand(command)
	if antimuteflodd() then msg("� �����") return false end
end



--timer("job delay", 60)
function sampev.onServerMessage(color, text)
	 lastservermsg = {color = color, text = text}

	 if cfg["����������"]["�������"]["�����"] and color == 267386880 and text:find("�� ������ � ���� � �������� ��������") then
		local t = timer.exist("���� � ������")
		timer("�����", t and t + 1.1 or 0.0, function()
			handler('dialog', {t = '���������'})
			handler('dialog', {t = '������� ���������', s = 2, i = '���������� ��������'})
			--timer.exist(@) ��� �� �������� �� ���� ����������
			sampSendChat("/�����")
		end)
		return false
	end


	if color == 267386880 and text:find("�� ��������� %d+$ %+ %d+$ ����� �� �������") then
		timer("job delay", 61) 
		if BlockSyncJob then
			
		--	msg{BlockSyncJob, "BlockSyncjob"}
			BlockSyncJob = false
			msg("BlockSyncJob = false")
		elseif BlockSyncJob and text == '�� ������� ������!' and color == -1439485014 then
			BlockSyncJob = false
			msg("BlockSyncJob = false")
		end
	end

	for k, v in ipairs(cfg["����"]["������"]) do
		if text:find(v.text) and color == v.color then
			print('settings["����"]["������"]', "ServerMessage block", color, text)
			return false
		end
	end	

	print (string.format("handler('onServerMessage', {text = '%s', color = %d})", text, color))

	if text == '����� ����������� ��� ��� ������� .����������' and color == 267386880 and cfg["����� � ���"]["�������"]["����������"] then
		sampSendChat("/����������")
		print("/����������", '[����� � ���"]["�������"]["����������"]')
	end

	if handler.has("onServerMessage", {color, text}) then return false end

	if text:find('� ��� ��� ����������. ������ ��� � ����� ������') and color == -1439485014 and ds[685].on then ds[685].on = false return {color, "��������� ��������"}
	elseif text:find('� ��� ��� ���. ������ � � ����') and color == -1439485014 and ds[605].on then ds[605].on = false return {color, "��� ���������"} end
end


local sampfuncs = require 'sampfuncs'
local raknet = require 'samp.raknet'
require 'samp.synchronization'
local sync_traits = {
	player = {'PlayerSyncData', raknet.PACKET.PLAYER_SYNC, sampStorePlayerOnfootData},
	vehicle = {'VehicleSyncData', raknet.PACKET.VEHICLE_SYNC, sampStorePlayerIncarData},
	passenger = {'PassengerSyncData', raknet.PACKET.PASSENGER_SYNC, sampStorePlayerPassengerData},
	aim = {'AimSyncData', raknet.PACKET.AIM_SYNC, sampStorePlayerAimData},
	trailer = {'TrailerSyncData', raknet.PACKET.TRAILER_SYNC, sampStorePlayerTrailerData},
	unoccupied = {'UnoccupiedSyncData', raknet.PACKET.UNOCCUPIED_SYNC, nil},
	bullet = {'BulletSyncData', raknet.PACKET.BULLET_SYNC, nil},
	spectator = {'SpectatorSyncData', raknet.PACKET.SPECTATOR_SYNC, nil}
}


-- msg(mi.key)


function samp_create_sync_data(sync_type, copy_from_player)
    copy_from_player = copy_from_player or true
    local sync_info = sync_traits[sync_type]
    local data_type = 'struct ' .. sync_info[1]
    local data = ffi.new(data_type, {})
    local raw_data_ptr = tonumber(ffi.cast('uintptr_t', ffi.new(data_type .. '*', data)))
    -- copy player's sync data to the allocated memory
    if copy_from_player then
        local copy_func = sync_info[3]
        if copy_func then
            local _, player_id
            if copy_from_player == true then
                _, player_id = sampGetPlayerIdByCharHandle(PLAYER_PED)
            else
                player_id = tonumber(copy_from_player)
            end
            copy_func(player_id, raw_data_ptr)
        end
    end
    -- function to send packet
    local func_send = function()
        local bs = raknetNewBitStream()
        raknetBitStreamWriteInt8(bs, sync_info[2])
        raknetBitStreamWriteBuffer(bs, raw_data_ptr, ffi.sizeof(data))
        raknetSendBitStreamEx(bs, sampfuncs.HIGH_PRIORITY, sampfuncs.UNRELIABLE_SEQUENCED, 1)
        raknetDeleteBitStream(bs)
    end
    -- metatable to access sync data and 'send' function
    local mt = {
        __index = function(t, index)
            return data[index]
        end,
        __newindex = function(t, index, value)
            data[index] = value
        end
    }
    return setmetatable({send = func_send}, mt)
end

function sampev.onApplyPlayerAnimation(playerId, animLib, animName, frameDelta, loop, lockX, lockY, freeze, time)
	if BlockSyncJob then return false end
end



function sampev.onTogglePlayerControllable()
	if BlockSyncJob then return false end
end



function sampev.onClearPlayerAnimation(playerId)
	if BlockSyncJob then return false end
end



function sampev.onSetPlayerHealth(health)
	if BlockSyncJob then return false end
end



-- if not doesCharExist(pedFerma) then
--     local x, y, z = getCharCoordinates(PLAYER_PED)
--     model = getCharModel(PLAYER_PED)
--     requestModel(model) -- ����������� ������ ���� (����) � ������ id. � ������ ������ id ����� - ��� ���� Messer (����� � �������).
--     loadAllModelsNow() -- ��������� ��� ����������� ������
--     pedFerma = createChar(4, model, x, y, z)

--     setCharCoordinates(pedFerma, x, y, z)

--     -- requestAnimation("ped") -- �������� ����� �������� "POOL"
--     -- taskPlayAnim(pedFerma, "seat_up", "ped", 4.0, false, false, false, false, -1) -- ��������������� ����� �������� "POOL_XLONG_SHOT"
--     requestModel(getWeapontypeModel(34))

--     giveWeaponToChar(pedFerma, 34, 1000)

--     setCurrentCharWeapon(pedFerma, 34)


-- end

   

function sampev.onSendPlayerSync(data)
	if core["������"].������[1][3] and timers.surfabuse2[1] ~= -1 then
        if core["������"].������[5][3] then core["������"].������[5][3] = false msg("������ � �������") end
		data.surfingVehicleId = cfg["�����"].id
		core["������"].������[1][1] = "surf"
        core["������"].������[1][2] = "PERSON"
	end

    if core["������"].������[5][3] then
        data.surfingVehicleId = 2228
    end

    -- if doesCharExist(pedFerma) then
    --     local angle = getCharHeading(PLAYER_PED)
    --     local _, name = sampGetAnimationNameAndFile(data.animationId)

    --     setCharHeading(pedFerma, angle)
    --    -- taskPlayAnim(pedFerma, name, "PED", float framedelta, bool loop, bool lockX, bool lockY, bool lockF, int time)
    --     setCharCoordinatesDontResetAnim(pedFerma, data.position.x - math.sin(-math.rad(angle + 40)),  data.position.y - math.cos(-math.rad(angle + 20)),  data.position.z)
    -- end

    if BlockSync or SendSyncBlock or BlockSyncJob or loadplace then return false end



end



function sampev.onSendVehicleSync(data)
	if BlockSync or SendSyncBlock or BlockSyncJob or loadplace then return false end

    if core["������"].������[6][3] then
		data.quaternion[0] = 1/0
		data.quaternion[1] = 1/0
		data.quaternion[2] = 1/0
		data.quaternion[3] = 1
	end

end



function sampev.onSendUnoccupiedSync(data)
	if BlockSync or SendSyncBlock or BlockSyncJob or loadplace then return false end
end



function sampev.onSendPassengerSync(data)
	if BlockSync or SendSyncBlock or BlockSyncJob or loadplace then return false end
end



function sampev.onSendAimSync(data)
	if BlockSync or SendSyncBlock or BlockSyncJob or loadplace then return false end
end



function sampev.onCreatePickup(id, model, pickupType, pos)
	local pick_data = cfg["������"][tostring(shortPos(pos.x, pos.y, pos.z))]

	if pick_data and pick_data.id ~= id then
		msg(pick_data.name.." �� �����")
		cfg["������"][tostring(shortPos(pos.x, pos.y, pos.z))].id = id
		cfg()
	end

	if (model == 1213 or model == 1602 or model == 701 or model == 1239) and render_radar_art[id] == nil then
		render_radar_art[id] = {pos.x, pos.y, pos.z, model} 
	end

	if (model == 1213 or model == 1602 or model == 701) and ����_���_�����[id] == nil and (shortPos(pos.x, pos.y, pos.z) ~= 1283.12) and (shortPos(pos.x, pos.y, pos.z) ~= 2960.62) then
		����_���_�����[id] = {pos.x, pos.y, pos.z} 
	end
end



function sampev.onDestroyPickup(id)
    if allPick[id] then
        allPick[id] = nil
    end
	if render_radar_art[id] then
		render_radar_art[id] = nil
	end
end


function sampev.onSendPickedUpPickup(id)

end




function sampev.onDestroyObject(id)
	if allObj[id] ~= nil then
		allObj[id] = nil
	end
end



function sampev.onCreateObject(id, data)
	if allObj[id] == nil then
		allObj[id] = {data.position.x, data.position.y, data.position.z, data.modelId}
	end
end



local rename = function(t, data, rename)
	if t[data] then return end
	t[data] = t[rename]
	t[rename] = nil
end



local my_state = function()
	if not isCharInAnyCar(PLAYER_PED) then return "player" end
	local car = storeCarCharIsInNoSave(PLAYER_PED)
	if doesCharExist(getDriverOfCar(car)) then
		return "vehicle"
	end
	for i = 0, getMaximumNumberOfPassengers(car) do
		if not isCarPassengerSeatFree(car, i) and getCharInCarPassengerSeat(car, i) == PLAYER_PED then
			return "passenger", i + 1
		end
	end
end

local _t =  {}

_t.sync = function(t)
	local state = { my_state() }
	local s = samp_create_sync_data(t and (t.a or state[1]) or state[1])
	if t then
		print("SYNC", encodeJson(t))
		rename(t, state[1] == "player" and "weapon" or "currentWeapon", "weapon")
		rename(t, "keysData", "key")
		rename(t, "specialKey", "spec")
		rename(t, "position", "pos")
		rename(t, "quaternion", "quat")
		rename(t, "surfingVehicleId", "surf")
		rename(t, "pick", "pic")
		for k, v in pairs(t) do
			if k ~= "a" and k ~= "f" and k ~= "pick" and k ~= "msg" then
				s[k] = v
			end
		end
	else
		print("FORCE SYNC")
	end
	s.send()
	if t then
		if t.pick then sampSendPickedUpPickup(t.pick) end
		if t.msg then sampSendChat(t.msg) end
		if t.f then sync() end
	end
end



return _t


