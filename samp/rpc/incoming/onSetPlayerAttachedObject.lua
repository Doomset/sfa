
require('lib.samp.events').onSetPlayerAttachedObject = function(playerId, index, create, object)
	-- if playerId == select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)) then
	-- 	if not lastattached[index] and  object.modelId ~= 0 then
	-- 		lastattached[index] =
	-- 		{
	-- 			data =
	-- 			{
	-- 				id = object.modelId,
	-- 				bone = object.bone,
	-- 				offset = {object.offset.x, object.offset.y, object.offset.z},
	-- 				rotation = {object.rotation.x, object.rotation.y, object.rotation.z},
	-- 				scale = {object.scale.x, object.scale.y, object.scale.z},
	-- 				color1 = object.color1,
	-- 				color2 = object.color2,
	-- 			}
	-- 		}
	-- 		msg(index)
	-- 	elseif lastattached[index] and object.modelId == 0 and not create then lastattached[index] = nil end
	-- end

	-- for k, v in ipairs(cfg["Аттачи"]["Модели"]) do
	-- 	if not v.on then return end
	-- 	for _, obj in pairs(v.list) do
	-- 		if object.modelId == obj.data.id then
	-- 			addConsole("PlayerAttachedObject", object.modelId, "удалён")
	-- 			return false
	-- 		end
	-- 	end
	-- end
end