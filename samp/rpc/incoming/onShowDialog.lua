local dialogs = {}


require('lib.samp.events').onShowDialog = function(id, style, title, button1, button2, text)
	-- if not dialogs[id] then
	-- 	dialogs[id] = title
	-- elseif dialogs[id] then
	-- 	Noti('DIALOG EXIST !!!!! '.. title..id, INFO)
	-- end

	if title:find('Связной') then

	
	    -- ('Аптечка %(надо нарыть%)')
		-- ('Антирадин %(надо нарыть%)')
		-- ('Еда (надо нарыть)')
		-- ('Водка %(надо нарыть%)')
		-- ('Бронежилет %(надо нарыть%)')
		-- ('Автомат %(надо нарыть%)')
	end


	

	-- if id == 6 then
	-- 	list_inv = {}
	-- 	for line in text:gmatch('[^\n]+') do
	-- 		list_inv[#list_inv + 1] = line
	-- 	end

	-- 	inventar.switch()
	-- 	sampSendDialogResponse(id, 0, -1, "")
	-- 	return false
	-- end

	if text:find('Еще раз ошибёшься и будет кик') then
		attempt_to_login = attempt_to_login + 1
		msg(attempt_to_login..' попыток входа')
	elseif text:find('Если не зайти, то пишите Кузе!') then
		attempt_to_login = 0
	end

	

	for k, v in ipairs(cfg["Диалоги"]["Список"]) do
		if v.on and title:find(v.title) then
			sampSendDialogResponse(id, v.button, v.select, v.input)
			print('settings["Диалоги"]["Список"]', "Послан ответ дииалог ", id, v.button, v.select, v.input)
			return false
		end
	end

	if cfg["Автопароль"]["Функции"]["Скрыть почту"] and title:find("Система безопасности") then
		local t = timer.exist("твинк")

		timer("окно с почтой", t and t + 1.1 or 0.0, function()
			handler('dialog', {t = 'Сложность'})
			handler('dialog', {t = 'Уровень сложности', s = 2, i = 'Пропустить обучение'})
			--timer.exist(@) что бы привходе не было конфликтов
			sampSendChat("/твинк")
		end)
		return false
	end


	if Рюкзак:Парс(title, text, id) then return false end

	if title:find("Медикаменты") then
		Рюкзак.Список["Аптечки"], Рюкзак.Список["Антирадин"] = text:match("Аптечки	(%d+)"), text:match("Антирадин	(%d+)")
	elseif title:find("Продукты") then
		Рюкзак.Список["Консервы"], Рюкзак.Список["Водка"] = text:match("Консервы	(%d+)"), text:match("Водка	(%d+)")
	elseif title:find("Наркотики") then
		Рюкзак.Список["Винт"] = text:match("Винт	(%d+)")
	elseif title:find("Инструменты") then
		Рюкзак.Список["Ремнаборы"], Рюкзак.Список["Канистры"], Рюкзак.Список["Отмычки"] = text:match("Ремнаборы	(%d+)"), text:match("Канистры	(%d+)"), text:match("Отмычки	(%d+)")
	end

if handler.has("dialog", {id, title}) then return false end

	local f = title
	if cfg["Автопароль"]["Статус"] and ( f:find('Окно Регистрации') or f:find('Выберите пол персонажа') or f:find('Регистрация реферала') or f:find('Окно Входа') ) then


		if attempt_to_login ~= 0 and f:find('Окно Входа') then msg('не правильный пароль, автологин оффнут во избежании кика') cfg["Автопароль"]["Статус"] = false return end

		if cfg["Автопароль"]["Любой акк"].on then sampSendDialogResponse(id, 1, -1, f:find('Регистрация реферала') and " " or cfg["Автопароль"]["Любой акк"].pass) print("AUTOLOGIN") return false end
		local myid = select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))


		for k, v in ipairs(cfg["Автопароль"]["Функции"]["Акки"]) do
			if v.on and (string.lower(v.nick) == string.lower(sampGetPlayerNickname(myid))) then
				print("AUTOLOGIN")
				sampSendDialogResponse(id, 1, -1, f:find('Регистрация реферала') and " " or v.pass)
				return false
			end
		end
	end
end

