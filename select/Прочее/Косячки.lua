
return
{
    name = '�������',
    icon = 'JOINT',
    hint = [[����� ����� ��� ������ �����,�� ������, ������]],
    func =
    function()
        SendSync{ pos = {-782, 2438, 1064}, pick = cfg['������']['2720.55'].id, force = true}
        for i = 1, 5 do
            handler('dialog', {t = '׸���� �����', s = 0, i = '������ ������ (500$)'}, 5)
        end
    end
}