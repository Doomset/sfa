
require('lib.samp.events').onSetRaceCheckpoint = function(type, p, nextPosition, size)
	takecheck(p)
	handler("checkpoints", {p})
	lastcheck[#lastcheck + 1] = {p.x, p.y, p.z}
end