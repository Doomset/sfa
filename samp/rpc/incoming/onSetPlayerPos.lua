
require('lib.samp.events').onSetPlayerPos = function(pos)
if handler.has("player_pos", {pos}) then return false end

if shortPos(pos.x, pos.y, pos.z) == 1310.6 then msg("���� ������ �� ���������)") return false end

print("player_pos ������ ��������� ������� ",pos.x, pos.y, pos.z, shortPos(pos.x, pos.y, pos.z))

addConsole("player_pos ",pos.x, pos.y, pos.z, shortPos(pos.x, pos.y, pos.z))

if BlockSyncJob then return false end
end