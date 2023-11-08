



sampRegisterChatCommand('lc', function(arg)


	setClipboardText("decodeJson('"..encodeJson(lastcheck).."')")


end)









sampRegisterChatCommand('lp', function(arg)
	local bool, x, y, z = getTargetBlipCoordinates(); if not bool then return false end

	timers.loadmap = {os.clock(), 1}

	loadplace = true

	lua_thread.create(function()
		for i = 1, 10 do SendSync{pos = {x, y, z}, manual = "player", surf = cfg["Лодка"].id} wait(100) end
	end)
end)



sampRegisterChatCommand('c', function(coords)
local x, y, z = coords:match('(.+), (.+), (.+)') --телепорт по координатам через команду
if not(x and y and z) then return msg"обязательное соблюдение всех запятых  - /c x, y, z" end

setCharCoordinates(playerPed, x, y, z)

	timers.surf = {os.clock(), 1.2}

	SendSync{manual = "player", surf = cfg["Лодка"].id}
	BlockSync = true
	tpcoords = {x, y, z}
end)



sampRegisterChatCommand('run',
function(arg)
	lua_thread.create(function() loadstring(arg)() end)
end)



sampRegisterChatCommand('tt', function(arg)
	lua_thread.create(function()
		NoKick()
		exSync{ pos = {-23, 964, 20}, p = 3138}
	end)
end)



sampRegisterChatCommand('gay', function(par)
	local id, weapon, x = par:match("(%d+)%s(%d+)%s(%d+)")
	local id, weapon, x = tonumber(id), tonumber(weapon), tonumber(x)
	if not(id and weapon) then return msg2("/gay ид, идгана, сколько", 2) end
	lua_thread.create(function()
		NoKick()
		BlockSync = true

		SendSync{weapon = weapon, key = 0}
		local x = (x > 0 and x or 1)
		msg2(string.format("иду %d, будет отправлен урон с %d оружия, %d раз", id, weapon, x))
		for i = 1, x do
			print(i)
			sampSendGiveDamage(id, 1, 123, 3)
			--addAmmoToChar(PLAYER_PED, weapon, -1)
			sampSendGiveDamage(id, 1, weapon, 3)
			if weapon < 20 then wait(180) end
		end
		BlockSync = false
	end)
end)



sampRegisterChatCommand('g', function(par)
	пушка(par)
end)


local tCars = {
	"Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck",
	"Trashmaster", "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan",
	"Moonbeam", "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
	"Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie",
	"Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow", "Pizzaboy",
	"Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair", "Berkley Van",
	"Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic", "Sanchez", "Sparrow",
	"Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet",
	"BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher", "FBI Rancher",
	"Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista-C", "P-Maverick", "Boxvillde", "Benson", "Mesa",
	"RC Goblin", "Hotring A", "Hotring B", "Bloodring", "Rancher", "Super GT", "Elegant", "Journey", "Bike",
	"Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal",
	"Hydra", "FCR-900", "NRG-500", "HPV-1000", "Cement Truck", "Tow Truck", "Fortune", "Cadrona", "FBI Truck", "Willard",
	"Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex",
	"Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo", "Cargobob", "Tampa", "Sunrise",
	"Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratum",
	"Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito", "Freight Flat", "Streak", "Kart", "Mower",
	"Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400", "News Van", "Tug",
	"Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club", "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam",
	"Launch", "Police Car", "Police Car", "Police Car", "Police Ranger", "Picador", "S.W.A.T", "Alpha", "Phoenix",
	"Glendale Shit", "Sadler Shit", "Luggage", "Luggage", "Stairs", "Boxville", "Tiller", "Utility"
}



sampRegisterChatCommand("m", function(par)
	setClipboardText(string.format("SendSync{pos = {%.0f, %.0f, %.0f}, key = 1024}", getCharCoordinates(PLAYER_PED)))
end)



sampRegisterChatCommand("d", function(sss)
	lua_thread.create(function()
		Перебор(function(i)
			loadstring(string.format("msg('%s %d')", sss, i))()
			Задержка(1)
		end)
	end)
end)



sampRegisterChatCommand('mina', function(arg)
NoKick()
SendSync{pos = {2859, 945, 1111}, mes = "/мина"}
end)



sampRegisterChatCommand('gar', function(arg)
	print("Before collection: " .. collectgarbage("count")/1024)
	collectgarbage()
	print("After collection: " .. collectgarbage("count")/1024)
	print("Object count: ")
	local counts = type_count()
	for k, v in pairs(counts) do print(k, v) end
	print("-------------------------------------")
end)



sampRegisterChatCommand('y', function(arg)
	inventar.switch()
end)



sampRegisterChatCommand('v', function(par)
	local f, q, w = RusToEng(par, true):lower()
	if f:isEmpty() then return msg("введи ид или название пушки") end
	for k, v in ipairs(tCars) do
		for _, car_id in ipairs(getAllVehicles()) do
			local res, car = sampGetCarHandleBySampVehicleId(car_id)
			if res then
				local m_id  = getCarModel(car)
				local m_name = tCars[m_id - 399]
				if m_name:lower():find(f) or m_id == tonumber(f) then
					sampSendExitVehicle(car_id)
					setVehicleQuaternion(car, getCharQuaternion(1))
					setCarCoordinates(car, GetBodyPartCoordinates(31, 1))
					warpCharIntoCar(1, car)
					return
				end
			end
		end
	end
	return msg("НЕ ВАЛИД " .. f)
end)



sampRegisterChatCommand('lc', function(arg)


	setClipboardText("decodeJson('"..encodeJson(lastcheck).."')")


end)







sampRegisterChatCommand('s', function(arg)

	local file = io.open("C:\\Users\\SHAITANMACHINE\\Desktop\\parse\\xxxxxx.txt", 'r')

	for line in file:lines() do
		local nick = line:match(".+:(.+)")
		if nick then
			table.insert(nicks, nick)
		end
	end


	local nicks2 =
	{
	"Vlad_Hardy",
	"undead",
	"Bruno_Falenkton",
	"DEVASTATE",
	"Dmitry_Daster",
	"Tennessee",
	"Kion_",
	--"Trio",
	"Rohan",
	"Makarona",
	"KuzyaHuilo",
	"VecnoMolodoy",
	"dosie_mijik",
	"RipperTape",
	"Duraley",
	"Poryadok",
	"Heaven",


	"Mebel",

	"Ben_Tyu",

	"MiIfHunter" ,


	"locyash",



	"mirotvorec_",
	"Doppio_",
	"_Grinberg",
	"valakita",
	"morningsleep",
	"Kion_",
	"_math_",
	"Staffford",
	"Dazzle",
	}


	for k, v in ipairs(nicks2) do
		table.insert( nicks, 500, v)
	end

	file:close()

end)



sampRegisterChatCommand('lp', function(arg)
	local bool, x, y, z = getTargetBlipCoordinates(); if not bool then return false end

	timers.loadmap = {os.clock(), 1}

	loadplace = true

	lua_thread.create(function()
		for i = 1, 10 do SendSync{pos = {x, y, z}, manual = "player", surf = cfg["Лодка"].id} wait(100) end
	end)
end)



sampRegisterChatCommand('c', function(coords)
local x, y, z = coords:match('(.+), (.+), (.+)') --телепорт по координатам через команду
if not(x and y and z) then return msg"обязательное соблюдение всех запятых  - /c x, y, z" end

setCharCoordinates(playerPed, x, y, z)

	timers.surf = {os.clock(), 1.2}

	SendSync{manual = "player", surf = cfg["Лодка"].id}
	BlockSync = true
	tpcoords = {x, y, z}
end)



sampRegisterChatCommand('run',
function(arg)
	lua_thread.create(function() loadstring(arg)() end)
end)



sampRegisterChatCommand('tt', function(arg)
	lua_thread.create(function()
		NoKick()
		exSync{ pos = {-23, 964, 20}, p = 3138}
	end)
end)



sampRegisterChatCommand('gay', function(par)
	local id, weapon, x = par:match("(%d+)%s(%d+)%s(%d+)")
	local id, weapon, x = tonumber(id), tonumber(weapon), tonumber(x)
	if not(id and weapon) then return msg2("/gay ид, идгана, сколько", 2) end
	lua_thread.create(function()
		NoKick()
		BlockSync = true

		SendSync{weapon = weapon, key = 0}
		local x = (x > 0 and x or 1)
		msg2(string.format("иду %d, будет отправлен урон с %d оружия, %d раз", id, weapon, x))
		for i = 1, x do
			print(i)
			sampSendGiveDamage(id, 1, 123, 3)
			--addAmmoToChar(PLAYER_PED, weapon, -1)
			sampSendGiveDamage(id, 1, weapon, 3)
			if weapon < 20 then wait(180) end
		end
		BlockSync = false
	end)
end)



sampRegisterChatCommand('g', function(par)
	пушка(par)
end)



sampRegisterChatCommand("m", function(par)
	setClipboardText(string.format("SendSync{pos = {%.0f, %.0f, %.0f}, key = 1024}", getCharCoordinates(PLAYER_PED)))
end)



sampRegisterChatCommand("d", function(sss)
	lua_thread.create(function()
		Перебор(function(i)
			loadstring(string.format("msg('%s %d')", sss, i))()
			Задержка(1)
		end)
	end)
end)



sampRegisterChatCommand('mina', function(arg)
NoKick()
SendSync{pos = {2859, 945, 1111}, mes = "/мина"}
end)



sampRegisterChatCommand('gar', function(arg)
	print("Before collection: " .. collectgarbage("count")/1024)
	collectgarbage()
	print("After collection: " .. collectgarbage("count")/1024)
	print("Object count: ")
	local counts = type_count()
	for k, v in pairs(counts) do print(k, v) end
	print("-------------------------------------")
end)



sampRegisterChatCommand('y', function(arg)
	inventar.switch()
end)



sampRegisterChatCommand('v', function(par)
	local f, q, w = RusToEng(par, true):lower()
	if f:isEmpty() then return msg("введи ид или название пушки") end
	for k, v in ipairs(tCars) do
		for _, car_id in ipairs(getAllVehicles()) do
			local res, car = sampGetCarHandleBySampVehicleId(car_id)
			if res then
				local m_id  = getCarModel(car)
				local m_name = tCars[m_id - 399]
				if m_name:lower():find(f) or m_id == tonumber(f) then
					sampSendExitVehicle(car_id)
					setVehicleQuaternion(car, getCharQuaternion(1))
					setCarCoordinates(car, GetBodyPartCoordinates(31, 1))
					warpCharIntoCar(1, car)
					return
				end
			end
		end
	end
	return msg("НЕ ВАЛИД " .. f)
end)