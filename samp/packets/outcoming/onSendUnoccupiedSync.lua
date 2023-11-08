require('lib.samp.events').onSendUnoccupiedSync = function(data)
	if BlockSync or SendSyncBlock or BlockSyncJob or loadplace then return false end
end
