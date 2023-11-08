
return
{
    name = 'Косячки',
    icon = 'JOINT',
    hint = [[Масла масла для учёных масла,не кикает, варнит]],
    func =
    function()
        SendSync{ pos = {-782, 2438, 1064}, pick = cfg['Пикапы']['2720.55'].id, force = true}
        for i = 1, 5 do
            handler('dialog', {t = 'Чёрный рынок', s = 0, i = 'Купить травку (500$)'}, 5)
        end
    end
}