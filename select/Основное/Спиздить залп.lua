
return
{
    name = '�������� ����',
    icon = 'ROCKET',
    hint = [[������ � ����� ������� ��� �� ���� ����, ����� ���� ����, �� ������]],
    func =
    function()
        SendSync{pos = cfg['������']['6292.5'].pos, pick = cfg['������']['6292.5'].id}
        SendSync{pos = cfg['������']['4868.25'].pos, pick = cfg['������']['4868.25'].id}
    end
}