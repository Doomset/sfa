
return
{
    name = '���������2',
    icon = 'WAND_MAGIC_SPARKLES',
    hint = [[��������� �����,�������� ��������� � ������ �� ����� �������� ������ �����, ���� ����� ������]],
    func =
    function()
        msg2("+")
        start = 12
        for k, v in pairs(pickforcollect) do
            msg2(pickforcollect[k][1])
            setCharCoordinates(PLAYER_PED, pickforcollect[k][2] + 3, pickforcollect[k][3], pickforcollect[k][4])
            sampForceOnfootSync()
            wait(10000)
            SendSync(pickforcollect[k][2], pickforcollect[k][3], pickforcollect[k][4], false, 40, pickforcollect[k][1])
            printStringNow(string.format("%d art", k), 1488)

        end
        start = 0
    end
}