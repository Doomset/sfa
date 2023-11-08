local antimuteflodd = function()
	local has = timer.exist("антифлуд")
	if not has then timer("антифлуд", 1.1) end
	return has
end

require('lib.samp.events').onSendChat = function(message)
	if antimuteflodd() then msg("в пизду") return false end
end


