
return
{
    name = '�������',
    icon = 'USER',
    hint = [[������� ������� � �� ��� ����� �����,�� ������, ������]],
    func =
    function()
        handler('dialog', {t = '���� �������', s = 0, i = '������ ������'})
        SendSync{ pos = {1090, 2099, -5}, pick = cfg['������']['3184.17'].id}
    end
}