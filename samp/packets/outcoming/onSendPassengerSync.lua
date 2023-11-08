require('lib.samp.events').onSendPassengerSync = function(data)
	if BlockSync or SendSyncBlock or BlockSyncJob or loadplace then return false end
end
