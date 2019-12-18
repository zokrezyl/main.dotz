--
-- Ion default settings
--

dopath("cfg_ioncore")
dopath("cfg_kludges")
dopath("cfg_layouts")


dopath("mod_query")
dopath("mod_menu")
dopath("mod_tiling")
dopath("mod_statusbar")
dopath("mod_dock")
dopath("mod_sp")
dopath("mod_xrandr")
dopath("mod_notionflux")
dopath("mod_xrandr")

-- dopath("min_tabs")
--dopath("statusbar_wsname")
dopath("look_misi")


os.execute("dbus-send --session --print-reply=literal --dest=org.gnome.SessionManager /org/gnome/SessionManager org.gnome.SessionManager.RegisterClient string:i3 string:$DESKTOP_AUTOSTART_ID")
