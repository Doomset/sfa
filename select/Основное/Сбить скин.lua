
return
{
    name = '����� ����',
    icon = 'SUITCASE_ROLLING',
    hint = [[���� ������ � ����, �� ������, �� ������]],
    func =
    function()
        if pickupidshmot ~= -1 then
            start = 45
            NoKick()
            SendSync(pxss, pyss, pzss, key, pickupidshmot)
            wait(300)
            unfreeze()
        else
            msg('�� ������� ������ �� ������', 3)
        end
    end
}