function applyRTXShader(spriteTag, str)
    local nums = {}

    for n in string.gmatch(str, "([^,]+)") do
        table.insert(nums, tonumber(n))
    end

    if #nums ~= 16 then
        debugPrint("RTX Shader: Code must contain 16 numbers")
        return
    end

    setSpriteShader(spriteTag, "RTXLighting")

    -- mask color
    setShaderFloatArray(spriteTag, "overlayColor", {
        nums[1], nums[2], nums[3], nums[4]
    })

    -- sprite color
    setShaderFloatArray(spriteTag, "satinColor", {
        nums[5], nums[6], nums[7], nums[8]
    })

    -- light color
    setShaderFloatArray(spriteTag, "innerShadowColor", {
        nums[9], nums[10], nums[11], nums[12]
    })

    -- angle (convert degrees → radians)
local angle = nums[13]
setShaderFloat(spriteTag, "innerShadowAngle", (angle - 90) * math.pi / 180)

    -- light size
    setShaderFloat(spriteTag, "innerShadowDistance", nums[14])

    -- layers
    setShaderFloat(spriteTag, "layernumbers", nums[15])

    -- separation
    setShaderFloat(spriteTag, "layerseparation", nums[16])
end


function onEvent(name, value1, value2)
    if name == "RTX Light" then
        applyRTXShader(value1, value2)
    end
end