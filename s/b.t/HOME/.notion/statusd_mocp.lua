-- Authors: tyranix <tyranix@gmail.com>
-- License: Public domain
-- Last Changed: Unknown
--
-- statusd_mocp.lua
--[[
statusd for moc (Music On Console).  This is called mocp for two reasons.
First, there is already a statusd_moc.lua.  Secondly, the actual executable
is called mocp on Debian because moc is taken by Qt.

Moc is a great replacement for xmms.  It's even better in an ion3 environment
because it's all console based.

Keys are now dynamically generated by the output from "mocp -i".  If mocp adds a
new field, it will be statusd.inform()ed.  No more messy tables or redundant
variables.  The keys follow the ion convention and are lowercased.

You can also use the new user_defined_* variables.  This lets you
have a template for when mocp is playing or paused (with lots of information)
and a very simple one for when it is off.  If you use the keys directly, then
you will get a lot of "?" when mocp is off.  You can either edit this file
directly or edit your cfg_statusbar.lua (see below).  I recommend editing your
cfg_statusbar.lua.

The format of the user_defined_* is to use the normal keys listed below
but without the mocp_ prefix.  For instance, in your cfg_statusbar.lua file
you could have:

  if not rotate_statusbar.configurations then
    rotate_statusbar.configurations = {
        -- Moc meter
        mocp = {
            -- Update the statusbar every 2 seconds.
            update_interval = 2 * 1000,

            -- Template when moc is playing music
            user_defined_play = 'moc: %state "%title" '
                                .. "(%currenttime / %totaltime)",

            -- Template when moc is paused
            user_defined_pause = 'moc: %state "%songtitle" %bitrate '
                                 .. "[%currenttime | %totaltime]",

            -- State is the only value reported when mocp is stopped.
            user_defined_stop = "moc: %state",

            -- State is the only value reported when mocp is off.
            user_defined_off = "",
        },
    }
  end

And then in your statusbar template, use %mocp_user_defined.  It will use
one of the user_defined_* templates depending on mocp's state.

Keys currently reported by "mocp -i":
 %mocp_state       (can be "PLAY", "PAUSE", "STOP", or "OFF")
 %mocp_file        (e.g. "/music/cdbaby/Celldweller_-_Switchback_-_2001.ogg")
 %mocp_title       (e.g. "Celldweller - Switchback - 2001 (The Beta Cessions)")
 %mocp_artist      (e.g. "Celldweller")
 %mocp_songtitle   (e.g. "Switchback - 2001")
 %mocp_album       (e.g. "The Beta Cessions")
 %mocp_totaltime   (e.g. "04:35")
 %mocp_timeleft    (e.g. "04:22")
 %mocp_totalsec    (e.g. "275")
 %mocp_currenttime (e.g. "00:13")
 %mocp_currentsec  (e.g. "13")
 %mocp_bitrate     (e.g. "87Kbps")
 %mocp_rate        (e.g. "44KHz")

This is not generated by mocp's output.  The format is determined by the
template in cfg_statusbar.lua.
 %mocp_user_defined (String based on user_defined_* and moc's state)

Default settings you can change from your statusbar configuration:
  update_interval    How frequently to change the status
  socket_dir         Where mocp's socket is relative to ion's working directory
  command            Command to execute to get information from mocp
  user_defined_play  Statusbar template when mocp is playing
  user_defined_pause Statusbar template when mocp is paused
  user_defined_stop  Statusbar template when mocp is stopped
  user_defined_off   Statusbar template when mocp is not running


Usage:

1) If you do not have ~/.ion3/cfg_statusbar.lua, copy that file from Ion3 to
   your ~/.ion3 directory.  On Debian, it is in /etc/X11/ion3/cfg_statusbar.lua.

2) Ion3 will load the appropriate modules if they are in the template at
   startup.

   So place one or more of the above %mocp_* fields into the template in
   ~/.ion3/cfg_statusbar.lua.

3) You can use the user_defined_* keys instead of using the keys
   in step #2.  To do this, open up ~/.ion3/cfg_statusbar.lua and go to
   the section with the defaults.  Add on_template and off_template in the
   table for mocp (you may have to add one similar to the load or mail).

   Then in your ~/.ion3/cfg_statusbar.lua, simply add %mocp_user_defined
   and it will expand either user_defined_* at runtime.

4) Restart ion3 (Hit F12 and type 'session/restart')

Alternative Usage: you could use rotate_statusbar.lua so you can rotate
between templates.  This is useful when you have too much information for
one statusbar template or you only care to know the info periodically.

To do this, copy rotate_statusbar.lua to ~/.ion3/cfg_statusbar.lua and
do steps 2-4 above.


You can test this out independent of ion.  This will print all of
the key=value pairs statusd.inform() was sent.

1) Copy statusd_mocp.lua to ~/.ion3/

2) Run '/usr/lib/ion3/ion-statusd -m mocp'
   This will dump out all of the updates to the terminal as they happen

3) Hit control+c when you are done testing.


All public domain based on statusd_moc.lua.  It also borrows some
ideas from rss_feed.lua which is public domain too.  I used the idea of
an on/off template from statusd_mocmon.lua.


tyranix [tyranix at gmail]

--]]

local defaults={
    -- Update every 2 seconds
    update_interval=2*1000,

    -- ~/.moc is where moc stores preferences and the socket
    socket_dir=os.getenv("HOME").."/.moc",

    -- Command to get information from mocp.
    command="mocp -i 2>/dev/null",

    -- User defined template.  If mocp is off, we replace it with the other
    -- template.  This template format is similar to the statusbar template
    -- except that I only replace %mocp_* keys.  Leave off the mocp_ part
    -- because we don't need that here.
    user_defined_play = 'moc: %state "%title" (%currenttime / %totaltime)',

    -- User defined template when moc is paused.
    user_defined_pause = 'moc: %state "%songtitle" %bitrate '
                         .. "[%currenttime | %totaltime]",

    -- User defined template when moc is stopped.  Only the state key can be
    -- replaced in this string.
    user_defined_stop = "moc: %state",

    -- User defined template.  This is what is displayed if moc is turned off.
    -- Only the state key can be replaced.
    -- When moc isn't running, I prefer to not display anything.
    user_defined_off = "",
}

local mocp_timer = nil
local mocp_values = {}

-- Overwrite our defaults with the user's settings
local settings = table.join(statusd.get_config("mocp"), defaults)

-- This must come after the above settings definition.
local mocp_templates = {
   PLAY  = settings.user_defined_play,
   PAUSE = settings.user_defined_pause,
   STOP  = settings.user_defined_stop,
   OFF   = settings.user_defined_off,
}

-- Used by gsub on each pattern matched.  This sets the values.
-- 'name' and 'setting' are the two referenced patterns (in parentheses).
local function set_mocp_values(name, value)
    mocp_values[string.lower(name)] = value
end

-- Used by gsub on each pattern matched.  This returns the value for a template.
local function get_mocp_values(name)
    if not mocp_values[name] then
        return "?"
    else
        return mocp_values[name]
    end
end

-- Tell statusd to update its keys with our new values.
local function inform_statusd(mocp_status)
    local name, value
    mocp_values = {}

    -- If we didn't get any output from mocp, then it is turned off.
    if not mocp_status or mocp_status == "" then
        mocp_values["state"] = "OFF"
    else
        -- Go through the output from 'mocp -i' and find the values.
        -- All of mocp's output has this format:   Name: setting\n
        -- Even when there is no setting, there's always a space.
        -- The 20 at the end prevents it from going into an infinite loop if
        -- the user specified some strange option.  It makes at most 20
        -- substitutions.
        string.gsub(mocp_status, "(%w+): ([^\n]*)", set_mocp_values, 20)
    end

    -- Report all of the known values from mocp -i (not user defined).
    -- For off/stopped, it is only the state.
    for name, value in pairs(mocp_values) do
        statusd.inform("mocp_" .. name, value)
    end

    -- Point to the right user defined template depending on moc's state
    local template = mocp_templates[mocp_values["state"]];
    if not template then
        template = "statusd_mocp: Error!  Invalid state '"
                   .. mocp_values["state"] .. "' found"
    end

    -- Report the user's template
    local result = string.gsub(template, "%%([a-z0-9_]+)", get_mocp_values)
    statusd.inform("mocp_user_defined", result)
end

-- Continually read input until partial_data is nil then parse it.
local function read_from_mocp(partial_data)
    -- statusd.popen_bgread() will return data as it becomes available.
    -- The easiest way to handle this is to keep concatenating the data
    -- until it runs out.  There's no guarantee that popen_bgread() will
    -- return full lines (up to a newline).
    local mocp_status = ""
    while partial_data do
        mocp_status = mocp_status .. partial_data
        -- Yield until we get more input.  popen_bgread will call resume on us.
        partial_data = coroutine.yield()
    end

    -- After we have read all the data, then inform statusd.
    inform_statusd(mocp_status)

    -- Continually call the update function.
    mocp_timer:set(settings.update_interval, update_mocp)
end

-- Continually read from stderr.  It just prints it out to stdout now.
-- This should never be called because we're dumping it to /dev/null.
local function print_stderr(partial_data)
    local mocp_error = ""
    while partial_data do
        mocp_error = mocp_error .. partial_data
        -- Yield until we get more input.  popen_bgread will call resume on us.
        partial_data = coroutine.yield()
    end
    print(mocp_error, "\n")
end

-- Main loop for mocp.
function update_mocp()
    -- If there is no PID file, then moc is turned off.
    local f=io.open(settings.socket_dir.."/pid")
    if not f then
        -- mocp is turned off
        read_from_mocp()
    else
        f:close()

        -- Tell ion to start up mocp and keep reading partial
        -- chunks until it is complete.  This is better for
        -- performance because ion doesn't have to block here.
        statusd.popen_bgread(settings.command,
                             coroutine.wrap(read_from_mocp),
                             coroutine.wrap(print_stderr))
    end
end

-- Timer so we can keep telling statusd what the current value is.
mocp_timer = statusd.create_timer()
update_mocp()
