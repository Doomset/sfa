
return
{
    name = '������',
    icon = 'JOINT',
    hint = [[����� ����� ��� ������ �����,�� ������, ������]],
    func =
    function()
        NoKick()
        handler('dialog', {t = '������'})
        handler('dialog', {t = '������', button = 0})
        SendSync{ pos = {-794, 2445, 1064}, pick = cfg['������']['2715.59'].id, force = true}
        ��������(3.5)
        handler('dialog', {t = '�������'})
        SendSync{ pos = {-793, 2439, 1064}, pick = cfg['������']['2710.49'].id, force = true}
        ��������(3.5)
        for i=1,6 do
            SendSync{ pos = {-1016, -1231, 130}, pick = cfg['������']['-2116.79'].id, force = true}
        end
        SendSync{ pos = {-226, 1407, 70}, pick = cfg['������']['1251.87'].id, force = true}
        handler('dialog', {t = '׸���� �����', s = 1, i = '����� ������'})
        SendSync{ pos = {-782, 2438, 1064}, pick = cfg['������']['2720.55'].id, force = true}
    end
}