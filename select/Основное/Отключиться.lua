
return
{
    name = 'Отключиться',
    icon = 'USER_MINUS',
    hint = [[Закрыть соединение с причиной вылета/краша]],
    func =
    function()
        sendEmptyPacket(PACKET_CONNECTION_LOST)
        closeConnect()
    end
}