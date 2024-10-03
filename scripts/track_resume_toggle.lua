-- track_resume_toggle.lua

local last_time = 0
local resume_enabled = false -- Track resume is disabled by default

-- Function to toggle track resume on/off
function toggle_resume()
    resume_enabled = not resume_enabled
    if resume_enabled then
        mp.osd_message("Track resume: ON")
    else
        mp.osd_message("Track resume: OFF")
    end
end

-- Seek to last known time if resume is enabled
mp.register_event("file-loaded", function()
    if resume_enabled and last_time > 0 then
        mp.commandv("seek", last_time, "absolute", "exact")
    end
end)

-- Update the last known time
mp.observe_property("time-pos", "number", function(_, time)
    if resume_enabled and time then
        last_time = time
    end
end)

-- Keybinding to toggle track resume
mp.add_key_binding("Ctrl+r", "toggle-resume", toggle_resume)

