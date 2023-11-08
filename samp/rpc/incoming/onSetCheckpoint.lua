
require('lib.samp.events').onSetCheckpoint = function(p, radius)
	takecheck(p)
	handler("checkpoints", {p})
	lastcheck[#lastcheck + 1] = {p.x, p.y, p.z}
end