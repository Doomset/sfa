local trace_log, print = {}, print
trace = function(mes)
	print(mes)
	trace_log[#trace_log + 1] = mes
end
local _require = require
script_properties("work-in-pause")

--if not package.loading then package.loading = {} end


-- unload_req = function(mod)
-- 	req = nil
-- 	package.loading[mod] = nil
-- end

-- 

-- require "ziplib.dll"
consolLog = {}
print = function(...)
	print(...)
	table.insert(consolLog, table.concat({...}, ", "))
end









local count_init = 0
require = function(n)
	n = n:gsub('sfa', '1sfa')
	local name = _require(n)

	if n:find('sfa') then end -- its not a lib!

	local con, log = table.concat, trace

	count_init = count_init + 1

	--log(con({ thisScript().name , 'INIT DEPEND', n, tostring(res), tostring(name), count_init }, ' '))
	--print(_M[name])
	return name
end


cfg = require('sfa.Config')(SFA_settings,  "\\sfa\\settings.json")





---@diagnostic disable: deprecated, lowercase-global, param-type-mismatch
require("moonloader")

local ffi = require 'ffi'

weapons = require 'game.weapons'
local mem = require 'memory'
local encoding = require 'encoding'
encoding.default                = 'CP1251'
u8                              = encoding.UTF8

do local a=getmetatable("String")function a.__index:insert(b,pos)if pos==nil then return self..b end;return self:sub(1,pos)..b..self:sub(pos+1)end;function a.__index:extract(c)self=self:gsub(c,"")return self end;function a.__index:array()local d={}for e in self:gmatch(".")do d[#d+1]=e end;return d end;function a.__index:isEmpty()return self:find("%S")==nil end;function a.__index:isDigit()return self:find("%D")==nil end;function a.__index:isAlpha()return self:find("[%d%p]")==nil end;function a.__index:split(f,g)assert(not f:isEmpty(),"Empty separator")result,pos={},1;repeat local e,h=self:find(f or" ",pos,g)result[#result+1]=self:sub(pos,e and e-1)pos=h and h+1 until pos==nil;return result end;local i=string.lower;function a.__index:lower()for j=192,223 do self=self:gsub(string.char(j),string.char(j+32))end;self=self:gsub(string.char(168),string.char(184))return i(self)end;local k=string.upper;function a.__index:upper()for j=224,255 do self=self:gsub(string.char(j),string.char(j-32))end;self=self:gsub(string.char(184),string.char(168))return k(self)end;function a.__index:isSpace()return self:find("^[%s%c]+$")~=nil end;function a.__index:isUpper()return self:upper()==self end;function a.__index:isLower()return self:lower()==self end;function a.__index:isSimilar(l)return self==l end;function a.__index:isTitle()local m=self:find("[A-zА-яЁё]")local n=self:sub(m,m)return n:isSimilar(n:upper())end;function a.__index:startsWith(l)return self:sub(1,#l):isSimilar(l)end;function a.__index:endsWith(l)return self:sub(#self-#l+1,#self):isSimilar(l)end;function a.__index:capitalize()local o=self:sub(1,1):upper()self=self:gsub("^.",o)return self end;function a.__index:tabsToSpace(p)local q=(" "):rep(p or 4)self=self:gsub("\t",q)return self end;function a.__index:spaceToTabs(p)local q=(" "):rep(p or 4)self=self:gsub(q,"t")return self end;function a.__index:center(r,s)local t=r-#self;local e=string.rep(s or" ",t)return e:insert(self,math.ceil(t/2))end;function a.__index:count(u,v,w)assert(not u:isEmpty(),"Empty search")local x=self:sub(v or 1,w or#self)local p,pos=0,v or 1;repeat local e,h=x:find(u,pos,true)p=e and p+1 or p;pos=h and h+1 until pos==nil;return p end;function a.__index:trimEnd()self=self:gsub("%s*$","")return self end;function a.__index:trimStart()self=self:gsub("^%s*","")return self end;function a.__index:trim()self=self:match("^%s*(.-)%s*$")return self end;function a.__index:swapCase()local result={}for e in self:gmatch(".")do if e:isAlpha()then e=e:isLower()and e:upper()or e:lower()end;result[#result+1]=e end;return table.concat(result)end;function a.__index:splitEqually(r)assert(r>0,"Width less than zero")assert(r<=self:len(),"Width is greater than the string length")local result,j={},1;repeat if#result==0 or#result[#result]>=r then result[#result+1]=""end;result[#result]=result[#result]..self:sub(j,j)j=j+1 until j>#self;return result end;function a.__index:rFind(c,pos,g)local j=pos or#self;repeat local result={self:find(c,j,g)}if next(result)~=nil then return table.unpack(result)end;j=j-1 until j<=0;return nil end;function a.__index:wrap(r)assert(r>0,"Width less than zero")assert(r<self:len(),"Width is greater than the string length")local pos=1;self=self:gsub("(%s+)()(%S+)()",function(y,z,A,B)if B-pos>(r or 72)then pos=z;return"\n"..A end end)return self end;function a.__index:levDist(l)if#self==0 then return#l elseif#l==0 then return#self elseif self==l then return 0 end;local C=0;local D={}for j=0,#self do D[j]={}D[j][0]=j end;for j=0,#l do D[0][j]=j end;for j=1,#self,1 do for E=1,#l,1 do C=self:byte(j)==l:byte(E)and 0 or 1;D[j][E]=math.min(D[j-1][E]+1,D[j][E-1]+1,D[j-1][E-1]+C)end end;return D[#self][#l]end;function a.__index:getSimilarity(l)local F=self:levDist(l)return 1-F/math.max(#self,#l)end;function a.__index:empty()return""end;function a.__index:toCamel()local G=self:array()for j,n in ipairs(G)do G[j]=j%2==0 and n:lower()or n:upper()end;return table.concat(G)end;function a.__index:shuffle(H)math.randomseed(H or os.clock())local G,I=self:array(),{}for j=1,#G do I[j]=G[math.random(#G)]end;return table.concat(I)end end


msg = function(...)
    if not isSampAvailable() then return end
	if type(...) == "table" then text = encodeJson(...) else
		local temp = {...}
		for k, v in ipairs(temp) do
			if type(v) ~= "string" then

				temp[k] =  type(v) == "table" and encodeJson(v) or (msg_debug and type(v) or "")..tostring(v)
			end
		end
		text = table.concat(temp, ", ")
	end
    sampAddChatMessage('{8952ff}[sfa]: {ffffff}'..text, 0xFF8952ff)
end
ProcessLog = {
	
}

Loaded_Icons = {"arrow_left", 'ARROWS_ROTATE', "TRASH", "ARROW_DOWN", "ARROW_UP", "GEAR", "MAGNIFYING_GLASS"}




if cfg.debug then
	local path = script.this.path
	local f = io.open(path, 'r')
	local sfa_content = f:read('*a')
	f:close()

	cfg.build = os.date("%d.%m.%Y(%H:%M:%S)")
	cfg()

	local f = io.open(getWorkingDirectory().. '\\lib\\1sfa\\zsfa2.lua', 'w')
	f:write(sfa_content)
	f:close()
end





local effil = require 'effil' -- В начало скрипта




function asyncHttpRequest(method, url, args, resolve, reject)
	local request_thread = effil.thread(function (method, url, args)
	   local requests = require 'requests'
	   local result, response = pcall(requests.request, method, url, args)
	   if result then
		  response.json, response.xml = nil, nil
		  return true, response
	   else
		  return false, response
	   end
	end)(method, url, args)
	-- Если запрос без функций обработки ответа и ошибок.
	if not resolve then resolve = function() end end
	if not reject then reject = function() end end
	-- Проверка выполнения потока
	lua_thread.create(function()
	   local runner = request_thread
	   while true do
		  local status, err = runner:status()
		  if not err then
			 if status == 'completed' then
				local result, response = runner:get()
				if result then
				   resolve(response)
				else
				   reject(response)
				end
				return
			 elseif status == 'canceled' then
				return reject(status)
			 end
		  else
			 return reject(err)
		  end
		  wait(0)
	   end
	end)
end


local url_git = "https://api.github.com/repos/doomset/sfa/git/trees/main?recursive=1" -- закачка нового гита


local git_tree = {}


--for _, v2 in ipairs(getFilesInPath(getWorkingDirectory().."\\sfa\\select\\" .. list[i].name, '*.lua')) do 




asyncHttpRequest('GET', url_git, nil, function(resolve)
	--progress_download.text = (v.update and 'обновлен ' or 'скачан ')..v.path

	print(resolve.text)

	--local f = io.open(getWorkingDirectory()..'\\sfa\\test.json')

	git_tree = decodeJson(resolve.text).tree
	

	print(git_tree)
	
	downlanded_git = resolve.text
	--d(v.path)
end, function(err)
--	sms('Ошибка при отправке сообщения в Telegram!')
end)





require 'sfa.samp'


require('sfa.imgui.onInitialize')
require("sfa.timer")





BlockSync, SendSyncBlock = false, false

font = {}

blockNextTd = false
indicatorArts = 0

msg_debug = false






pickwindow = false




script_name("sfa")

saveJson = cfg


--require("sfa.imgui.imgui")





local function isCarLightsOn(car)
    return readMemory(getCarPointer(car) + 0x428, 1) > 62
end


--h("dialog")

check_car = function(c)
	local store, time, vehs = storeCarCharIsInNoSave, timer.exist("abuse"), getAllVehicles()

	if time then return -1, "no need abuse" end

	if #vehs < 1 then return false, "no car" end

	if isCharInAnyCar(PLAYER_PED) and isCarLightsOn(store(PLAYER_PED)) then
		return select(2, sampGetVehicleIdByCarHandle(store(PLAYER_PED))), "ped car"
	end



	for k, hand in ipairs(vehs) do
		local res, id = sampGetVehicleIdByCarHandle(hand)
		if res and doesVehicleExist(hand) and store(PLAYER_PED) ~= hand then
			return id, "nearcar"
		end
	end

	return false, "no car"
end




WARN_ABUSE = function()
	timer("abuse", 6)
	if timer.exist("abuse2") then return end
	msg("вывыввыввы")
	handler("player_pos", {2903.17})
	SendSync{pos = {1292, 1580, 42}, key = 2, force = true, manual = "player"}
	sampForceOnfootSync()
	timer("abuse2", 6)
end

require('sampfuncs')


CheckpointsDebug = {}








resX, resY = getScreenResolution()

cricle = true
local wm  = require('lib.windows.message')


shortPos = function(x, y, z)
	local round = function(num, idp)
        local mult = 10^(idp or 0)
        return math.floor(num * mult + 0.5) / mult
    end
	return round(x + y + z, 2)
end



local consolLog = {}






function isAnyCheckpointExist()
	local misc = sampGetMiscInfoPtr()
	if misc == 0 then return false end
	local defoult, race = mem.getint32(misc + 0x24) == 1, mem.getint32(misc + 0x49) == 1
	local pPos = defoult and (misc + 0xC) or (misc + 0x2C)
	return (defoult or race), mem.getfloat(pPos), mem.getfloat(pPos + 0x4), mem.getfloat(pPos + 0x8), defoult and 0 or 1
end








pL = function(...)
	table.insert(ProcessLog, ...)
end



sendPos = function(data)
	local t, delay, tp, key, pick = data["t"], data["delay"], data["tp"], data["key"], data["pick"]

	for k, v in ipairs(t) do

		NoKick()

		if tp then setCharCoordinates(PLAYER_PED, v[1], v[2], v[3]) else
			if not fast then
				SendSync{pos ={v[1], v[2], v[3]}, key = key or v.key, pick = pick or v.pick, force = true, surf = 2333}
			else
				exSyncKey{pos ={v[1], v[2], v[3]}, key = key or v.key, force = true, surf = 2333}
			end

			pL(encodeJson(data))
		end

		if (delay ~= nil and k ~= #t) then
			wait(delay)
			pL('wait(delay)')
		end
	end
end



function setCharCoordinatesDontResetAnim(char, x, y, z)
	if doesCharExist(char) then
		local entityPtr = getCharPointer(char)
		if entityPtr ~= 0 then
			local matrixPtr = readMemory(entityPtr + 0x14, 4, false)
			if matrixPtr ~= 0 then
				local posPtr = matrixPtr + 0x30
				writeMemory(posPtr + 0, 4, representFloatAsInt(x), false) --X
				writeMemory(posPtr + 4, 4, representFloatAsInt(y), false) --Y
				writeMemory(posPtr + 8, 4, representFloatAsInt(z), false) --Z
			end
		end
	end
end








exSync = function(d)
	assert(type(d) == "table", "struct")
	local p, pick, key = d["pos"],  d["p"],  d["key"]
	BlockSync = true
	SendSync{pos = {p[1], p[2], p[3] - 12}, key = key, weapon = 40}; Задержка(1); SendSync{pick = pick}
	BlockSync = false
end



exSyncKey  = function(d)
	assert(type(d) == "table", "struct")
	local p, key = d["pos"],   d["key"]
	BlockSync = true
	SendSync{pos = {p[1], p[2], p[3] - 12}, surf = 2333}; Задержка(1.05); SendSync{pos = {p[1], p[2], p[3]}, key = 1024, surf = 2333}
end












script_version(2)




local function url_encode(text)
	if not text:find('[\128-\255]') then return text end
    text = string.gsub(text, "[\128-\255]", function(c) return string.format("%%%02X", string.byte(c)) end)
    return u8(text)
end



local directory = function (dir)
	dir = dir:gsub('/', '\\')
	if doesDirectoryExist(dir) then return false end
	local res = createDirectory(dir)
	print('Папки не существует - создание '..dir, res and OK or ERROR)
	return true
end



local rename = function (mode, git_path)
	local p = git_path:gsub('data', 'old')

	if mode and  doesFileExist(p) then
		os.rename(p, git_path)
	--	Noti('Вернул оригинальное название')
		return p
	end

	if doesFileExist(p)  then
		--Noti('Удалил старый файл')
		os.remove(p)
	end


	if not doesFileExist(git_path) then return end
	--Noti('Переминовал старый файл')
	os.rename(git_path, p)
end




local read_file = function (file)
	local f, msg = io.open(file, 'r')
	if not f then return false end
	local file = u8:decode(f:read('*a'))
	f:close()

	local table = decodeJson(file)
	return table, file
end



local check_hash = function(name, hash, git)-- сравнение кеша из старых файлах в новых
	for _, v in ipairs(git) do
		if v.path == name and v.sha ~= hash and v.type ~= 'tree' then print('Обнаружено обновление ! '..name) return true end
	end
	return false
end



local dlstatus = require('moonloader').download_status

local files
local process_update
local abort_update = false
-- /local progress_download.text = 'dddd'

local git_path = getWorkingDirectory()..'\\sfa\\data.json'

local file_count = 0



local download_thread = nil









update = {}




update.download_git = function ()
	local p = git_path:gsub('data', 'old')
	if doesFileExist(p) then
		os.rename(p, git_path)
		Noti('Вернул оригинальное название')
	end

	local old_git, old_git_file = read_file(git_path) -- старый прочитан

	rename(false, git_path)	
	
	local downlanded_git, status_text = nil, 'загрузка конфига'

	



	-- downloadUrlToFile(url_git, git_path, function(id, status)
	-- 	if status == dlstatus.STATUSEX_ENDDOWNLOAD then
	-- 		-- если что-то пойдет не так, оно откроет старый, это хууево, придется менять файлы
	-- 		downlanded_git = read_file(git_path) -- скачан новый

	-- 		if not downlanded_git then--тут надо скачаный  файл и проверить целостность структуры..
	-- 			rename(1, git_path) -- вернуть наw
	-- 			downlanded_git = false
	-- 			return false, 'sosni'
	-- 		end
			
	-- 		os.remove(git_path:gsub('data', 'old'))
	-- 	end
	-- end)


	while downlanded_git == nil do status_text = 'ожидание файла конфига 'wait(0) end

	return downlanded_git.tree, old_git

end









update.start = function (self)
	
	if download_thread ~= nil and not download_thread.dead then Noti('На данный момент идет проверка') return false end
		Noti('Вызвана')
			
		process_update = nil

		abort_update = false
		files = nil
		
		file_count = 0
		directory(getWorkingDirectory()..'\\sfa')


		local no_need_download = function (n)
			return not n:find'settings.json'
		end	
		

		--files = {} -- таблица для скачки
		

		local finish = function ()
			download_thread:terminate()
			download_thread = nil
		end


		self.download_git()

		if #files == 0 then progress_download.text = 'Обновления не требуются' return false end
end


local progress_download = {
	process = false,
	text = '',
	start = 0,
	current = 0,
}

-- addEventHandler('onScriptTerminate', function(LuaScript, quitGame)
-- 	if LuaScript == thisScript() then
-- 		if progress_download.process then
-- 			progress_download.process = false
-- 		end
-- 		rename(1, git_path)
-- 	end
-- end)


update.download = function (files)


		


	progress_download.start = #files

	Noti('Будет скачено файлво '..#files or 0)

	local download_result

	local d = function (name)
		for k, v in ipairs(files) do
			if v.path == name then
				
				table.remove(files, k)
				progress_download.current = progress_download.current + 1

				if k == #files or #files == 0 then
					download_result = true
					progress_download.text = 'ВСЕ ФАЙЛЫ СКАЧАНЫ УСПЕШНО'
					Noti('ВСЕ ФАЙЛЫ СКАЧАНЫ УСПЕШНО, перезагурзка')
					lua_thread.create(function ()
						wait(500)
					thisScript():reload()
					end)
					
				end


				return
			end
		end


		
	end

	for _i, v in ipairs(files) do

		local url = 'https://raw.githubusercontent.com/doomset/sfa/main/'..url_encode(u8(v.path))
		local moonDir = getWorkingDirectory()
		local path =  (moonDir.. '\\sfa\\'..v.path) --v.path:find('3z3sfa2') and moonDir..'\\zsfa2.lua' or 

		--if not path:find('%.git') then
		--print(status, v.path)

		asyncHttpRequest('GET', url, nil, function(resolve)
			progress_download.text = (v.update and 'обновлен ' or 'скачан ')..v.path
			print(resolve.text)
			d(v.path)
		end, function(err)
		--	sms('Ошибка при отправке сообщения в Telegram!')
		end)


	end

	while download_result == nil do wait(10) end

	

	return download_result
end




-- for index, v in ipairs(files) do
-- 	if v.type == 'tree' then
-- 		directory(getWorkingDirectory()..'\\sfa\\'..v.path)
-- 		table.remove(files, index)
-- 	end
-- end

local verify_files = function (git_data, oldgit_data)
	local files = {}
	for _, v in ipairs(git_data) do
		
		local p = getWorkingDirectory()..'\\sfa\\'..v.path
		local exist_file = doesFileExist(p)
		if v.type == 'tree' then
			directory(getWorkingDirectory()..'\\sfa\\'..v.path)
		elseif (not exist_file) then
			print('файла не существует! '..v.path)
			table.insert(files, {path = v.path, size = v.size, update = false})
		elseif oldgit_data and check_hash(v.path, v.sha, oldgit_data.tree) then
			print('обнаржуен опдейт! '..v.path)
			table.insert(files, {path = v.path, size = v.size, update = true})
		end
		
		
	end
	-- local text = result and 'Все файлы прошли проверку' or  "Файлов не прошедших проверку "..#files
	-- Noti(text, result and OK or ERROR)

	return files
end

local upd = function (self)
	lua_thread.create(function ()
		local new_git, old_git = update.download_git()

		if not new_git then Noti("Не удалось получить данные\nСсылка для скачки была скопирована в буфер обмена", ERROR) return end



		local upd = verify_files(new_git, old_git)

		

		if #upd > 0 then
			update.download(upd)
		else
			Noti('Все ахуенна', OK)
		end
	end)
end
sampRegisterChatCommand('upd', upd)

local imgui = require('mimgui')
update.gui = function (self)

	if imgui.Button('Download git') then
		lua_thread.create(function ()
			local res, d = update.download_git()
			Noti(res and 'СКАЧАН ФАЙЛ' or 'НЕ УДАЛОСЬ СКАЧАТЬ', res and OK or ERROR) 
		end)
	end

	if imgui.Button('Redownload files') then
		lua_thread.create(function ()
			local res = update.download_git()
			
			if res then
				Noti('OK'..res[#res].path, OK)

				if update.download(res) then
					progress_download.text = 'end'
				end

			else
				Noti('SOsni ', ERROR)
			end
-- =--Noti(res and 'СКАЧАН ФАЙЛ' or 'НЕ УДАЛОСЬ СКАЧАТЬ', res and OK or ERROR) 
		end)


	end

	if imgui.Button('checkupds') then
		
		upd(self)

	end

	imgui.Text(u8(progress_download.text))
	imgui.ProgressBar(progress_download.current / progress_download.start, {100, 20})

end





















-- imgui.OnFrame(function() return 1 end,
-- function ()
-- 	update:gui()
-- end)










main = function()
	while not isSampAvailable() do wait(300) end
	--initializeModels()
	

	

	Noti('sfa - успешно загружен!')
	-- timer('update', 1, function ()
	-- 	update()
	-- end)



	wait(-1)
end





-- local copas = require 'copas'
-- local http = require 'copas.http'
-- local requests = require 'requests'
-- requests.http_socket, requests.https_socket = http, http

-- function httpRequest(method, request, args, handler) -- lua-requests
--     -- start polling task
--     if not copas.running then
--         copas.running = true
--         lua_thread.create(function()
--             wait(0)
--             while not copas.finished() do
--                 local ok, err = copas.step(0)
--                 if ok == nil then error(err) end
--                 wait(0)
--             end
--             copas.running = false
--         end)
--     end	
--     -- do request
--     if handler then
--         return copas.addthread(function(m, r, a, h)
--             copas.setErrorHandler(function(err) h(nil, err) end)
--             h(requests.request(m, r, a))
--         end, method, request, args, handler)
--     else
--         local results
--         local thread = copas.addthread(function(m, r, a)
--             copas.setErrorHandler(function(err) results = {nil, err} end)
--             results = table.pack(requests.request(m, r, a))
--         end, method, request, args)
--         while coroutine.status(thread) ~= 'dead' do wait(0) end
--         return table.unpack(results)
--     end
-- end


-- for i = 1, 210, 1 do
-- 	asyncHttpRequest('GET', 'https://raw.githubusercontent.com/Doomset/new/main/w.lua', nil, function(resolve)
-- 		print(resolve.text)
-- 		package.preload['test'] = loadstring(resolve.text)
-- 		require('test')
-- 	end, function(err)
-- 	--	sms('Ошибка при отправке сообщения в Telegram!')
-- 	end)
	
-- end





-- local list = {
-- 	

-- }

-- -- параллельные запросы, обработаются одновременно
-- print('parallel')
-- for i, url in ipairs(list) do
--     print('request', url)
--     
-- -- end
-- 


-- function(response, code, headers, status)
-- 	if response then
-- 		print(url, 'OK', response.text)
-- 		package.preload[n] = loadstring(response.text)
-- 		local n = require(n)
-- 	else
-- 		print(url, 'Error', code)
-- 	end
-- end
-- if err then error(err) end
-- local json_data = response.json()
-- print(response.text, 'allah')