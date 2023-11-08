
require('lib.samp.events').onShowTextDraw = function(id, data)
	local ez = data.position.x + data.position.y
	local ind = ds[ez]
	if ind then
		local res, _, i = data.text:find("%w+ (%d+)")
		if tonumber(i) >= 80 and ind.on then
			if sampIsDialogActive() then return end
			Инвентарь( ind.n == "rad" and 8 or 10 )
		end
		if cfg[ind.n]["Ид"] ~= id then cfg[ind.n]["Ид"] = id; msg{"перезапись ", ind.n}; cfg() end
	end

	if ez == 945 then indicatorArts = id end

	if ez == 2 and cfg["Метро и сон"]["Функции"]["Затемнение"] then addConsole('["Метро и сон"]["Функции"]["Затемнение"]', "Заблокирован текстдрав с затемнением") return false end



	if ez == 201 and cfg["Автовзлом"]["Отмычка"] ~= id then
		cfg["Автовзлом"]["Отмычка"] = id -- отмычка
		addConsole("АВТОВЗЛОМ перезапись отмычки")
		cfg()
	elseif ez == -50 and cfg["Автовзлом"]["Отмычка открыть"] ~= id then
		cfg["Автовзлом"]["Отмычка открыть"] = id -- открыть
		addConsole("АВТОВЗЛОМ перезапись замка")
		cfg()
	end

	if (data.position.x == 16 and data.position.y == -20) and cfg["Автовзлом"]["Статус"] then
		if blockNextTd then blockNextTd = nil return false end
		if cfg["Автовзлом"]["Функции"]["Задержка"] < 0.01 then sampSendClickTextdraw(cfg["Автовзлом"]["Отмычка"]) return end
		timer('seif', cfg["Автовзлом"]["Функции"]["Задержка"], function ()
			sampSendClickTextdraw(cfg["Автовзлом"]["Отмычка"])
		end)
	end

	if id == 2069 then
		SendSync{key = 1024}
	end

end