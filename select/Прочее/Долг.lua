
return
{
    name = '����',
    icon = 'USER',
    hint = [[������� ������� � �� ��� ����� �����,�� ������, ������]],
    func =
    function()
        handler('dialog', {t = '���� �����', s = 0, i = '������ ������', button = 0})
        SendSync{ pos = {1065, 1768, 2522}, pick = cfg['������']['5354.76'].id, force = true}
    end
}