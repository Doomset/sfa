
return
{
    name = '���������',
    icon = 'SCREWDRIVER',
    hint = [[������� ������� � ����� �����, ���� ��� �� �����, ������ ��� �� � ����������]],
    func =
    function()
        for i = 1, 5 do
            SendSync{ pos = {615, -81, 1498}, pick = cfg['������']['2032.2'].id, force = true}
        end
    end
}