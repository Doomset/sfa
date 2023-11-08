
require('lib.samp.events').onPlayAudioStream = function(url, p, radius, up)
	lastAudioStream = {url = url, on = false}
	print(url, p.x, p.y, p.z, radius, up)
end