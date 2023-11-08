
return
{
    name = 'Сейф',
    icon = 'BOMB',
    hint = [[Не кикает, варнит]],
    func =
    function()
        if pickupidseif ~= -1 	then
            NoKick()
            SendSync(pxs, pys, pzs, key, pickupidseif)
        else
            msg('Не удалось узнать ид сейфа и координаты', 3)
        end
    end
}