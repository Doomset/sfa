
require('lib.samp.events').onSetCheckpoint = function(p, radius)
--	takecheck(p)
	handler("checkpoints", {p})
	CheckpointsDebug[#CheckpointsDebug + 1] = {p.x, p.y, p.z} -- de
	print('onSetCheckpoint, ', p.x, p.y, p.z, shortPos(p.x, p.y, p.z))
end