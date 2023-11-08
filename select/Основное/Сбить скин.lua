
return
{
    name = 'Сбить скин',
    icon = 'SUITCASE_ROLLING',
    hint = [[Берёт одежду с хаты, не кикает, но варнит]],
    func =
    function()
        if pickupidshmot ~= -1 then
            start = 45
            NoKick()
            SendSync(pxss, pyss, pzss, key, pickupidshmot)
            wait(300)
            unfreeze()
        else
            msg('Не удалось узнать ид одежды', 3)
        end
    end
}