
require('lib.samp.events').onPlaySound = function(soundId, position)
	lastSoundId = { id = soundId, on = false }
	if soundId == 36401 and sampTextdrawIsExists(cfg["Автовзлом"]["Отмычка открыть"]) and cfg["Автовзлом"]["Статус"] then
		blockNextTd = true
		addConsole("АВТОВЗЛОМ использование отмычки")
		sampSendClickTextdraw(cfg["Автовзлом"]["Отмычка открыть"]) --open
	end
end