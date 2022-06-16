local w = {
	currenttime = "",
}

local uv = require("luv")

function w.set_interval(interval, callback)
	local timer = uv.new_timer()
	local function ontimeout()
		callback(timer)
	end

	uv.timer_start(timer, interval, interval, ontimeout)
	return timer
end

function w.update_wakatime()
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
			w.currenttime = " " .. data:sub(1, #data - 2)
		end
	end)
end

function w.get_wakatime()
	return w.currenttime
end

function w.setup()
	w.update_wakatime()
	w.set_interval(5000, w.update_wakatime)
end

return w
