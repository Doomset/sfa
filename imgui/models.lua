local texture = {}--место для загрузки текстур

local loadtexture = function(id)
    if texture[id] ~= nil then return end
    texture[id] = render_model(id,
        {
            ["background_color"] = 0xFF100000,
            ["zoom"] = 1,
            ["rotation"] = { ["x"] = -20, ["y"] = 0, ["z"] = 40 },
            ["carc_1"] = 0,
            ["carc_2"] = 1,
        })
end



local render_models = {
    1213, 1602, 701,
    1239,
}





local initializeModels = function()
    lua_thread.create(function()
        for i = 1, #render_models do
            wait(100)
            local id = render_models[i]
            loadtexture(id)
            trace("LOAD MODEL IMGUI " .. id)
        end
    end)
end


for _, v in ipairs(cfg["Аттачи"]["Модели"]) do
    for _, v2 in pairs(v.list) do
        table.insert(render_models, v2.data.id)
    end
end





ffi.cdef [[
    typedef unsigned char RwUInt8;
    typedef int RwInt32;
    typedef short RwInt16;

    struct RwRaster {
        struct RwRaster             *parent;
        RwUInt8                     *cpPixels;
        RwUInt8                     *palette;
        RwInt32                     width, height, depth;
        RwInt32                     stride;
        RwInt16                     nOffsetX, nOffsetY;
        RwUInt8                     cType;
        RwUInt8                     cFlags;
        RwUInt8                     privateFlags;
        RwUInt8                     cFormat;
        RwUInt8                     *originalPixels;
        RwInt32                      originalWidth;
        RwInt32                      originalHeight;
        RwInt32                      originalStride;
        void*                       texture_ptr;
    };

    struct RwTexture {
        struct RwRaster* raster;
    };

    struct CBaseModelInfo_vtbl {
        void* destructor;
        void* AsAtomicModelInfoPtr;
        void* AsDamageAtomicModelInfoPtr;
        void* AsLodAtomicModelInfoPtr;
        char(__thiscall* GetModelType)(struct CBaseModelInfo*);
    };

    struct CBaseModelInfo {
        struct CBaseModelInfo_vtbl* vtbl;
    };

    typedef struct RwTexture*(__thiscall* vehicle_render_t)(unsigned long, int, int, float*, float, int, int);
    typedef struct RwTexture*(__thiscall* ped_render_t)(unsigned long, int, int, float*, float);
    typedef struct RwTexture*(__thiscall* others_render_t)(unsigned long, int, int, float*, float);
]]

do local MODEL_INFO_ATOMIC = 1; local MODEL_INFO_TIME = 3; local MODEL_INFO_WEAPON = 4; local MODEL_INFO_CLUMP = 5; local MODEL_INFO_VEHICLE = 6; local MODEL_INFO_PED = 7; local MODEL_INFO_LOD = 8; local RwTextureDestroy = ffi.cast("int(__cdecl*)(struct RwTexture*)", 0x7F3820); local GetModelInfo = ffi.cast("struct CBaseModelInfo*(__cdecl*)(int)", 0x403DA0); local textures_from_render = {}; function render_ond3d_lost(); for i = 1, #textures_from_render do; RwTextureDestroy(textures_from_render[i]); end; end; function render_model(model_id, params); if 0 > model_id or model_id >= 20000 then return nil end; local backcolor = params["background_color"]; local zoom = params["zoom"]; local rot = params["rotation"]; local rotation = ffi.new("float [3]"); rotation[0] = rot.x; rotation[1] = rot.y; rotation[2] = rot.z; local offsets = { vehicle = { R1 = 0x2EE4E5, R3 = 0x6BC50 }, ped = { R1 = 0x2F522D, R3 = 0x6B9D0 }, others = { R1 = 0x2BE702, R3 = 0x6C240 }, sampst = { R1 = 0x21A108, R3 = 0x26E8F0 } }; local vSAMP = getGameGlobal(707) <= 21 and "R1" or "R3"; local model_info = GetModelInfo(model_id);; if model_info ~= ffi.NULL then; local model_type = model_info.vtbl.GetModelType(model_info);; local sampst = ffi.cast("unsigned long*", sampGetBase() + offsets["sampst"][vSAMP])[0]; local result = ffi.NULL; if model_type == MODEL_INFO_VEHICLE then; local func_addr = sampGetBase() + offsets["vehicle"][vSAMP]; result = ffi.cast("vehicle_render_t", func_addr)(sampst, model_id, backcolor,  rotation, zoom, params["carc_1"], params["carc_2"]); elseif model_type == MODEL_INFO_PED then; local func_addr = sampGetBase() + offsets["ped"][vSAMP]; result = ffi.cast("ped_render_t", func_addr)(sampst, model_id, backcolor,  rotation, zoom); elseif model_type == MODEL_INFO_WEAPON or model_type == MODEL_INFO_ATOMIC or model_type == MODEL_INFO_CLUMP then; local func_addr = sampGetBase() + offsets["others"][vSAMP]; result = ffi.cast("others_render_t", func_addr)(sampst, model_id, backcolor,  rotation, zoom); else; return nil; end; if result ~= ffi.NULL and result.raster ~= ffi.NULL and result.raster.texture_ptr ~= ffi.NULL then; textures_from_render[#textures_from_render + 1] = result; return result.raster.texture_ptr; end; return nil; end; end; end



function onD3DDeviceLost()
    render_ond3d_lost()
    for k, v in pairs(texture) do
        texture[k] = nil
    end
end
ffi.cdef [[
    typedef unsigned char RwUInt8;
    typedef int RwInt32;
    typedef short RwInt16;

    struct RwRaster {
        struct RwRaster             *parent;
        RwUInt8                     *cpPixels;
        RwUInt8                     *palette;
        RwInt32                     width, height, depth;
        RwInt32                     stride;
        RwInt16                     nOffsetX, nOffsetY;
        RwUInt8                     cType;
        RwUInt8                     cFlags;
        RwUInt8                     privateFlags;
        RwUInt8                     cFormat;
        RwUInt8                     *originalPixels;
        RwInt32                      originalWidth;
        RwInt32                      originalHeight;
        RwInt32                      originalStride;
        void*                       texture_ptr;
    };

    struct RwTexture {
        struct RwRaster* raster;
    };

    struct CBaseModelInfo_vtbl {
        void* destructor;
        void* AsAtomicModelInfoPtr;
        void* AsDamageAtomicModelInfoPtr;
        void* AsLodAtomicModelInfoPtr;
        char(__thiscall* GetModelType)(struct CBaseModelInfo*);
    };

    struct CBaseModelInfo {
        struct CBaseModelInfo_vtbl* vtbl;
    };

    typedef struct RwTexture*(__thiscall* vehicle_render_t)(unsigned long, int, int, float*, float, int, int);
    typedef struct RwTexture*(__thiscall* ped_render_t)(unsigned long, int, int, float*, float);
    typedef struct RwTexture*(__thiscall* others_render_t)(unsigned long, int, int, float*, float);
]]



do local MODEL_INFO_ATOMIC = 1; local MODEL_INFO_TIME = 3; local MODEL_INFO_WEAPON = 4; local MODEL_INFO_CLUMP = 5; local MODEL_INFO_VEHICLE = 6; local MODEL_INFO_PED = 7; local MODEL_INFO_LOD = 8; local RwTextureDestroy = ffi.cast("int(__cdecl*)(struct RwTexture*)", 0x7F3820); local GetModelInfo = ffi.cast("struct CBaseModelInfo*(__cdecl*)(int)", 0x403DA0); local textures_from_render = {}; function render_ond3d_lost(); for i = 1, #textures_from_render do; RwTextureDestroy(textures_from_render[i]); end; end; function render_model(model_id, params); if 0 > model_id or model_id >= 20000 then return nil end; local backcolor = params["background_color"]; local zoom = params["zoom"]; local rot = params["rotation"]; local rotation = ffi.new("float [3]"); rotation[0] = rot.x; rotation[1] = rot.y; rotation[2] = rot.z; local offsets = { vehicle = { R1 = 0x2EE4E5, R3 = 0x6BC50 }, ped = { R1 = 0x2F522D, R3 = 0x6B9D0 }, others = { R1 = 0x2BE702, R3 = 0x6C240 }, sampst = { R1 = 0x21A108, R3 = 0x26E8F0 } }; local vSAMP = getGameGlobal(707) <= 21 and "R1" or "R3"; local model_info = GetModelInfo(model_id);; if model_info ~= ffi.NULL then; local model_type = model_info.vtbl.GetModelType(model_info);; local sampst = ffi.cast("unsigned long*", sampGetBase() + offsets["sampst"][vSAMP])[0]; local result = ffi.NULL; if model_type == MODEL_INFO_VEHICLE then; local func_addr = sampGetBase() + offsets["vehicle"][vSAMP]; result = ffi.cast("vehicle_render_t", func_addr)(sampst, model_id, backcolor,  rotation, zoom, params["carc_1"], params["carc_2"]); elseif model_type == MODEL_INFO_PED then; local func_addr = sampGetBase() + offsets["ped"][vSAMP]; result = ffi.cast("ped_render_t", func_addr)(sampst, model_id, backcolor,  rotation, zoom); elseif model_type == MODEL_INFO_WEAPON or model_type == MODEL_INFO_ATOMIC or model_type == MODEL_INFO_CLUMP then; local func_addr = sampGetBase() + offsets["others"][vSAMP]; result = ffi.cast("others_render_t", func_addr)(sampst, model_id, backcolor,  rotation, zoom); else; return nil; end; if result ~= ffi.NULL and result.raster ~= ffi.NULL and result.raster.texture_ptr ~= ffi.NULL then; textures_from_render[#textures_from_render + 1] = result; return result.raster.texture_ptr; end; return nil; end; end; end



addEventHandler('onD3DDeviceLost', function ()
    render_ond3d_lost()
    for k, v in pairs(texture) do
        texture[k] = nil
    end
end)


return texture