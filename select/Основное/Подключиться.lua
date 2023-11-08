
return
{
    name = 'Подключиться',
    icon = 'USER_PLUS',
    hint = [[Подключиться на сервер]],
    func =
    function()
        sampDisconnectWithReason(0)
        sampSetGamestate(1)
    end
}