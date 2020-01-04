local Vector3D = require 'vector3d'
local event = require 'lib.samp.events'


function main()
	if not isSampLoaded() or not isCleoLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end

	wait(-1)
end

local lastmoveSpeed = 0
function event.onSendVehicleSync(data)
	local moveSpeed = Vector3D(data.moveSpeed['x'], data.moveSpeed['y'], data.moveSpeed['z'])
	local diff = moveSpeed:length() - lastmoveSpeed
	lastmoveSpeed = moveSpeed:length()

	if diff > 0.03 then
		moveSpeed:normalize()
		moveSpeed = moveSpeed * (lastmoveSpeed - diff + 0.03)
		data.moveSpeed['x'], data.moveSpeed['y'], data.moveSpeed['z'] = moveSpeed:get()
		lastmoveSpeed = moveSpeed:length()
	end
end
