
require('lib.samp.events').onSetRaceCheckpoint = function(type, p, nextPosition, size)
	-- takecheck(p)
	-- handler("checkpoints", {p})
	CheckpointsDebug[#CheckpointsDebug + 1] = {p.x, p.y, p.z}
	print('onSetRaceCheckpoint, ', p.x, p.y, p.z, shortPos(p.x, p.y, p.z))
end