
return
{
    name = 'Ñìýðòü',
    icon = 'SKULL_CROSSBONES',
    hint = [[1]],
    func =
    function()
        local bs = raknetNewBitStream()
        raknetBitStreamWriteBool(bs, true)
        raknetBitStreamWriteInt16(bs, 65535)
        raknetBitStreamWriteFloat(bs, 3.3000001907349)
        raknetBitStreamWriteInt32(bs, 54)
        raknetBitStreamWriteInt32(bs, 3)
        raknetSendRpc(115, bs)
        raknetResetBitStream(bs)
        raknetBitStreamWriteInt8(bs, 255)
        raknetBitStreamWriteInt16(bs, 65535)
        raknetSendRpc(53, bs)
        raknetDeleteBitStream(bs)
        wait(300)
        sampSendRequestSpawn()
        sampSendSpawn()
    end
}