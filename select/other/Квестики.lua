local imgui, quests = require('mimgui')
local extra = require('sfa.imgui.extra')
local ffi = require('ffi')
local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof

local stagequest = 1
local totaltime = 0
local selectQuest = new.int(0)
local ar = {u8"Связной",u8"Зомботех",u8"Триангуляция",u8"Институт",u8"Тюрьма",u8"Последняя ниточка",u8"Выжигатель мозгов",u8"Алькатрас",u8"Вспомнить всё",u8"Пескадеро",u8"Шпионаж",u8"База",u8"Сопротивление",u8"Слабое звено",u8"Нет судьбы",u8"Шаман",u8"Ситеки",u8"Персирваль",u8"Парфюмер",u8"Ритуал",u8"Клятва Почтальонов",u8"Внешние Поставки",u8"Продовольствия",u8"Энергоснабжение",u8"Добыча Топлива",u8"Металлургия",u8"Метрополитен",u8"Важный Информатор",u8"Первобытное Зло",u8"Неоанархисты",u8"Честь и Отвага",u8"Темные дела",u8"Изучение Зоны",u8"Секретные Материалы",u8"Платиновая фишка"}
local cArrayF = imgui.new['const char*'][#ar](ar)
---


Взять_Квест = function(номер)
  --  local quest_name =  u8:decode(ar[selectQuest[0] + 1])
	handler('dialog', {t = 'Бар', s = 2, i = 'Поговорить с барменом'})
	handler('dialog', {t = 'Задания от Бармена', s = 3 + номер, i = ''})

	SendSync{pos = {-224.875, 1407.5, 27.75}, pick = Pickup('Бармен (Карсон)'), force = true, key = 0, armor = номер == 1 and 100 or nil, weapon = 31}
end


local gui = function ()
    local t = quests
    imgui.SetCursorPosY(3)
    imgui.PushFont(font[20])
    extra.color_text(imgui.ImVec4(123 / 255.0, 123 / 255.0, 111 / 255.0, 1), ar[selectQuest[0] + 1] )
    if imgui.IsItemClicked(0) then
        lua_thread.create(function()
            for k, v in ipairs(t[selectQuest[0]+ 1]) do
                local n = v:match("wait%((%d+)%)")
                if n then
                    clockBar = {os.clock(), n}
                end
                stagequest = k
                wait(1)
                pcall( loadstring( v ))
                --msg(v)\

            end
        end)
    end
    imgui.PopFont()

    imgui.SameLine()

    imgui.SetCursorPosY(7)


    imgui.PushFont(font[14])

    extra.color_text(imgui.ImVec4(123 / 255.0, 123 / 255.0, 44 / 255.0, 1), "~"..totaltime.." sec")


    imgui.PopFont()


    imgui.SetCursorPos{imgui.GetWindowSize().x  - 280 /2 - 10, 3}

    imgui.PushItemWidth(150)
    if imgui.Combo("###cc", selectQuest, cArrayF , #ar) then  end
    imgui.PopItemWidth()

    totaltime = 0 



    imgui.SetCursorPosY(30)

    imgui.BeginChild("quests", {imgui.GetWindowSize().x, 270 - 30}, true)


    for k, v in ipairs(t[selectQuest[0]+ 1]) do

        local p = imgui.GetCursorScreenPos()
        imgui.Text(tostring(k))
        imgui.SameLine()



        imgui.PushFont(font[13])

        local n = v.action:match("wait%((%d+)%)")

        if n then totaltime = totaltime + n / 1000 end

        
    
        
        imgui.PopFont()
        

        if k == stagequest then 
            
            local f, b

            if clockBar and clockBar[1] then
                f, b = extra.bringFloatTo(1, imgui.GetWindowSize().x, clockBar[1],  clockBar[2] / 1000)
            end

            local col = imgui.GetColorU32Vec4(extra.setAlpha(imgui.GetStyle().Colors[imgui.Col.Button], 0.5))

            local col2 = imgui.GetStyle().Colors[imgui.Col.ButtonActive]
            local col2 = imgui.GetColorU32Vec4({col2.x, col2.y, col2.z, 0.1})
            --AddLine({pos.x + 15, pos.y - 5}, {pos.x +  imgui.CalcTextSize(text).x + 30, pos.y - 5}, imgui.GetColorU32Vec4(col), 3)

            imgui.GetWindowDrawList():AddRectFilledMultiColor(p, {p.x + (b and f or imgui.GetWindowSize().x), p.y + 15}, col, col, col2, col2);

           
        end

        if imgui.BoolText(false, v.info == '' and u8(v.action) or u8(v.info)) then
            lua_thread.create(function()
                imgui.SetScrollHereY()
                NoKick()

                if n then
                    clockBar = {os.clock(), n}
                end
                stagequest = k
                loadstring( v.action ) ()
               

            end)
        end

        if imgui.IsItemClicked(1) then
            local name =  u8:decode(ar[selectQuest[0] + 1])
            os.execute(string.format('code --g "%s\\lib\\sfa\\select\\other\\квестики\\%s.lua:%d:14"', getWorkingDirectory(), name, k + 2) )
        end

        extra.Separator(-5, -5)


    end
    --stagequest = -1

    
    imgui.EndChild()

end

local mod = {'Квестики ', 'CIRCLE_EXCLAMATION',  true, "Залупа хуй говно", gui}






local function getFilesInPath(path, ftype)
	local Files, SearchHandle, File = {}, findFirstFile(path .. "\\" .. ftype)
	table.insert(Files, File)
	while File do
		File = findNextFile(SearchHandle)
		table.insert(Files, File)
	end
	return Files
end




-- local campare = ar
-- for ind, table_1 in ipairs(campare[2]) do
-- 	for k, table_2 in ipairs(list[2]) do
-- 		if table_2.name == table_1 then
-- 			table.remove(list[2], k)


-- 			list[2][#list[2]+1] = list[2][ind]
			
			
-- 			list[2][ind] = table_2
-- 			break
-- 		end
-- 	end
-- end


quests = {}
for k, v2 in ipairs(ar) do
    local v2 = u8:decode(v2)
    local req = require('sfa.select.other.квестики.'..v2)
    --print(req)
    table.insert(quests, req)
end






 
quests2 = {
    {
        --'Связной'
        "NoKick() -- писька", --anticheat
		"Надо_Нарыть()",
       -- "Надо_Нарыть()",
     --   "wait(3200)",
		
		"пушка('31')",
		"addArmourToChar(PLAYER_PED, 100)",
		"BlockSync = true",
        "handler('dialog', {t = 'Связной'})",
		"Задержка(1)",
        "Взять_Квест(1)",
		"Задержка(3)",

		
		
		"NoKick()",

		"handler('dialog', {t = 'Записка'})",
		--"SendSync{pos = {-145, 437, 12}}",
		"Задержка(1)",


		"NoKick()",
        "SendSync{ pos = {211.5 , 1922.875 , 17.625}, pick = cfg['Пикапы']['2152.09'].id}",
        "SendSync{ pos = {308.68273925781, -131, 1099}}",
        "SendSync{ pos = {-145, 437, 12}}",
		"Задержка(0)",

		

		"NoKick()", 
        "local p=cfg['Пикапы']['1012.29'] \n exSync{ pos = p.pos, p = p.id}",
        "local p=cfg['Пикапы']['2567.37']  exSync{ pos = p.pos, p = p.id}",
		"NoKick()", 
        "local p=cfg['Пикапы']['1902.39']  exSync{ pos = p.pos, p = p.id}",
        "local p=cfg['Пикапы']['685.78']   exSync{ pos = p.pos, p = p.id}",
		"Задержка(1)",
		"BlockSync = false",
		
        "SendSync{ pos = {278.30606079102, 1360.9072265625, 10.625912666321}}",
		
    },
    {
        --Зомботех
        "BlockSync = true",
		"NoKick()",
		"handler('dialog', {t = 'Зомботех'})",
        "Взять_Квест(2)",
		"Задержка(3)",
        "SendSync{pos = {-1950.9389648438, 684.74877929688, 46.5625}, key = 1024}",
		"Задержка(3)",
        "SendSync{pos = {-1980.14453125, 685.33709716797, 46.568286895752}, key = 1024}",
		"Задержка(3)",
		"NoKick()",
        "SendSync{pos = {-1982.2542724609, 688.77996826172, 46.718990325928}}",
        "wait(42000)",
		"NoKick()",
		"handler('dialog', {t = 'Регистрационный журнал'})",
        "SendSync{pos = {207.6248626709, -100.43748474121, 1105.2578125}, key = 1024}",
		"Задержка(3)",
        "SendSync{pos = {201.95471191406, -100.67431640625, 1105.2578125}, key = 1024}",
        "Задержка(3)",
        "SendSync{pos = {200.39622497559, -105.26345825195, 1105.1328125}, key = 1024}",
		"NoKick()",
        "Задержка(3)",
        "SendSync{pos = {213.31997680664, -109.29724884033, 1105.140625}, key = 1024}",
        "Задержка(3)",
        "SendSync{pos = {202.3279876709, -96.121131896973, 1105.2578125}, key = 1024}",
        "Задержка(3)",
		"handler('dialog', {t = 'Z-инжектор', s = 0, i = 'Добавить вирус'})",
		"handler('dialog', {t = 'Z-инжектор', s = 2, i = 'Подопытный: животное'})",
		"handler('dialog', {t = 'Z-инжектор', s = 5, i = 'Запустить установку'})",
		"BlockSync = false",
        "SendSync{pos = {202.87719726563, -109.52869415283, 1105.1328125}, key = 1024}",
        "wait(68000)",
		
        "SendSync{ pos = {283, 1362, 11}, pick = cfg['Пикапы']['1656.22'].id, force = true}",
    },
    {
        --'Триангуляция'
        'NoKick()', --anticheat
        'SendSync{ pos = {246.46725463867, 67.714195251465, 2003.6405029297, key, 414)',
        'setCharCoordinates(playerPed, 257, 1371, 11)',
        'sampSendDialogResponse(123,1,5, _)',
        'sampSendDialogResponse(124,1,5, _)',
        'SendSync{ pos = {-2820.7946777344, 2718.2194824219, 236.98068237305)',
        'sampSendDialogResponse(125,1,3, _)',
        'SendSync{ pos = {-2238.4741210938, -1712.6759033203, 480.86212158203)',
        'sampSendDialogResponse(125,1,3, _)',
        'SendSync{ pos = {914.05487060547, -21.621919631958, 94.639343261719)',
        'sampSendDialogResponse(125,1,3, _)',
        'SendSync{ pos = {-947.46270751953, -2099.5795898438, 116.57061767578, key, 419)',
        'sampForceOnfootSync()',
        'wait(4000)',
        "SendSync{ pos = {283, 1362, 11}, pick = cfg['Пикапы']['1656.22'].id, force = true}",
    },
    {
        --Институт
        'NoKick()', --anticheat
        'sampSendDialogResponse(30,1,0, 1)',
        'sampSendDialogResponse(356,1,-1, 1)',
        'SendSync{ pos = {615.625 , -72 , 997.875, key, 389)', 
        'sampSendDialogResponse(30,1,0, _)',
        'sampSendDialogResponse(356,1,-1, 1)',
        'wait(300)',
        'sampCloseCurrentDialogWithButton(0)',
        'wait(3400)',
        'SendSync{ pos = {71.45972442627, 1218.8194580078, 18.816408157349, 0, 192)', -- канистра
        'wait(500)',
        'sampCloseCurrentDialogWithButton(1)',
        'wait(3500)',
        'SendSync{ pos = {-224.875 , 1407.5 , 27.75, key, 364)', -- барбен
        'sampSendDialogResponse(5,1,2, _)',
        'sampSendDialogResponse(63,1,7, _)',
        'sampSendDialogResponse(127,1,-1, _)',
        'wait(250)',
        'sampCloseCurrentDialogWithButton(0)',
        'wait(3300)',
        'NoKick()', --anticheat
        'SendSync{ pos = {115.38481903076, 1875.1185302734, 17.8359375}, key = 1024}',
        'wait(3500)',
        'SendSync{ pos = {2142.4169921875, 1609.6264648438, 1000.9729003906, key, 420)',
        'sampSendDialogResponse(126, 1, 1, _)',
        'SendSync{ pos = {330.61376953125, 174.50788879395, 1014.1875}, key = 1024}',
        'SendSync{ pos = {2142.4169921875, 1609.6264648438, 1000.9729003906, key, 420)',
        'sampSendDialogResponse(126, 1, 0, _)',
        'SendSync{ pos = {2142.4169921875, 1609.6264648438, 1000.9729003906, key, 420)',
        'sampSendDialogResponse(126, 1, 3, _)',
        'SendSync{ pos = {348.86840820313, 164.70343017578, 1014.1875}, key = 1024}',
        'wait(200)',
        'setCharCoordinates(playerPed, 257, 1371, 11)',
        'sampForceOnfootSync()',
        'wait(3600)',
        "SendSync{ pos = {283, 1362, 11}, pick = cfg['Пикапы']['1656.22'].id, force = true}", -- nitro
    },
    {



        'NoKick()', --anticheat
        'SendSync{ pos = {-224.88206481934, 1407.490234375, 27.7734375, key, 364)',
        'sampSendDialogResponse(5,1,2, _)',
        'sampSendDialogResponse(63,1,8, _)',
        'sampSendDialogResponse(128,1,-1, _)',
        'SendSync{ pos = {828.92785644531, 2676.3181152344, 20.858852386475)',
        'SendSync{ pos = {2563.9689941406, -1301.5809326172, 1031.4212646484)',
        'SendSync{ pos = {2519.9680175781, -1280.6795654297, 1054.640625)',
        'SendSync{ pos = {2561.9436035156, -1297.1534423828, 1162.0390625, key, 421)',
        'SendSync{ pos = {2571.6408691406, -1280.8502197266, 1165.3671875}, key = 1024}',
        'wait(400)',
        'sampCloseCurrentDialogWithButton(0)',
        'SendSync{ pos = {2575.8620605469, -1281.814453125, 1165.3671875)',
        'wait(450)',
        'sampCloseCurrentDialogWithButton(1)',
        'SendSync{ pos = {2568.6125488281, -1281.4019775391, 1160.984375}, key = 1024}',
        'wait(3500)',
        'SendSync{ pos = {2576.345703125, -1300.6011962891, 1160.984375)',
        'wait(3500)',
        'SendSync{ pos = {-354.80850219727, 1598.115234375, 76.928810119629}, key = 1024}',
        'wait(3500)',
        'SendSync{ pos = {-349.46560668945, 1595.4333496094, 76.928810119629}, key = 1024}',
        'wait(200)',
        'closeDialog()',
        'setCharCoordinates(playerPed, 257, 1371, 11)',
        'sampForceOnfootSync()',
        'wait(3500)',
        'SendSync{ pos = {282.22265625, 1363.2806396484, 10.625912666321, key, pickupIdNitro)',
    },
	{
        --'Последняя ниточка'
        'NoKick() --anticheat',
        'SendSync(615.625 , -72 , 997.875, key, 389)',
        'sampSendDialogResponse(30,1,4, 1)',
        'sampSendDialogResponse(356,1,-1, 50)',
        'wait(200)',
        'sampCloseCurrentDialogWithButton(0)',
        'wait(3500)',
        'SendSync(-224.88206481934, 1407.490234375, 27.7734375, key, 364)',
        'sampSendDialogResponse(5,1,2, _)',
        'sampSendDialogResponse(63,1,9, _)',
        'sampSendDialogResponse(132,1,-1, _)',
        'wait(3500)',
        'sampCloseCurrentDialogWithButton(0)',
        'SendSync(325.98504638672, 1833.8894042969, 5.8336000442505}, key = 1024}',
        'wait(3500)',
        'sampSendDialogResponse(133,1,-1, _)',
        'SendSync(327.55426025391, 1830.0775146484, 5.8336005210876}, key = 1024}',
        'wait(3500)',
        'sampSendDialogResponse(134,1,-1, _)',
        'for i = 0, 50 do wait(3500)',
            'NoKick() --anticheat',
            'SendSync(-673.125 , 2705.5 , 70.625, key, 422)',
            'local chatstring = sampGetChatString(99)',
            'if chatstring == "[РАЦИЯ] Бармен: Молодец! Осмотри тут всё хорошенько!" then',
                'break',
            'end',
        'end',
        'SendSync(2229.4934082031, -1108.9223632813, 1050.8828125}, key = 1024}',
        'sampSendDialogResponse(137,1,2, _)',
        'sampSendDialogResponse(137,1,9, _)',
        'sampSendDialogResponse(137,1,6, _)',
        'sampSendDialogResponse(137,1,5, _)',
        'sampSendDialogResponse(137,0,-1, _)',
        'wait(3500)',
        'SendSync(273.68295288086, 1882.4201660156, -30.390625}, key = 1024}',
        'closeDialog()',
        'wait(25000)',
        'SendSync(282.22265625, 1363.2806396484, 10.625912666321, key, 411)',
    },
    {
        'NoKick() --anticheat',
        'SendSync(-224.88206481934, 1407.490234375, 27.7734375, key, 364)',
        'sampSendDialogResponse(5,1,2, _)',
        'sampSendDialogResponse(63,1,10, _)',
        'sampSendDialogResponse(138,1,-1, _) -- ??',
        'SendSync(2842.5952148438, 1274.5185546875, 1126.1243896484}, key = 1024}',
        'closeDialog()',
        'wait(3500)',
        'SendSync(282.22265625, 1363.2806396484, 10.625912666321, key, 411)',
    },
    {

        'NoKick()', --anticheat
        'SendSync{ pos = {615.625 , -72 , 997.875, key, 389)', -- покупка ремнабора 1 шт
        'sampSendDialogResponse(30,1,0, _)',
        'sampSendDialogResponse(356,1,-1, 1)',
        'wait(300)',
        'sampCloseCurrentDialogWithButton(0)',
        'wait(3200)',
        'SendSync{ pos = {-224.875 , 1407.5 , 27.75, key, 364)',
        'sampSendDialogResponse(5,1,2, _)',
        'sampSendDialogResponse(63,1,11, _)',
        'sampSendDialogResponse(91,1,-1, _)', -- ??
        'wait(300)',
        'sampCloseCurrentDialogWithButton(0)',
        'wait(3200)',
        'NoKick()', --anticheat
        'closeDialog()',
        'wait(10000)',
        'SendSync{ pos = {-2245.0300292969, 1803.1594238281, 5.2223129272461}, key = 1024}',
        'wait(3500)',
        'SendSync{ pos = {-2132.3974609375, 1757.6193847656, 9.6163787841797}, key = 1024}',
        'wait(3500)',
        'SendSync{ pos = {-2215.8662109375, 1770.2156982422, 15.643932342529}, key = 1024}', -- крыша
        'wait(12000)',
        'SendSync{ pos = {2192.427734375, -1215.470703125, 1149.0234375, key, pickupIdRuna)', -- руна
    },
    {
        'sampForceOnfootSync()',	
        'wait(4000)',
        'SendSync{ pos = {2192.427734375, -1215.470703125, 1149.0234375, key, pickupIdRuna)',
        'wait(500)',
        'sampSendDialogResponse(98,1,-1, _)',
        'wait(25000)',
        'SendSync{ pos = {321.82055664063, 307.49938964844, 999.1484375, key, 588)',
        'wait(500)',
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(3500)',
        'SendSync{ pos = {322.20861816406, 302.88195800781, 999.1484375)',
        'wait(3500)',
        'SendSync{ pos = {962.77453613281, 2159.9609375, 1511.0302734375}, key = 1024}',
        'wait(500)',
        'sampSendDialogResponse(162,1,-1, _)', --- хуй знает
        'wait(3500)',
        'SendSync{ pos = {952.61456298828, 2161.0610351563, 1511.0234375}, key = 1024}',
        'wait(3500)',
        'SendSync{ pos = {951.53509521484, 2152.6865234375, 1511.0234375}, key = 1024}',
        'wait(3500)',
        'SendSync{ pos = {933.73840332031, 2167.7709960938, 1511.0302734375}, key = 1024}',
        'wait(3500)',
        'SendSync{ pos = {941.63745117188, 2147.9675292969, 1511.0234375}, key = 1024}',
        'wait(3500)',
        'SendSync{ pos = {938.17120361328, 2143.0009765625, 1511.0234375}, key = 1024}',
        'wait(3500)',
        'SendSync{ pos = {956.04608154297, 2128.6372070313, 1511.0234375}, key = 1024}',
        'wait(3500)',
        'SendSync{ pos = {958.92919921875, 2103.6499023438, 1511.0234375}, key = 1024}',
        'wait(3500)',
        'SendSync{ pos = {958.97882080078, 2098.6411132813, 1511.0240478516}, key = 1024}',
        'wait(3500)',
        'SendSync{ pos = {964.96734619141, 2133.22265625, 1511.0234375}, key = 1024}',
        'wait(3500)',
        'SendSync{ pos = {962.77484130859, 2160.1391601563, 1511.0302734375}, key = 1024}',
    },
    {
        --Пескадеро

        'sampForceOnfootSync()',

        'wait(1200)',
        'setCharCoordinates(PLAYER_PED, -779, 2430, 1064)',
        'sampForceOnfootSync()',
    
        'SendSync{ pos = {-781.5 , 2437.75 , 1064.25, key, pickupIdEnterRinok)', -- винт
        'wait(300)',
        'sampSendDialogResponse(362, 1, 2, _)', -- винт
        'wait(300)',
        'sampCloseCurrentDialogWithButton(0)',
        'sendKey(64)', -- винт
        'sampSendDialogResponse(6, 1, 11, _)', -- юзануть винт
        'wait(13000)',
        'setCharCoordinates(PLAYER_PED, 209, 1872, 18)',
        'sampForceOnfootSync()',
        'wait(3000)',
        'SendSync{ pos = {321.52255249023, 1831.1295166016, 5.8336005210876, key, pickupIdReg)', -- регеструра
        'sampSendDialogResponse(13,1,6, _)',
        'wait(200)',
        'sampCloseCurrentDialogWithButton(0)',
        'wait(3500)',
    
        'SendSync{ pos = {1274.9404296875, -797.85430908203, 1589.9375, 1, 2)',
        'wait(3500)',
        'SendSync{ pos = {1231.1413574219, -838.29541015625, 1588.0076904297, 1, 2)',
        'wait(3500)',
        'SendSync{ pos = {1271.4487304688, -786.41485595703, 1590.6697998047}, key = 1024}',
        'wait(3500)',
        'SendSync{ pos = {1272.453125, -793.49896240234, 1589.9288330078}, key = 1024}',
        'wait(3500)',
        'SendSync{ pos = {1285.0417480469, -809.87536621094, 1589.9375}, mes = "ключ")',
        'wait(3500)',
        'setCharCoordinates(PLAYER_PED, 1267.1583251953, -834.80236816406, 1585.6328125)',
        'wait(3500)',
        'SendSync{ pos = {1267.1583251953, -834.80236816406, 1585.6328125}, key = 1024}',--код
        'sampSendDialogResponse(137,1,2, _)',
        'sampSendDialogResponse(137,1,0, _)',
        'sampSendDialogResponse(137,1,4, _)',
        'sampSendDialogResponse(137,1,5, _)',
        'sampSendDialogResponse(137,0,-1, _)',
        'wait(200)',
        'sampCloseCurrentDialogWithButton(0)',
        'SendSync{ pos = {1234.0885009766, -819.9892578125, 1583.15625}, key = 1024}',
        'wait(3500)',
        'SendSync{ pos = {1259.2570800781, -819.70001220703, 1584.2338867188}, key = 1024}',
        'wait(3500)',
        'SendSync{ pos = {1241.5676269531, -837.04772949219, 1584.0078125}, key = 1024}',
        'wait(5000)',
        'setCharCoordinates(playerPed, 1227.2583007813, -814.55963134766, 1582.0078125)',
        'wait(10000)',
        'for i = 0, 9999 do',
            'wait(200)', --цикл взлома двери,обязательно, иначе квест сломан
            'sendKey2(16)',
            'local chatstring = sampGetChatString(99)',
            'if chatstring == "Отлично, дверь открыта!" then',
                'break',
            'end',
        'end',
        'sampForceOnfootSync()',
        'wait(3500)',
        'SendSync{ pos = {1230.6342773438, -807.64068603516, 1584.0078125, key, pickupIdNout)',
        'sampSendDialogResponse(103,1,6, _)',
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(450)',
        'sampCloseCurrentDialogWithButton(1)',
        'wait(3500)',
        'SendSync{ pos = {1266.3402099609, -796.26470947266, 1584.0078125}, key = 1024}', -- стакан сводой
        'wait(3500)',
        'SendSync{ pos = {1276.1774902344, -794.18310546875, 1584.171875}, key = 1024}', -- тушение камина
        'wait(3500)',
        'SendSync{ pos = { 1276.1774902344, -794.18310546875, 1584.171875, 1, 2)', -- взятие ключа с камина
        'wait(3500)',
        'setCharCoordinates(playerPed, 1255.4814453125 , -792.38885498047 , 1584.234375)',
        'SendSync{ pos = {1254.5471191406, -792.13586425781, 1584.0078125, key, pickupIdKlava)',
        'sampSendDialogResponse(104, 1, 8, _)',
        'sampSendDialogResponse(104, 1, 1, _)',
        'sampSendDialogResponse(104, 1, 7, _)',
        'sampSendDialogResponse(104, 1, 3, _)',
        'sampSendDialogResponse(104, 0, -1, _)',
        'wait(3500)',
        'SendSync{ pos = {1227.2149658203, -809.80316162109, 1584.0078125}, mes = "цербер")',
        'wait(4500)',
        'sampCloseCurrentDialogWithButton(0)',
        'SendSync{ pos = {1226.9484863281, -809.79089355469, 1584.0078125}, key = 1024}',
        'wait(3500)',
        'SendSync{ pos = {1263.345703125, -765.64953613281, 1584.0078125}, key = 1024}',
        'wait(3500)',
        'SendSync{ pos = {1241.6315917969, -777.63140869141, 1584.0078125, key, pickupIdEnterCerber)',
        'wait(3500)',
        'SendSync{ pos = {1233.8695068359, -768.09875488281, 1583.9953613281}, key = 1024}',
        'freezeCharPosition(playerPed, false)',
    },
    {
        'sampForceOnfootSync()',
        'wait(1200)',
        'SendSync{ pos = {2190.8620605469, -1216.052734375, 1149.0234375, key, pickupIdRuna)', -- взятие пикапа в пескадеро
        'setCharCoordinates(PLAYER_PED, 195, 1875, 18)',
        'sampForceOnfootSync()',
        'wait(500)',
        'sampSendDialogResponse(257, 1, 1, _)',
        'wait(3500)',
        'SendSync{ pos = {224.2770690918, 1823.193359375, 6.4140625, key, pickupIdShtab)', -- взятие пикапа в анклаве
        'sampSendDialogResponse(162, 1, 1, _)',
        'wait(3500)',
        'SendSync{ pos = {3283.5146484375, 374.64831542969, 15.417862892151}, key = 1024}', -- лопата
        'wait(10000)',
        'SendSync{ pos = {3238.8508300781, 405.86001586914, 15.418872833252}, key = 1024}', -- генератор
        'wait(3500)',
        'SendSync{ pos = {3257.681640625, 361.07485961914, 15.417862892151}, key = 1024}', -- бочка
        'wait(3500)',
        'SendSync{ pos = {3238.8508300781, 405.86001586914, 15.418872833252}, key = 1024}',-- генератор
        'sampSendDialogResponse(258, 1, 2, _)',
        'wait(10000)',
        'SendSync{ pos = {3284.8601074219, 400.16119384766, 23.116710662842}, key = 1024}', -- заправить
        'wait(3500)',
        'SendSync{ pos = {3274.8957519531, 415.90298461914, 15.417812347412}, key = 1024}',
        'SendSync{ pos = {3269.9260253906, 415.00527954102, 15.474172592163}, key = 1024}',
        'SendSync{ pos = {3257.8349609375, 387.31384277344, 21.68888092041}, key = 1024}',
        'wait(8000)',
        'SendSync{ pos = {3263.1325683594, 380.3928527832, 31.272380828857}, key = 1024}',
        'wait(450)',
        'sampCloseCurrentDialogWithButton(1)',
        'SendSync{ pos = {-543.71160888672, 2582.9995117188, 53.602130889893}, key = 1024}',
        'setCharCoordinates(PLAYER_PED, 9, 1079, 20)',
        'sampForceOnfootSync()',
        'wait(3500)',
        'SendSync{ pos = {1.1447229385376, 1077.7498779297, 20.455965042114, key, pickupIdKarson)', -- пикап входа в дом, в карсон
        'SendSync{ pos = {2534.9333496094, -1680.7260742188, 1015.4985961914}, key = 1024}',
        'sendOnfootSync()',
        'wait(3500)',
        'SendSync{ pos = {2190.8620605469, -1216.052734375, 1149.0234375, key, pickupIdRuna)', -- взятие пикапа в пескадеро
        'wait(3500)',
        'SendSync{ pos = {-218.44622802734, 1406.4516601563, 27.7734375}, key = 1024}',
        'sampSendDialogResponse(260, 1, 3, _)',
        'wait(3500)',
        'SendSync{ pos = {-224.88206481934, 1407.490234375, 27.7734375, key, 364)',
        'sampSendDialogResponse(5, 1, 2, _)',
        'sampSendDialogResponse(63, 1, 13, _)',
        'wait(200)',
        'sampCloseCurrentDialogWithButton(0)',
    },
    {
        --'База'
        'sampForceOnfootSync()',
        'wait(1200)',

        'SendSync{ pos = {2190.8620605469, -1216.052734375, 1149.0234375, key, pickupIdRuna)',
        'sampSendDialogResponse(165, 1, -1, _)',
        'sampSendDialogResponse(162, 1, -1, _)',
        'wait(3500)',
        'SendSync{ pos = {247.21046447754, 67.877548217773, 2003.6405029297, key, pickupIdVoda)', -- задание пиратского клада
        'sampSendDialogResponse(123, 1, 4, _)',
        'SendSync{ pos = {-950.61541748047, 1887.4327392578, 5, key, pickupIdAkva)', -- взятие акваланга
        'SendSync{ pos = {-961.10693359375, 1936.1546630859, 9}, key = 1024}', -- заправка воздуха акваланга
        'SendSync{ pos = {3247, 388, 0}, mes = "/акваланг")',
        'wait(9500)',
        'SendSync{ pos = {994.57147216797, 1524.4965820313, 1458.4964599609}, key = 1024}', -- демонтаж колеса
        'sampSendDialogResponse(268, 1, 4, _)',
        'wait(450)',
        'sampCloseCurrentDialogWithButton(0)',
        'wait(9500)',
        'SendSync{ pos = {1010.1685791016, 1563.533203125, 1458.5009765625}, key = 1024}', -- взять гидроключ
        'sampSendDialogResponse(267, 1, 5, _)',
        'sampSendDialogResponse(270, 1, -1, _)',
        'wait(450)',
        'sampCloseCurrentDialogWithButton(0)',
        'SendSync{ pos = {1048.7854003906, 1454.3752441406, 1458.4964599609}, key = 1024}', -- Взлом двери в реакторный зал
        'SendSync{ pos = {998.59368896484, 1456.2340087891, 1458.4964599609}, key = 1024}', -- Починка какой-то хуйни
        'wait(9500)',
        'SendSync{ pos = {1023.7848510742, 1459.8570556641, 1458.7023925781}, key = 1024}', -- Реакторный зал
        'sampSendDialogResponse(269, 1, 3, _)',
        'sampSendDialogResponse(269, 1, 4, _)',
        'sampSendDialogResponse(269, 1, 5, _)',
        'sampSendDialogResponse(269, 1, 6, _)',
        'sampSendDialogResponse(269, 1, 7, _)',
        'sampSendDialogResponse(269, 1, 8, _)',
        'sampSendDialogResponse(269, 1, 9, _)',
        'SendSync{ pos = {1119.6760253906, 1560.0487060547, 1459.1319580078}, key = 1024}', -- ключ карта вороновой
        'SendSync{ pos = {1105.4825439453, 1510.0142822266, 1459.6069335938}, key = 1024}',  -- мостик
        'SendSync{ pos = {1113.6649169922, 1459.7741699219, 1459.3548583984, key, pickupIdJaga)', -- джага
        'SendSync{ pos = {1168.3275146484, 1499.6092529297, 1458.8532714844}, key = 1024}', -- комп.зал
        'SendSync{ pos = {1105.4005126953, 1510.1442871094, 1459.6069335938}, key = 1024}', -- мостик
        'SendSync{ pos = {1109.9283447266, 1560.0192871094, 1459.3489990234}, key = 1024}', -- teleport
        'wait(15000)',
        'SendSync{ pos = {2192.625 , -1217.875 , 1149, key, pickupIdRuna)',
    },
    {
        --'Сопротивление',
        'sampForceOnfootSync()',
        'wait(1200)',

        'SendSync{ pos = {2190.8620605469, -1216.052734375, 1149.0234375, key, pickupIdRuna)',
        'sampSendDialogResponse(291, 1, -1, _)',
        'SendSync{ pos = {-2446.3076171875, 2253.0061035156, 14.520360946655}, key = 1024}',
        'SendSync{ pos = {295.63763427734, -77.339263916016, 1501.515625}, key = 1024}',
        'setCharCoordinates(playerPed, -789.51751708984, 1814.091796875, 1.9651449918747)',
        'sampForceOnfootSync()',
        'wait(2500)',
        'local id, x, y, z = InCar(472)',
        'wait(3500)',
        'SendSync{ pos = {-1374.7142333984, 391.81869506836, 2000.4836425781}, key = 1024}',
        'sampSendDialogResponse(292, 1, 4, _)',
        'wait(200)',
        'sampCloseCurrentDialogWithButton(0)',
        'SendSync{ pos = {-1401.6838378906, 392.70697021484, 2000.4836425781}, key = 1024}',
        'setCharCoordinates(playerPed, -1376.8582763672, 390.27514648438, 2000.4836425781)',
        'wait(3000)',
        'setMarker(-2807.4389648438, 1812.3247070313)',
        'wait(2000)',
        'SendSync{ pos = {-1386.0206298828, 391.55056762695, 2000.4836425781}, key = 1024}',
        'SendSync{ pos = {-1371.5239257813, 390.26647949219, 2000.4836425781}, key = 1024}',
        'SendSync{ pos = {-1374.2338867188, 393.77291870117, 2000.4836425781}, key = 1024}',
        'wait(3000)',
        'SendSync{ pos = {-1367.8392333984, 390.99713134766, 2000.4836425781}, key = 1024}',
        'wait(8000)',
        'spawn()',
        'SendSync{ pos = {2190.8620605469, -1216.052734375, 1149.0234375, key, pickupIdRuna)',
    },
    {
        --'Слабое звено',
        'sampForceOnfootSync()',
        'wait(1200)',
        'setCharCoordinates(playerPed, 265.94470214844, 2546.9653320313, 16.8125)', --- самолёты
        'sampForceOnfootSync()',
        'wait(5000)',
        'samolet()',
        'wait(4500)',
        'local id, x, y, z = InCar(553)',
        'wait(5000)',
        'setCharCoordinates(playerPed, -1390.0098876953, 498.62252807617, 18.234375)', --- анклав корабль
        'sampForceOnfootSync()',
        'wait(4500)',
        'local id, x, y, z = InCar(520)',
        'wait(3500)',

        'wait(2400)',
        --freezeCarPosition(storeCarCharIsInNoSave(playerPed)',, false)',
        'SendSync{ pos = {2438.224609375, -2413.1826171875, 168.22946166992, 1, 4)',
        'setCharCoordinates(playerPed, -1312.1491699219, 502.96099853516, 18.234375)',
        'wait(3500)',
        'SendSync{ pos = {-1275.4211425781 ,  507.57699584961,   18.234399795532)',
        'wait(500)',
        'setCharCoordinates(playerPed, -1390.0098876953, 498.62252807617, 18.234375)',
        'sampForceOnfootSync()',
        'wait(3000)',
        'local id, x, y, z = InCar(520)',
        'wait(500)',
        'sampCloseCurrentDialogWithButton(0)',
    },
    {
        --'Нет судьбы',
        'sampForceOnfootSync()',
        'wait(1200)',
        
        
        'SendSync{ pos = {766.86560058594, 1989.7277832031, 5.4451775550842}, key = 1024}', --трейлеры
        'wait(3500)',
        'SendSync{ pos = {203.19691467285, -109.0666809082, 1105.1328125}, key = 1024}', -- руна
        'wait(20000)',
        'SendSync{ pos = {-12.238911628723, 2350.5419921875, 24.140625}, key = 1024}', --ферма
   
        'SendSync{ pos = {2613.5 , 2820 , 10.75, key, pickupIdKassForma)', -- форма
        'wait(3500)',
        'SendSync{ pos = {2608.1772460938, 2725.8127441406, 36.538642883301}, key = 1024}', --пистолет
        'wait(3500)',
        'SendSync{ pos = {2659.4553222656, 2759.1245117188, 10.8203125}, key = 1024}', --форма2
        'wait(3500)',
        'SendSync{ pos = {2595.75 , 2790.625 , 10.75, key, pickupIdKassEnter)', --вход на завод
        'wait(3500)',
        'SendSync{ pos = {263.58978271484, 2895.4521484375, 10.531394958496}, key = 1024}', -- второй дневник
        'wait(8000)',
        'SendSync{ pos = {2927.0241699219, 2684.7495117188, 1132.1430664063}, key = 1024}', --бумаг
        'wait(3500)',
        'SendSync{ pos = {2964.6091308594, 2710.9584960938, 1132.1430664063}, key = 1024}', --отдать бумагу
        'wait(3500)',
        'SendSync{ pos = {2944.0649414063, 2720.66796875, 1132.1430664063}, key = 1024}', -- станок
        'wait(400)',
        'sampSetCurrentDialogListItem(11)',
        'sampCloseCurrentDialogWithButton(1)',
        'wait(500)',
        'SendSync{ pos = {2973.2265625, 2719.57421875, 1138.4946289063}, key = 1024}', -- ключкарта
        'wait(3500)',
        'SendSync{ pos = {2980.1303710938, 2716.4692382813, 1144.8430175781}, key = 1024}', -- дверь
        'wait(3500)',
        'SendSync{ pos = {2981.1508789063, 2719.7380371094, 1144.8402099609}, key = 1024}', -- скин
        'wait(3500)',
        'SendSync{ pos = {2927.6884765625, 2719.7797851563, 1149.0042724609}, key = 1024}', -- гринберг
        'wait(3500)',
        'SendSync{ pos = {2971.0698242188, 2723.2668457031, 1138.4946289063}, key = 1024}', -- щиток
        'wait(400)',
        'sampSetCurrentDialogListItem(2)',
        'sampCloseCurrentDialogWithButton(1)',
        'wait(4000)',
        'SendSync{ pos = {2927.7426757813, 2721.1813964844, 1149.0042724609}, key = 1024}', -- компьютер гринберга
        'wait(450)',
        'sampCloseCurrentDialogWithButton(1)',
        'wait(150)',
        'sampCloseCurrentDialogWithButton(1)',
        'wait(150)',
        'sampCloseCurrentDialogWithButton(0)',
        'wait(3500)',
        'SendSync{ pos = {2920.06640625, 2725.4921875, 1149.0108642578}, key = 1024}',
        'wait(72000)',
        'SendSync{ pos = {2911.8598632813, 2719.3649902344, 1142.6593017578}, key = 1024}',
        'wait(400)',
        'sampSetCurrentDialogListItem(1)',
        'sampCloseCurrentDialogWithButton(1)',
        'wait(500)',
        'sampCloseCurrentDialogWithButton(1)',
        'wait(42000)',
        'SendSync{ pos = {2879.6682128906, 2703.0869140625, 1142.6593017578}, key = 1024}',
        'SendSync{ pos = {2905.4172363281, 2703.1198730469, 1142.6593017578}, key = 1024}',
        'SendSync{ pos = {2880.1323242188, 2726.5573730469, 1142.6593017578}, key = 1024}',
        'SendSync{ pos = {2899.2604980469, 2714.0891113281, 1143.8677978516}, key = 1024}',
        'wait(35000)',
        'SendSync{ pos = {2190.8620605469, -1216.052734375, 1149.0234375, key, pickupIdRuna)', -- руна
        'wait(3500)',
        'sampCloseCurrentDialogWithButton(0)',
        'wait(5000)',
        'SendSync{ pos = {312.25 , -165.875 , 999.5, key, pickupIdTamara)', -- тамараn(1)',
    },
    {
        --'Шаман'
        'sampForceOnfootSync()',
        'wait(1200)',
        'SendSync{ pos = {-224.875 , 1407.5 , 27.75, key, pickupIdBarmen)',
        'sampSendDialogResponse(5, 1, 2, _)',
        'sampSendDialogResponse(63, 1, 18, _)',
        'wait(250)',
        'sampCloseCurrentDialogWithButton(0)',
        'SendSync{ pos = {-768.70654296875, 2418.6652832031, 157.05825805664}, key = 1024}',
        'wait(3500)',
        'SendSync{ pos = {450.97738647461, -2703.7495117188, 1501.4389648438}, key = 1024}', -- шаман
        'sampSendDialogResponse(368, 1, 4, _)',
        'wait(250)',
        'sampCloseCurrentDialogWithButton(0)',
        'wait(3500)',
        'SendSync{ pos = {-1056.8673095703, 1702.1439208984, 27.222721099854}, key = 1024}', -- кактус
        'wait(3500)',
        'SendSync{ pos = {2187, -1214, 1149}, key = 1024}', -- листьи чего-то
        'wait(3500)',
        'SendSync{ pos = {450.97738647461, -2703.7495117188, 1501.4389648438}, key = 1024}', -- шаман трубка 1
        'wait(4000)',
        'SendSync{ pos = {-1131.2607421875, 1045.7127685547, 1345.7390136719}, key = 1024}',  --dialog

        'wait(50000)',
        'SendSync{ pos = {450.97738647461, -2703.7495117188, 1501.4389648438}, key = 1024}', -- шаман
        'wait(3500)',
        'SendSync{ pos = {-2091.5783691406, -1670.8073730469, 181.92127990723}, key = 1024}', -- роза
        'wait(3500)',
        'SendSync{ pos = {-2131.9672851563, 197.47515869141, 1535.3278808594}, key = 1024}', -- оллилулуывлфыввфыв
        'wait(3500)',
        'SendSync{ pos = {450.97738647461, -2703.7495117188, 1501.4389648438}, key = 1024}', -- шаман травы отнести и дунуть сразу
        'wait(60000)',
        'SendSync{ pos = {461.36328125, -2707.4353027344, 1515.5380859375}, key = 1024}', -- дилаог
        'wait(3500)', --- ??????????????????????????????????
        'SendSync{ pos = {461.36328125, -2707.4353027344, 1515.5380859375}, key = 1024}',-- шаман диалог песка
        'wait(3500)',
        'SendSync{ pos = {450.97738647461, -2703.7495117188, 1501.4389648438}, key = 1024}', -- шаман
        'wait(3500)',
        'SendSync{ pos = {709.98205566406, -322.12915039063, 7.1750736236572}, key = 1024}', -- гриб
        'wait(3500)',
        'SendSync{ pos = {-273.96948242188, -1187.0083007813, 14.510042190552}, key = 1024}',  -- кора айясуйцуйц
        'wait(3500)',
        'SendSync{ pos = {461.36328125, -2707.4353027344, 1515.5380859375}, key = 1024}', -- шаман говорить и дунуть
        'wait(5000)',
        'SendSync{ pos = {449.03366088867, -2705.5427246094, 1520.8928222656}, key = 1024}',
        'wait(5000)',
        'SendSync{ pos = {449.03366088867, -2705.5427246094, 1520.8928222656}, key = 1024}',
        'wait(5000)',
        'SendSync{ pos = {449.03366088867, -2705.5427246094, 1520.8928222656}, key = 1024}',
        'wait(3500)',
        'SendSync{ pos = {461.36328125, -2707.4353027344, 1515.5380859375}, key = 1024}', -- шаман говорить
    },
    {
        --'Ситеки',
        'SendSync{ pos = {450.97738647461, -2703.7495117188, 1501.4389648438}, key = 1024}', -- шаман
        'wait(3500)',
        'SendSync{ pos = {-768.70654296875, 2418.6652832031, 157.05825805664}, key = 1024}', -- сиплый
        'wait(3500)',

        'SendSync{ pos = {450.97738647461, -2703.7495117188, 1501.4389648438}, key = 1024}', -- шаман
        'wait(3500)',
        'SendSync{ pos = {-1056.8673095703, 1702.1439208984, 27.222721099854}, key = 1024}', -- кактус
        'wait(3500)',
        'SendSync{ pos = {709.98205566406, -322.12915039063, 7.1750736236572}, key = 1024}', -- гриб
        'wait(3500)',
        'SendSync{ pos = {450.97738647461, -2703.7495117188, 1501.4389648438}, key = 1024}', -- шаман
    
        'wait(3500)',
        'SendSync{ pos = {281.25 , 1353 , 10.625, key, pickupidSon)', -- сон
    
        'wait(40000)',
        'SendSync{ pos = {450.97738647461, -2703.7495117188, 1501.4389648438}, key = 1024}', -- шаман
        'wait(3500)',

        'SendSync{ pos = {249.875 , 67.625 , 2003.625, key, pickupIdVoda)', -- квест гребешков
        'sampSendDialogResponse(123, 1, 2, _)',
        'wait(200)',
        'sampCloseCurrentDialogWithButton(0)',
        'setCharCoordinates(playerPed, -935.09399414063, 1665.2216796875, -18.337852478027)', -- 1 раковина
        'wait(2000)',
        'SendSync{ pos = {1747.9210205078, 499.31280517578, -50.217803955078}, key = 1024}', -- тубус
        'wait(3500)',
        'SendSync{ pos = {450.97738647461, -2703.7495117188, 1501.4389648438}, key = 1024}', -- шаман
        'wait(3500)',
        'SendSync{ pos = {554.77655029297, -2796.92578125, 25.273555755615}, key = 1024}', --карта
        'wait(3500)',
        'SendSync{ pos = {450.97738647461, -2703.7495117188, 1501.4389648438}, key = 1024}', -- шаман
        'wait(1337)',
        'SendSync{ pos = {846.85150146484, 3719.7890625, 4.0636658668518}, mes = "Кетцалькоатль")',
        'wait(500)',
        'SendSync{ pos = {846.85150146484, 3719.7890625, 4.0636658668518}, key = 1024}', -- череп взять

        'wait(3500)',
        'SendSync{ pos = {450.97738647461, -2703.7495117188, 1501.4389648438}, key = 1024}', -- шаман
    },
    {
        --'Персирваль',
        'NoKick()',
        'SendSync{ pos = {450.97738647461, -2703.7495117188, 1501.4389648438}, key = 1024}', -- шаман
        'wait(3500)',
        'SendSync{ pos = {451.875 , -85.125 , 1099.5, key, 574)', --библиотека
        'wait(3500)',
        'SendSync{ pos = {450.97738647461, -2703.7495117188, 1501.4389648438}, key = 1024}', -- шаман
        'wait(3500)',
        'SendSync{ pos = {-2841.92578125, 2229.1879882813, 1507.9470214844}, key = 1024}', -- настоятель
        'wait(3500)',
        'NoKick()',
        'SendSync{ pos = {-2479.375 , 2317.875 , 4.875, key, 503)', -- покупка соли
        'sampSendDialogResponse(264, 1, 1, _)',
        'sampSendDialogResponse(356, 1, 1, 10)',
        'wait(500)',
        'sampCloseCurrentDialogWithButton(0)',
        'SendSync{ pos = {71.45972442627, 1218.8194580078, 18.816408157349, 0, 192)', -- канистра
        'wait(500)',
        'sampCloseCurrentDialogWithButton(1)',
        'wait(3500)',
        'SendSync{ pos = {282.875 , 1380 , 10.625, key, 502)', -- фрукты
        'sampSendDialogResponse(184, 1, 1, _)',
        'sampSendDialogResponse(356, 1, -1, 10)',
        'wait(250)',
        'sampCloseCurrentDialogWithButton(0)',
        'SendSync{ pos = {-2864.5751953125, 2233.5708007813, 1507.9470214844}, key = 1024}', --каша
        'SendSync{ pos = {-2841.92578125, 2229.1879882813, 1507.9470214844}, key = 1024}',  -- настоятель
        'wait(3500)',
        'NoKick()',
        'SendSync{ pos = {-67.5 , -255.375 , 993.875, key, 405)', -- завод
        'wait(500)',
        'sampCloseCurrentDialogWithButton(0)',
        'wait(800)',
        'sampSendDialogResponse(212, 1, 1, 10)',
        'wait(250)',
        'sampCloseCurrentDialogWithButton(0)',
        'wait(3500)',
        'SendSync{ pos = {-2883.7668457031, 2227.1594238281, 1511.6899414063}, key = 1024}', -- сложить вино
        'wait(3500)',
        'SendSync{ pos = {-2841.92578125, 2229.1879882813, 1507.9470214844}, key = 1024}',  -- настоятель
        'SendSync{ pos = {-1037.5971679688, -1107.4311523438, 129.21875}, key = 1024}', -- воск
        'wait(3500)',
        'SendSync{ pos = {-2841.92578125, 2229.1879882813, 1507.9470214844}, key = 1024}',  -- настоятель
        'wait(3500)',
        'SendSync{ pos = {157.91302490234, 1248.1639404297, 0.18929195404053, key, 624)', --berk
        'wait(3500)',
        'NoKick()',
        'SendSync{ pos = {450.97738647461, -2703.7495117188, 1501.4389648438}, key = 1024}', -- шаман
        'wait(3500)',
        'SendSync{ pos = {157.91302490234, 1248.1639404297, 0.18929195404053, key, 624)', --berk
        'wait(3500)',
        'SendSync{ pos = {-2841.92578125, 2229.1879882813, 1507.9470214844}, key = 1024}',  -- настоятель
        'sampSendChat("/фотик2")',
   
        'setCharCoordinates(playerPed, -2801.1538085938, 2223.5571289063, 1089.8363037109)',
        'sampAddChatMessage("{ffffff}• [sfa{ffffff}]: {00BFFF}Выбрать награду нужно за 15 секунд, иначе остальную стадию квеса надо будет проходить в ручную", -1)',
        'wait(15000)',
        'SendSync{ pos = {-2801.1538085938, 2223.5571289063, 1089.8363037109}, key = 1024}',--book
        'sendOnfootSync()',
        'wait(2000)',
        'SendSync{ pos = {450.97738647461, -2703.7495117188, 1501.4389648438}, key = 1024}', -- шаман
    },
    {
        --'Парфюмер', 
        'SendSync{ pos = {-224.875 , 1407.5 , 27.75, key, 364)', -- бармен
        'sampSendDialogResponse(5, 1, 2, _)',
        'sampSendDialogResponse(63, 1, 21, _)',
        'wait(200)',
        'sampCloseCurrentDialogWithButton(0)',
        'wait(3500)',
        'SendSync{ pos = {450.97738647461, -2703.7495117188, 1501.4389648438}, key = 1024}', -- шаман
        'wait(3500)',
        'SendSync{ pos = {2183.826171875, -1208.6407470703, 1149.0234375}, key = 1024}', -- трахалка
        'wait(2000)',
        'SendSync{ pos = {2192.3662109375, -1219.6126708984, 1149.0234375}, key = 1024}', -- замок взлом
        'wait(5000)',
        'SendSync{ pos = {-1037.5971679688, -1107.4311523438, 129.21875}, key = 1024}', -- слепок
        'SendSync{ pos = {2192.3662109375, -1219.6126708984, 1149.0234375}, key = 1024}', -- вернуть ключ
        'wait(3500)',
        'SendSync{ pos = {283.25 , 1362.25 , 10.625, key, 411)', -- нитро
        'wait(2000)',
        'sampSendDialogResponse(426, 1, 3, _)',
        'wait(350)',
        'sampCloseCurrentDialogWithButton(1)',
        'wait(3500)',
        'SendSync{ pos = {2820.3098144531, -1171.8321533203, 1525.5699462891}, key = 1024}', -- подпись
        'wait(3500)',
        'SendSync{ pos = {450.97738647461, -2703.7495117188, 1501.4389648438}, key = 1024}', -- шаман
        'wait(3500)',
        'SendSync{ pos = {283.25 , 1362.25 , 10.625, key, 411)', -- нитро
        'wait(1000)',
        'SendSync{ pos = {2221.5241699219, 1680.7922363281, 1508.5169677734}, key = 1024}', --сейф
        'wait(3500)',
        'SendSync{ pos = {450.97738647461, -2703.7495117188, 1501.4389648438}, key = 1024}', -- шаман
        'SendSync{ pos = {709.98205566406, -322.12915039063, 7.1750736236572}, key = 1024}', -- гриб
        'SendSync{ pos = {-273.96948242188, -1187.0083007813, 14.510042190552}, key = 1024}',  -- кора айясуйцуйц
        'wait(3500)',
        'SendSync{ pos = {450.97738647461, -2703.7495117188, 1501.4389648438}, key = 1024}', -- шаман
        'wait(3500)',
        'SendSync{ pos = {776.625 , 1871.25 , 4.875}, key, pic}', --вход тамара
        'wait(1000)',
        'SendSync{ pos = {312.25 , -165.875 , 999.5, key, 376)', -- тамара диалог
        'for i = 0, 6 do sampSendDialogResponse(431, 1, i, _) wait(300) end', 
        'sampCloseCurrentDialogWithButton(0)',
        'wait(3500)',
        'SendSync{ pos = {450.97738647461, -2703.7495117188, 1501.4389648438}, key = 1024}--[[шаман]]', 
        'wait(3500)',
        'SendSync{ pos = {870.36291503906, -24.908254623413, 63.988525390625}, key = 1024}', --вход каталина
        'SendSync{ pos = {-2778.5739746094, 402.69720458984, -42.594554901123}, key = 1024}', -- стол
        'SendSync{ pos = {216.55062866211, -160.13456726074, 1000.5306396484}, key = 1024}', -- параша
        'SendSync{ pos = {247.92680358887, 1022.5122680664, 1088.3125}, key = 1024}', -- кактус
        'SendSync{ pos = {2325.2971191406, -1011.876953125, 1154.71875}, key = 1024}', -- свет
        'SendSync{ pos = {870.36291503906, -24.908254623413, 63.988525390625}, key = 1024}', --вход каталина
        'SendSync{ pos = {873.29138183594, -25.534091949463, 56.475006103516}, key = 1024}',
        'wait(3500)',
        'SendSync{ pos = {450.97738647461, -2703.7495117188, 1501.4389648438}, key = 1024}', -- шаман
        'wait(300)',
        'sampSendDialogResponse(439, 1, 0, _)', -- 10 пангита
        'wait(3200)',
        'SendSync{ pos = {580.375 , 874 , 949.25, key, 403)', -- рабоита взять
        'sampSendDialogResponse(73, 1, 2, _)',
        'wait(3500)',
        'SendSync{ pos = {580.375 , 874.125 , 818.5, key, 404)', -- рабоита взять 2
        ---- рудник?
        'wait(3500)',
        'SendSync{ pos = {450.97738647461, -2703.7495117188, 1501.4389648438}, key = 1024}', -- шаман ?
        'wait(3500)',
        'SendSync{ pos = {-2798.4445800781, 2245.0068359375, 1089.0360107422}, key = 1024}', -- книга
        'wait(3500)',
        'SendSync{ pos = {249.875 , 67.625 , 2003.625, key, 414)', --дамба
        'wait(3500)',
        'SendSync{ pos = {1885.3271484375, -2313.5122070313, 1507.4038085938}, key = 1024}', --хуита
        'wait(3500)',
        'SendSync{ pos = {450.97738647461, -2703.7495117188, 1501.4389648438}, key = 1024}', -- шаман ?
        'wait(3500)',
        'SendSync{ pos = {-328.55807495117, 1861.2504882813, 45.214401245117}, key = 1024}',
    },
    {
        --'Ритуал',

        'NoKick()',
        'SendSync{ pos = {450.97738647461, -2703.7495117188, 1501.4389648438}, key = 1024}', -- шаман ?
        'wait(3500)',
        'SendSync{ pos = {2192.625 , -1217.875 , 1149, key, 583)', -- руна
        'wait(3500)',
        'SendSync{ pos = {249.875 , 67.625 , 2003.625, key, 414)', -- dumba
        'wait(3500)',
        'NoKick()',
        'SendSync{ pos = {324.25 , 1831.75 , 5.75, key, 378)', -- anklav
        'SendSync{ pos = {-2479.40234375, 2214.87890625, 15.431519508362}, key = 1024}', -- собатаж
        'wait(3500)',
        'SendSync{ pos = {2223 , 1623 , 1106.125, key, 606)',
        'wait(3500)',
        'NoKick()', -- anti
        'SendSync{ pos = {1246.4084472656, -836.33233642578, 2084.0070800781}, key = 1024}',
        'SendSync{ pos = {-768.64880371094, 2418.447265625, 157.0578918457}, key = 1024}',
        'wait(3500)',
        'SendSync{ pos = {checkpointXX, checkpointYY, checkpointZZ)',
        'wait(3500)',
        'SendSync{ pos = {425.36401367188, -2757.6120605469, 6.4227752685547}, mes = "Кукулькан")',
        'SendSync{ pos = {2233.2385253906, 1574.0213623047, 1999.9671630859}, key = 1024}', -- 1 таблчика
        'SendSync{ pos = {2233.25390625, 1576.4943847656, 1999.9659423828}, key = 1024}', -- 2 таблчика
        'SendSync{ pos = {2232.900390625, 1579.4814453125, 1999.96484375}, key = 1024}', -- 3 таблчика
        'SendSync{ pos = {2233.4204101563, 1591.4985351563, 1999.9549560547}, key = 1024}', -- 4 таблчика
        'SendSync{ pos = {2233.0270996094, 1594.6379394531, 1999.9554443359}, key = 1024}', -- 5 таблчика
        'SendSync{ pos = {2232.9255371094, 1597.2243652344, 1999.9626464844}, key = 1024}',-- 6 таблчика
        'SendSync{ pos = {2227.7038574219, 1597.5723876953, 1999.9722900391}, key = 1024}',-- 7 таблчика
        'SendSync{ pos = {2221.3322753906, 1597.107421875, 1999.9761962891}, key = 1024}',-- 8 таблчика
        'SendSync{ pos = {2218.3046875, 1612.6448974609, 1999.9820556641}, key = 1024}', -- табличка открывает дверь
        'SendSync{ pos = {2202.8947753906, 1607.2507324219, 1999.9686279297}, key = 1024}', -- 1 куб
        'SendSync{ pos = {2207.4841308594, 1607.1905517578, 1999.9685058594}, key = 1024}', -- 2 куб
        'SendSync{ pos = {2200.4001464844, 1607.2503662109, 1999.9686279297}, key = 1024}', -- 3 куб
        'SendSync{ pos = {2205.3256835938, 1607.2559814453, 1999.9686279297}, key = 1024}', -- 4 куб
        'SendSync{ pos = {2197.8679199219, 1606.9696044922, 1999.9681396484}, key = 1024}', -- табличка
        'SendSync{ pos = {2157.9606933594, 1620.9213867188, 1999.9680175781}, key = 1024}', -- табличка 1
        'SendSync{ pos = {2155.7963867188, 1616.6624755859, 1999.9666748047}, key = 1024}', -- табличка 2
        'SendSync{ pos = {2155.7924804688, 1600.7219238281, 1999.9681396484}, key = 1024}', -- табличка 3
        'SendSync{ pos = {2158.1176757813, 1596.7193603516, 1999.9692382813}, key = 1024}', -- ключ	
        'wait(3500)',


        'Актор(settings["Каталина"], 14)',
        'wait(2000)',
        'SendSync{ pos = {2158.1176757813, 1596.7193603516, 1999.9692382813}, key = 1024}', -- ключ
        'SendSync{ pos = {2164.6767578125, 1595.9987792969, 1999.9633789063}, key = 1024}', -- табличка 1
        'SendSync{ pos = {2166.7900390625, 1597.2945556641, 1999.9665527344}, key = 1024}', -- монеты стол
        'SendSync{ pos = {2169.0568847656, 1595.9967041016, 1999.9633789063}, key = 1024}', -- табличка 2
        'wait(500)',
        'SendSync{ pos = {2176.4736328125, 1595.4500732422, 1999.9759521484}, key = 1024}', -- вера
        'SendSync{ pos = {2207.0766601563, 1585.8666992188, 2000.0139160156}, key = 1024}', -- кирка
        'for i = 1, 200 do SendSync{ pos = {2203.234375, 1586.3406982422, 2001.4719238281}, key = 1024} end --[[копать]]',  
        'setCharCoordinates(playerPed, 2180.2495117188, 1579.4912109375, 2000.5739746094)',
        'SendSync{ pos = {2180.2495117188, 1579.4912109375, 2000.5739746094}, key = 1024}', -- шаман
        'wait(1000)',
        'SendSync{ pos = {2177.0783691406, 1579.9321289063, 2000.5739746094}, key = 1024}', -- тело

    },
    {
         --"Клятва Почтальонов", 
        'NoKick()', -- antich
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}',
        'sampSendDialogResponse(390,1,3, _)',
        'sampSendDialogResponse(162,1,-1, _)',
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, mes = "НИ СНЕГ"}',
        'wait(500)',
        'sampCloseCurrentDialogWithButton(0)',
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, mes = "НИ ДОЖДЬ" }', 
        'wait(500)',
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, mes = "НИ ДИКАЯ ЖАРА" }', 
        'wait(500)',
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, mes = "НИ СУМРАК НОЧИ"}', 
        'wait(500)',
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, mes = "НЕ ОСТАНОВЯТ ПОСЫЛЬНЫХ" }', 
        'wait(500)',
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, mes = "НА ПОЛПУТИ ОТ МЕСТА" }', 
        'wait(500)',
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, mes = "ПОСЛЕДНЕГО ИЗ ПИСЕМ"}',
    },
    {
        --"Внешние Поставки", 
	
		'NoKick()', -- antich
		'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}',
		'sampSendDialogResponse(390,1,4, _)',
		'sampSendDialogResponse(162,1,-1, _)',
		'wait(3500)',
		'SendSync{ pos = {-2281.875 , 2288.125 , 4.875}, pic = 562 }',
		'sampSendDialogResponse(162,1,-1, _)',
		'wait(3500)',
		'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}', -- почта сдать
		'sampSendDialogResponse(390,1,4, _)',
		'sampSendDialogResponse(162,1,-1, _)',
		'wait(200)',
		'sampCloseCurrentDialogWithButton(0)',
    },
    {
        --"Продовольствия", 
        'NoKick()', -- antich
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}', -- взятие почты
        'sampSendDialogResponse(390,1,5, _)', -- ответ 5
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(200)',
        'sampCloseCurrentDialogWithButton(0)',
        'wait(3500)',
        'SendSync{ pos = {-1058.375 , -1205.375 , 129.125}, pic = 452}', -- ферма
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(200)',
        'sampCloseCurrentDialogWithButton(0)',
        'wait(3500)',
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}', -- почта сдать
        'sampSendDialogResponse(390,1,5, _)', -- ответ 5
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(200)',
        'sampCloseCurrentDialogWithButton(0)',
    },
    {
        --"Энергоснабжение", 
	
    
        'NoKick()', -- antich
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}', -- взятие почты
        'sampSendDialogResponse(390,1,6, _)', -- ответ 6
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(3500)',
        'SendSync{ pos = {249.875 , 67.625 , 2003.625}, pick = 414 }', -- чистая вода
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(3500)',
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}', -- почта сдать
        'sampSendDialogResponse(390,1,6, _)', -- ответ 6
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(200)',
        'sampCloseCurrentDialogWithButton(0)',
    },
    {
        --"Добыча Топлива", 

        'NoKick()', -- antich
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}', -- взятие почты
        'sampSendDialogResponse(390,1,7, _)',
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(3500)',
        'SendSync{ pos = {615.625 , -72 , 997.875}, pick = 389}', -- механик
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(3500)',
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}', -- почта сдать
        'sampSendDialogResponse(390,1,7, _)',
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(200)',
        'sampCloseCurrentDialogWithButton(0)',
    },
    {
        --"Металлургия", 
		
        'NoKick()', -- antich
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}', -- взятие почты
        'sampSendDialogResponse(390,1,8, _)',
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(3500)',
        'SendSync{ pos = {-1889.25 , -1628.625 , 17.875}, pick = 434}', -- литейка
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(3500)',
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}', -- почта сдать
        'sampSendDialogResponse(390,1,8, _)',
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(200)',
        'sampCloseCurrentDialogWithButton(0)',
    },
    {
        --"Метрополитен", 
        'NoKick()', -- antich
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}', -- взятие почты
        'sampSendDialogResponse(390,1,9, _)',
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(3500)',
        'SendSync{ pos = {2130.25 , 1865.375 , 3015.625} }', -- voen
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(3500)',
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}', -- почта сдать
        'sampSendDialogResponse(390,1,9, _)',
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(200)',
        'sampCloseCurrentDialogWithButton(0)',
    },
    {
        --"Важный Информатор", 
        'NoKick()', -- antich
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}', -- взятие почты
        'sampSendDialogResponse(390,1,10, _)',
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(3500)',
        'SendSync{ pos = {-224.875 , 1407.5 , 27.75}, pick = 364}', -- бармен
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(3500)',
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}', -- почта сдать
        'sampSendDialogResponse(390,1,10, _)',
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(200)',
        'sampCloseCurrentDialogWithButton(0)',
    },
    {
        --"Первобытное Зло", 

        'NoKick()', -- antich
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}', -- взятие почты
        'sampSendDialogResponse(390,1,11, _)',
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(3500)',
        'SendSync{ pos = {-307.07290649414, 1492.6936035156, 75.61824798584}, key = 1024}', -- почта
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(3500)',
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}', -- почта сдать
        'sampSendDialogResponse(390,1,11, _)',
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(200)',
        'sampCloseCurrentDialogWithButton(0)',
    },
    {
        --"Неоанархисты", 
        'NoKick()', -- antich
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}', -- взятие почты
        'sampSendDialogResponse(390,1,12, _)',
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(3500)',
        'SendSync{ pos = {415.24865722656, 2531.2192382813, 19.170539855957}, key = 1024}', -- рысь
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(3500)',
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}', -- почта сдать
        'sampSendDialogResponse(390,1,12, _)',
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(200)',
        'sampCloseCurrentDialogWithButton(0)',
    },
    {
        --"Честь и Отвага", 
        'NoKick()', -- antich
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}', -- взятие почты
        'sampSendDialogResponse(390,1,13, _)',
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(3500)',
        'SendSync{ pos = {222.25 , 1822.75 , 6.375}, pick = 379}', -- военный
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(3500)',
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}', -- почта сдать
        'sampSendDialogResponse(390,1,13, _)',
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(200)',
        'sampCloseCurrentDialogWithButton(0)',
    },
    {
        --"Темные дела", 

        'NoKick()', -- antich
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}', -- взятие почты
        'sampSendDialogResponse(390,1,14, _)',
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(3500)',
        'SendSync{ pos = {-781.5 , 2437.75 , 1064.25}, pick = 668}', -- малина
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(3500)',
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}', -- почта сдать
        'sampSendDialogResponse(390,1,14, _)',
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(200)',
        'sampCloseCurrentDialogWithButton(0)',
    },
    {
        --"Изучение Зоны", 
        'NoKick()', -- antich
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}', -- взятие почты
        'sampSendDialogResponse(390,1,15, _)',
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(3500)',
        'SendSync{ pos = {324.25 , 1831.75 , 5.75}, pick = 378 }', -- учёный
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(3500)',
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}', -- почта сдать
        'sampSendDialogResponse(390,1,15, _)',
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(200)',
        'sampCloseCurrentDialogWithButton(0)',
    },
    {
        --"Секретные Материалы", 
        'NoKick()', -- antich
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}', -- взятие почты
        'sampSendDialogResponse(390,1,16, _)',
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(3500)',
        'SendSync{ pos = {2190.8620605469, -1216.052734375, 1149.0234375}, pick = 583}', -- руна
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(3500)',
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}', -- почта сдать
        'sampSendDialogResponse(390,1,16, _)',
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(200)',
    },
    {
        --"Платиновая фишка", 
        'NoKick()', -- antich
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}', -- взятие почты
        'sampSendDialogResponse(390,1,17, _)',
        'sampSendDialogResponse(162,1,-1, _)',
        'SendSync{ pos = {2822.75 , -1179 , 1525.5}, pick = 688}', 
        'wait(3500)',
        'SendSync{ pos = {146.10585021973, -83.502113342285, 2002.0360107422}, key = 1024}', -- фишка
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(3500)',
        'SendSync{ pos = {2816.8369140625, -1175.2595214844, 1525.5699462891}, key = 1024}-- почта сдать', 
        'sampSendDialogResponse(390,1,17, _)',
        'sampSendDialogResponse(162,1,-1, _)',
        'wait(200)',
        'sampCloseCurrentDialogWithButton(0)',
    },
}




-- for k, v in ipairs(ar) do
--     local f_n = "C:\\GTA San Andreas\\moonloader\\lib\\sfa\\select\\other\\квестики\\"..u8:decode(v)..'.lua'

--     local file, res = io.open(f_n, "w")

    
--     local line = 'return\n{'
--     for k, v in ipairs(quests2[k]) do
--         popa = ''
--         if v:find('NoKick()') then  popa = 'Обход кика'
--         elseif v:find('wait') then local del = v:match('(%d+)') popa = "Задержка "..(del/1000)..' сек'
--         elseif v:find("settings%['Пикапы'%]%['(.+)'%]") then
--             local pick = v:match("settings%['Пикапы'%]%['(.+)'%]")
--             print(pick)
--             popa = 'Пикап - '..cfg.Пикапы[pick].name
--         end

--         line = line..'\n    {info = "'..popa..'", action = "'..v:gsub('"',"'")..'"},'
--     end

--     file:write(line..'\n}')

    

--     file:close()

-- end


return mod