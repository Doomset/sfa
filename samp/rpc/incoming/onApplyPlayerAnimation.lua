
require('lib.samp.events').onApplyPlayerAnimation = function(playerId, animLib, animName, frameDelta, loop, lockX, lockY, freeze, time)
	if BlockSyncJob then return false end
end