
return
{
    name = '����',
    icon = 'BOMB',
    hint = [[�� ������, ������]],
    func =
    function()
        if pickupidseif ~= -1 	then
            NoKick()
            SendSync(pxs, pys, pzs, key, pickupidseif)
        else
            msg('�� ������� ������ �� ����� � ����������', 3)
        end
    end
}