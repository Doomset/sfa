local Крафт_Пуль = function(n, t)
	for i = 1, t or 1 do
		handler('dialog', {t = 'Порох: ', s = n - 1, i = ''}, 5)
		SendSync{pos = {2555.134765625, -1281.4006347656, 2054.6469726563}}
	end
end

return
{
    name = 'Дум-дум',
    icon = 'CROSSHAIRS',
    hint = [[Заспавниться и скрафтить 10 пуль дум-дум,нужен порох с хламом]],
    func =
    function()
        Крафт_Пуль(6, 10)
    end
}