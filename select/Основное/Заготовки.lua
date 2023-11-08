
return
{
    name = 'Заготовки',
    icon = 'SCREWDRIVER',
    hint = [[сталкам антирад в минус введёт, если его не будет, учёным так же с канистрами]],
    func =
    function()
        for i = 1, 5 do
            SendSync{ pos = {615, -81, 1498}, pick = cfg['Пикапы']['2032.2'].id, force = true}
        end
    end
}