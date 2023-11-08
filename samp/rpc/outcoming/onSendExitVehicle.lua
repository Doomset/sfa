
require('lib.samp.events').onSendExitVehicle = function(veh)
timer("abuse", 7)
	timers.timeoutAC = {os.clock(), 7}
end