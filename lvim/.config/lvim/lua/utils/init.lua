local utils = {}

local uv = require("luv")

local currenttime = ""
local function set_interval(interval, callback)
	local timer = uv.new_timer()
	local function ontimeout()
		callback(timer)
	end
	uv.timer_start(timer, interval, interval, ontimeout)
	return timer
end

local function update_wakatime()
	local stdin = uv.new_pipe()
	local stdout = uv.new_pipe()
	local stderr = uv.new_pipe()

	local _ = uv.spawn("wakatime-cli", {
		args = { "--today" },
		stdio = { stdin, stdout, stderr },
	}, function() -- on exit
		stdin:close()
		stdout:close()
		stderr:close()
	end)

	uv.read_start(stdout, function(err, data)
		assert(not err, err)
		if data then
			currenttime = " " .. data:sub(1, #data - 2)
		end
	end)
end

update_wakatime()
set_interval(5000, update_wakatime)

function utils.get_wakatime()
	return currenttime
end

return utils
