
require('lib.samp.events').onPlaySound = function(soundId, position)
	lastSoundId = { id = soundId, on = false }
	if soundId == 36401 and sampTextdrawIsExists(cfg["���������"]["������� �������"]) and cfg["���������"]["������"] then
		blockNextTd = true
		addConsole("��������� ������������� �������")
		sampSendClickTextdraw(cfg["���������"]["������� �������"]) --open
	end
end