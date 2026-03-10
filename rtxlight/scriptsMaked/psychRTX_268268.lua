local rtxCode = "0.58,0.31,0,-1,0.25,0,0,0.65,0,0.38,0.57,0.38,38,7,16,5"

function applyShaderFromString(spriteTag, str)
	local nums = {}

	for n in string.gmatch(str, "([^,%s]+)") do
		table.insert(nums, tonumber(n))
	end

	setSpriteShader(spriteTag, "RTXLighting")

	setShaderFloatArray(spriteTag, "overlayColor",
		{nums[1], nums[2], nums[3], nums[4]})

	setShaderFloatArray(spriteTag, "satinColor",
		{nums[5], nums[6], nums[7], nums[8]})

	setShaderFloatArray(spriteTag, "innerShadowColor",
		{nums[9], nums[10], nums[11], nums[12]})

	local angle = nums[13]

	setShaderFloat(spriteTag, "innerShadowAngle",
		(angle - 90) * math.pi / 180)

	setShaderFloat(spriteTag, "innerShadowDistance", nums[14])
	setShaderFloat(spriteTag, "layernumbers", nums[15])
	setShaderFloat(spriteTag, "layerseparation", nums[16])
end


function onCreatePost()

	applyShaderFromString("boyfriend", rtxCode)
	applyShaderFromString("dad", rtxCode)
	applyShaderFromString("gf", rtxCode)

end
