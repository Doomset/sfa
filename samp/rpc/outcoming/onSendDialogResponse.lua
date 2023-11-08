
require('lib.samp.events').onSendDialogResponse = function(dialogId, button, listboxId, input)

	msg(dialogId, button, listboxId, input)
	-- timer("окно с почтой", 3.6, function()
	-- 	msg("GOЄ")
	-- end)
	-- local t = sampGetDialogCaption()
	-- lastdialogresponse = {title = t, button = button, select = listboxId, input = input, on = false}
	-- if t:find('ќкно ¬хода') or t:find('ќкно –егистрации') then
	-- 	imgui.StrCopy(resPass, u8(input))
	-- 	imgui.StrCopy(resNick, sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))))
	-- end
end

