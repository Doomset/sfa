
require('lib.samp.events').onClearPlayerAnimation = function(playerId)
	if BlockSyncJob then return false end
end