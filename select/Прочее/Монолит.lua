
return
{
    name = '�������',
    icon = 'USER',
    hint = [[������� ������� � �� ��� ����� �����,�� ������, ������]],
    func =
    function()
        handler('dialog', {t = '���� ��������', s = 0, i = '������ ������', button = 0})
        SendSync{ pos = {1054, 1254, 11}, pick = cfg['������']['2319.21'].id}
    end
}