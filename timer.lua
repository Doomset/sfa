timer = setmetatable
(
    {
        список = {},
    },
    {
        __index = function(self, key)
            if key == "process" then
                return function()
                    if #self.список < 1 then return end

                    for k, v in ipairs(self.список) do
                        if v.функция_во_время then v.функция_во_время(self, k) end

                        if (os.clock() - v.клок > v.задержка) then
                            if v.функция then v.функция(self) end
                            print(v.название, "ИСТЁК", os.clock() - v.клок)
                            table.remove(self.список, k); break
                        end
                    end
                end
            elseif key == "exist" then
                return function(n)
                    if #self.список < 1 then return false end
                    for k, v in ipairs(self.список) do
                        if v.название == n then return os.clock() - v.клок, v.задержка end
                    end
                    return false
                end
            

            elseif key == "refresh" then
                return function(self, t)
                    local index, del, full = self.exist(t)
                    self.список[index] = shab
                    return false
                end

            elseif key == "remove" then
                return function(t)
                    local index, del, full = self.exist(t)
                    table.remove(self.список, index)
                    return false
                end

            end


        end,

        __call = function(self, название, задержка, функция, функция_во_время)
            local shab = { задержка = задержка, функция = функция, клок = os.clock(),
                название = название, функция_во_время = функция_во_время }

            local index, del, full = self.exist(название)
            --print("таймер ", название, encodeJson(shab))
            if index then
                print("таймер перезапись", название, encodeJson(shab))
                self.список[index] = shab
                return
            end
            print("таймер установлен", название, encodeJson(shab))
            self.список[#self.список + 1] = shab
            return
        end
    }
)

