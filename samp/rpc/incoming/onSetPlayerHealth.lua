
require('lib.samp.events').onSetPlayerHealth = function(health)
	if BlockSyncJob then return false end
end