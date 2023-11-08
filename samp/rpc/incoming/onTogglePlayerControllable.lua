
require('lib.samp.events').onTogglePlayerControllable = function()
	if BlockSyncJob then return false end
end