
return
{
    name = '���������',
    icon = 'WAND_MAGIC_SPARKLES',
    hint = [[��������� �� ������ �� ���� ������, ��� ������ ����, �� ������� ������ ���-�� �� ����� �����(����� ���)]],
    func =
    function()
        sampSendChat("/��������")
        for k, v in pairs(����_���_�����) do
            --�����_����()
            NoKick()
            exSync{pos = {v[1], v[2], v[3]}, p = k, key = 0}
            msg{v[1], v[2], v[3], k}
        end
    end
}