local antimuteflodd = function()
	local has = timer.exist("��������")
	if not has then timer("��������", 1.1) end
	return has
end

require('lib.samp.events').onSendChat = function(message)
	if antimuteflodd() then msg("� �����") return false end
end


