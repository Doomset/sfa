
return
{
    name = '�����������',
    icon = 'USER_MINUS',
    hint = [[������� ���������� � �������� ������/�����]],
    func =
    function()
        sendEmptyPacket(PACKET_CONNECTION_LOST)
        closeConnect()
    end
}