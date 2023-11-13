
attempt_to_login = 0
require('lib.samp.events').onServerMessage = function(color, text)
	lastservermsg = {color = color, text = text}

	
	if IsCharSurfing and text == 'Брысь с крыши' and color == -1439485014 then
		cfg["Лодка"].block = true
		cfg()
	end

	if text:find('Вас кикнуло') and color == -1439485014 then
	end

	 if cfg["Автопароль"]["Функции"]["Твинк"] and color == 267386880 and text:find("Вы пришли в себя в тюремном лазарете") then
		local t = timer.exist("окно с почтой")
		timer("твинк", t and t + 1.1 or 0.0, function()
			handler('dialog', {t = 'Сложность'})
			handler('dialog', {t = 'Уровень сложности', s = 2, i = 'Пропустить обучение'})
			--timer.exist(@) что бы привходе не было конфликтов
			sampSendChat("/твинк")
		end)
		return false
	end

	if text:find("Добро пожаловать в Зону") then
		attempt_to_login = 0
	end


	if color == 267386880 and text:find("Вы получаете %d+$ %+ %d+$ бонус за уровень") then
		timer("job delay", 61)
		if BlockSyncJob then

		--	msg{BlockSyncJob, "BlockSyncjob"}
			BlockSyncJob = false
			msg("BlockSyncJob = false")
		elseif BlockSyncJob and text == 'Вы слишком устали!' and color == -1439485014 then
			BlockSyncJob = false
			msg("BlockSyncJob = false")
		end
	end

	for k, v in ipairs(cfg["Спам"]["Строки"]) do
		if text:find(v.text) and color == v.color then
			addConsole('settings["Спам"]["Строки"]', "ServerMessage block", color, text)
			return false
		end
	end

	addConsole (string.format("handler('onServerMessage', {text = '%s', color = %d})", text, color))

	if text == 'Чтобы пробудиться ото сна введите .проснуться' and color == 267386880 and cfg["Метро и сон"]["Функции"]["Проснуться"] then
		sampSendChat("/проснуться")
		addConsole("/проснуться", '[Метро и сон"]["Функции"]["Проснуться"]')
	end

	if handler.has("onServerMessage", {color, text}) then return false end

	if text:find('У вас нет антирадина. Купите его в штабе учёных') and color == -1439485014 and ds[685].on then ds[685].on = false return {color, "Антирадин кончился"}
	elseif text:find('У вас нет еды. Купите её в баре') and color == -1439485014 and ds[605].on then ds[605].on = false return {color, "Еда кончилась"} end
end