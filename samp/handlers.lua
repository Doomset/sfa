handler = setmetatable -- добавить таймаут
(
    {
        ["player_pos"] = {},
        ["dialog"] = {},
        ["onServerMessage"] = {},
        ["checkpoints"] = {},

        ['surf'] = {},

        remove = function(self, name_handler, index, data)
            print("\n handler", name_handler, "\n", encodeJson(name_handler), "\n", encodeJson(data))
            print(name_handler, index, 'debug')
            table.remove(self[name_handler], index)
            return true
        end
    },
    {
         __index = function(self, key, func)
            if key == "has" then
                return
                    function(name_handler, data)
                        local t2 = self[name_handler]
                        if #t2 < 1 then return end
                        for index, v in ipairs(t2) do
                            if name_handler == "dialog" then
                                local id, title = data[1], data[2]
                                if title:find(v.t) and (v.id or true) then
                                  --  msg(v.t)
                                    sampSendDialogResponse(v.id or id, v.button and 0 or 1, v.s or 0, v.i or "")
                                    ОТВЕТ_ДИЛАОГ = true
                                    msg(name_handler, 'hay')
                                    return self:remove(name_handler, index, data)
                                end
                            elseif name_handler == "player_pos" then
                                local pos = data[1]
                                if v[1] == shortPos(pos.x, pos.y, pos.z) then
                                    SendSync{pos = {pos.x, pos.y, pos.z}} -- антиноп??!!!
                                    print('force sync antinope')
                                    return self:remove(name_handler, index, data)
                                end
                            elseif name_handler == "onServerMessage" then
                                local color, text = data[1], data[2]
                                if text:find(v.text) and (v.color and (v.color == color) or true) then
                                    return self:remove(name_handler, index, data)
                                end
                            elseif name_handler == "checkpoints" then
                                local pos = data[1]
                                if shortPos(v.data.pos[1], v.data.pos[2], v.data.pos[3]) == shortPos(pos.x, pos.y, pos.z) then
                                    if index == #self[name_handler] then msg "END CHECK" end
                                    if v.data.id then sampSendExitVehicle(v.data.id) end
                                    SendSync(v.data)
                                    return self:remove(name_handler, index, data)
                                end
                            elseif name_handler == 'surf' then
                                return v.surfingVehicleId
                            end
                        
                        end
                        return false
                    end
            elseif key == "null" then
                return function()
                    self["player_pos"]      = {}
                    self["dialog"]          = {}
                    self["onServerMessage"] = {}
                    self["checkpoints"]     = {}
                end
            end
        end,

        __call = function(self, type, data, t)
            if not self[type] then return msg { type, " error handler" } end

            table.insert(self[type], data or { t = "" })

            timer("timeout_handlers_" .. tostring(data), t or 10, function()
                local index = #self[type]
                print(encodeJson(self[type][index]))
                self[type][index] = nil
            end)
        end
    }
)
