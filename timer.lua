timer = setmetatable
(
    {
        ������ = {},
    },
    {
        __index = function(self, key)
            if key == "process" then
                return function()
                    if #self.������ < 1 then return end

                    for k, v in ipairs(self.������) do
                        if v.�������_��_����� then v.�������_��_�����(self, k) end

                        if (os.clock() - v.���� > v.��������) then
                            if v.������� then v.�������(self) end
                            print(v.��������, "��Ҩ�", os.clock() - v.����)
                            table.remove(self.������, k); break
                        end
                    end
                end
            elseif key == "exist" then
                return function(n)
                    if #self.������ < 1 then return false end
                    for k, v in ipairs(self.������) do
                        if v.�������� == n then return os.clock() - v.����, v.�������� end
                    end
                    return false
                end
            

            elseif key == "refresh" then
                return function(self, t)
                    local index, del, full = self.exist(t)
                    self.������[index] = shab
                    return false
                end

            elseif key == "remove" then
                return function(t)
                    local index, del, full = self.exist(t)
                    table.remove(self.������, index)
                    return false
                end

            end


        end,

        __call = function(self, ��������, ��������, �������, �������_��_�����)
            local shab = { �������� = ��������, ������� = �������, ���� = os.clock(),
                �������� = ��������, �������_��_����� = �������_��_����� }

            local index, del, full = self.exist(��������)
            --print("������ ", ��������, encodeJson(shab))
            if index then
                print("������ ����������", ��������, encodeJson(shab))
                self.������[index] = shab
                return
            end
            print("������ ����������", ��������, encodeJson(shab))
            self.������[#self.������ + 1] = shab
            return
        end
    }
)

