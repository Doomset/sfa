Сбить_Диалог = function()
    if not sampIsDialogActive() then return end
    sampCloseCurrentDialogWithButton(0)
end



Инвентарь = function(n)
    SendSync { key = 64 } --- ДОБАВИТЬ ПАССАЖИРА
    handler('dialog', { t = 'Рюкзак', s = n - 1, i = '' })
end



Сдать_Арты = function()
    if not Рюкзак:Досьё() then Задержка(3) end

    local фрака = Рюкзак:Досьё().Группировка
    msg(фрака)
    NoKick()

    if фрака == "Сталкеры" then
        handler('dialog', { t = 'Артефакты', s = 6, i = 'Сдать все артефакты' })
        SendSync { pos = { 419, 2543, 10 }, pick = cfg['Пикапы']['2971.19'].id, force = true }
    end
end



Перевод = function(n)
    local frak = { "мутанты", "сталкеры", "бандиты" }

    if type(n) == "string" then
        for k, v in ipairs(frak) do
            if v:find(n:lower()) then
                handler('dialog', { t = 'Шериф', s = 8 + k, i = '' })
            end
        end
    else
        handler('dialog', { t = 'Шериф', s = 8 + n, i = '' })
    end

    handler('dialog', { t = '' })


    SendSync { pos = { -92, 1027, 1516 }, pick = cfg['Пикапы']['2450.93'].id, force = true }
end

Дом = function(n)
    handler('dialog', { t = 'Меню дома', s = n - 1, i = '' })
    sampSendChat("/дом")
end

Пангит = function(n)
    Инвентарь(20)
    handler('dialog', { t = 'Пангит', s = n - 1, i = '' })
end



Почтальён = function(n)
    handler('dialog', { t = 'ПОЧТА', s = n - 1, i = '' })
end



Мутация = function(n)
    sampSendChat("/мутация")
    handler('dialog', { t = 'Мутация', s = n - 1, i = '' })
end



Фермер = function(n)
    handler('dialog', { t = 'Ферма', s = n - 1, i = '' })
    SendSync { pos = { -1058.375, -1205.375, 129.125 }, pick = cfg['Пикапы']['-2134.68'].id }
end


local lasng = {[" "] = " ",['`'] = 'ё', ['~'] = 'ё', ['q'] = 'й', ['w'] = 'ц', ['e'] = 'у', ['r'] = 'к', ['t'] = 'е', ['y'] = 'н', ['u'] = 'г', ['i'] = 'ш', ['o'] = 'щ', ['p'] = 'з', ['['] = 'х', ['{'] = 'х', [']'] = 'ъ', ['}'] = 'ъ', ['a'] = 'ф', ['s'] = 'ы', ['d'] = 'в', ['f'] = 'а', ['g'] = 'п', ['h'] = 'р', ['j'] = 'о', ['k'] = 'л', ['l'] = 'д', [';'] = 'ж', ["'"] = 'э', ['"'] = 'э', ['z'] = 'я', ['x'] = 'ч', ['c'] = 'с', ['v'] = 'м', ['b'] = 'и', ['n'] = 'т', ['m'] = 'ь', ['<'] = 'б', [','] = 'б', ['>'] = 'ю', ['.'] = 'ю'}
local lasen = {}
for k, v in pairs(lasng) do
	lasen[v] = k
end
local insert, concat, lower = table.insert, table.concat, string.lower
local function RusToEng(tex, en)
    local str, word  = {}
    for i = 1, #tex do
        word = (lower(tex)):sub(i, i)
        insert(str, (en and lasen or lasng)[word] or word)
	end; return concat(str)
end

local weapons = require 'game.weapons'

weapons.names[44] = nil; weapons.names[45] = nil
пушка = function(par)
    local f, q, w = RusToEng(par, true):lower()
    if f:isEmpty() then return msg("введи ид или название пушки") end

    for k, v in pairs(weapons.names) do
        q, w = v:lower(), k
        if q:find(f) or w == tonumber(f) or (string.getSimilarity(q, f) > 0.7) then
            NoKick()
            requestModel(getWeapontypeModel(k)); loadAllModelsNow()
            giveWeaponToChar(1, k, 99999)
            return msg { "Выдан ган - " .. v, "ид " .. k }
        end
    end
    return msg("НЕ ВАЛИД " .. f)
end






Антирад_Или_Аптечка = function(аптечка, н)
	handler('dialog', {t = 'Регистратура', s = аптечка and 1 or 2, i = ''})
	handler('dialog', {t = аптечка and 'Закупка аптечек' or 'Закупка антирадина', s = н and 0 or 1, i = ''})
	handler('dialog', {t = 'Регистратура', s = 1, i = '', button = 0})

	if н then handler('dialog', {t = аптечка and 'Закупка аптечек' or 'Закупка антирадина', button = 0, i = ''}, 3) end

	SendSync{pos = {324, 1832, 6}, pick = cfg['Пикапы']['2162.01'].id, force = true}
end



Еда_Или_Водка = function(eda, n)
	handler('dialog', {t = 'Бар', s = eda and 1 or 0, i = ''})
	handler('dialog', {t = eda and 'Закупка еды' or 'Закупка водки', s = н and 0 or 1, i = ''})
	handler('dialog', {t = 'Бар', s = 1, i = 'Купить еды (100$)', button = 0})
	SendSync{pos = {-224.875, 1407.5, 27.75}, pick = cfg['Пикапы']['1210.47'].id, force = true}
end



Купить_Ремнаборы = function(n)
	handler('dialog', {t = 'Гараж', s = 0, i = 'Купить ремнабор (300$)'})
	handler('dialog', {t = 'Закупка ремнаборов (300$)', s = -1, i = n and tostring(n) or '25'})
	handler('dialog', {t = 'Гараж', button = 0})
	SendSync{pos = {615.625, -72, 997.875}, pick = cfg['Пикапы']['1541.55'].id, force = true}
end






Задержка = function(n)
	local w = sampGetPlayerPing(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))) + ((n * 1000) + 10)
	msg(w)
	return wait(w)
end


-- Хотелки = {
-- 	d = {
-- 		{n ="Как же хочется тяночку", act = function() 
-- 			handler('dialog', {t = 'Стриптиз по', s = 10})
-- 			SendSync{ pos = {745, 1440, 1103}, pick = cfg['Пикапы']['3287.9'].id, force = true}
-- 		end},


-- 		{n ="Радио", act = function() sampSendChat("/песня") end},

--handler('onServerMessage', {text = 'Комендант просил развезти воду по общинам! Надо взять цистерну.', color = 267386880})


-- 	},


-- 	--sampSendChat("/хотелка")

-- }
-- -- function()


-- end
Рюкзак = {
    Список = {
        -- шмот
        ["Аптечки"] = nil,
        ["Антирадин"] = nil,
        ["Продукты"] = nil,
        ["Консервы"] = nil,
        ["Водка"] = nil,
        ["Винт"] = nil,
        ["Ремнаборы"] = nil,
        ["Канистры"] = nil,
        ["Отмычки"] = nil,
        --навыки
        ["Ловкость"] = nil,
        ["Наука"] = nil,
        ["Ремонт"] = nil,
        ["Кулинария"] = nil,
        ["Вождение"] = nil,
        --досье
        ["Группировка"] = nil,
        ["Уровень допуска"] = nil,
        ["Пангит"] = nil,
        ["Часы"] = nil,
    },
    Статус = false,

    Инвентарь = function(self, n)
        self.Статус = true; Инвентарь(1)
        for select = 1, n and n or 4 do
            handler('dialog', { t = 'Инвентарь', s = select, i = '' }, 5)
        end
    end,

    Навыки = function(self)
        self.Статус = true; Инвентарь(3);
    end,

    Досьё = function(self)
        ;
        if self.Список["Группировка"] == nil then
            self.Статус = true; Инвентарь(2);
            return
        end
        ;
        return self.Список
    end,

    Парс = function(self, title, text, id)
        if title:find('Ваше досье') then
            self.Список["Группировка"] = text:match("Группировка: ([А-я]+)")
            self.Список["Уровень допуска"] = text:match("Уровень допуска: (%d+)")
            self.Список["Пангит"] = text:match("Пангит (%d+)")
            self.Список["Часы"] = text:match("Часов в Зоне: (%d+)")
            if self.Статус then
                self.Статус = false
                sampSendDialogResponse(id, 1, -1, "")
                return true
            end
        elseif title:find("Навыки") then
            self.Список["Ловкость"] = text:match("Ловкость 	(%d+)")
            self.Список["Наука"] = text:match("Наука 	(%d+)")
            self.Список["Ремонт"] = text:match("Ремонт 	(%d+)")
            self.Список["Кулинария"] = text:match("Кулинария 	(%d+)")
            self.Список["Вождение"] = text:match("Вождение 	(%d+)")
            if self.Статус then
                self.Статус = false
                msg(self.Статус)
                sampSendDialogResponse(id, 1, -1, "")
                return true
            end
        end

        if self.Статус then
            if (title:find("Медикаменты") or title:find("Продукты") or title:find("Наркотики") or title:find("Инструменты")) then
                lua_thread.create(function()
                    wait(sampGetPlayerPing(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))) + 300)
                    if title:find("Медикаменты") then
                        self.Список["Аптечки"], self.Список["Антирадин"] =
                        text:match("Аптечки	(%d+)"), text:match("Антирадин	(%d+)")
                        Инвентарь(1)
                    elseif title:find("Продукты") then
                        self.Список["Консервы"], self.Список["Водка"] =
                        text:match("Консервы	(%d+)"), text:match("Водка	(%d+)")
                        Инвентарь(1)
                    elseif title:find("Наркотики") then
                        self.Список["Винт"] = text:match("Винт	(%d+)")
                        Инвентарь(1)
                    elseif title:find("Инструменты") then
                        self.Список["Ремнаборы"], self.Список["Канистры"], self.Список["Отмычки"] =
                        text:match("Ремнаборы	(%d+)"), text:match("Канистры	(%d+)"),
                            text:match("Отмычки	(%d+)")
                        Инвентарь(1); msg(4)
                        self.Статус = false
                        handler('dialog', { t = 'Инвентарь', button = 0 }, 5)
                    end
                end)
                return true
            end
        end
    end
}



Актор = function(id, gun)
    local bs = raknetNewBitStream()
    raknetBitStreamWriteBool(bs, false) -- bool
    raknetBitStreamWriteInt16(bs, shluxa) -- actor id
    raknetBitStreamWriteFloat(bs, 1)   --damage
    raknetBitStreamWriteInt32(bs, gun) -- flowers
    raknetBitStreamWriteInt32(bs, 3)   -- tors
    raknetSendRpc(177, bs); raknetDeleteBitStream(bs)
end



Метка = function(x, y)
    local bs = raknetNewBitStream()
    raknetBitStreamWriteFloat(bs, x)
    raknetBitStreamWriteFloat(bs, y)
    raknetSendRpc(119, bs); raknetDeleteBitStream(bs)
end


Мир = function()
    SendSync { pos = { 2224.4074707031, -1153.4415283203, 1025.796875 }, key = 1024, force = true }
end





-- Хотелки = {
-- 	d = {
-- 		{n ="Как же хочется тяночку", act = function()
-- 			handler('dialog', {t = 'Стриптиз по', s = 10})
-- 			SendSync{ pos = {745, 1440, 1103}, pick = cfg['Пикапы']['3287.9'].id, force = true}
-- 		end},


-- 		{n ="Радио", act = function() sampSendChat("/песня") end},

--handler('onServerMessage', {text = 'Комендант просил развезти воду по общинам! Надо взять цистерну.', color = 267386880})


-- 	},


-- 	--sampSendChat("/хотелка")

-- }
-- -- function()


-- end
Рудник = function(n)
    handler('dialog', { t = 'Рудник', s = n - 1 })
    SendSync { pos = { 580, 874, 949 }, pick = cfg['Пикапы']['2403.74'].id, force = true }
end
