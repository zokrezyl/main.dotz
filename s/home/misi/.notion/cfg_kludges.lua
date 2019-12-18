--
-- Options to get some programs work more nicely (or at all)
--


defwinprop{
    class = "AcroRead",
    instance = "documentShell",
    acrobatic = true
}


defwinprop{
    class = "Walrus 0.6.3",
    is_transient = true,
    --ignore_cfgrq = true,
    float=true,
    ignore_net_active_window=true,
    --acrobatic=true,
    --transient_mode=current,
}


defwinprop{
    class = "Ediff",
    is_transient = true,
    --ignore_cfgrq = true,
    float=true,
    ignore_net_active_window=true,
    --acrobatic=true,
    --transient_mode=current,
}

defwinprop{
    class = "InputOutput",
    is_transient = true,
    --ignore_cfgrq = true,
    float=true,
    ignore_net_active_window=true,
    --acrobatic=true,
    --transient_mode=current,
}


-- Put all dockapps in the statusbar's systray, also adding the missing
-- size hints necessary for this to work.


defwinprop{
    is_dockapp = true,
    statusbar = "systray"
    --max_size = { w = 64, h = 64},
    --min_size = { w = 64, h = 64},
}


-- You might want to enable these if you really must use XMMS. 
--[[
defwinprop{
    class = "xmms",
    instance = "XMMS_Playlist",
    transient_mode = "off"
}

defwinprop{
    class = "xmms",
    instance = "XMMS_Player",
    transient_mode = "off"
}
--]]


defwinprop{class="stalonetray",instance="stalonetray",statusbar="systray_stalone"}
defwinprop{instance="stalonetray",statusbar="systray_stalone"}
defwinprop{class="stalonetray",statusbar="systray_stalone"}

defwinprop{class="trayer",instance="trayer",statusbar="systray_trayer"}
defwinprop{instance="trayer",statusbar="systray_trayer"}
defwinprop{class="trayer",statusbar="systray_trayer"}

defwinprop{class="polybar",instance="polybar",statusbar="systray_polybar"}
defwinprop{instance="polybar",statusbar="systray_polybar"}
defwinprop{class="polybar",statusbar="systray_polybar"}

defwinprop{class="docker",instance="docker",statusbar="systray_stalone"}
defwinprop{instance="docker",statusbar="systray_docker"}
defwinprop{class="docker",statusbar="systray_docker"}

defwinprop{class="tint2",instance="tint2",statusbar="systray_stalone"}
defwinprop{instance="tint2",statusbar="systray_tint2"}
defwinprop{class="tint2",statusbar="systray_tint2"}


-- Define some additional title shortening rules to use when the full
-- title doesn't fit in the available space. The first-defined matching 
-- rule that succeeds in making the title short enough is used.
ioncore.defshortening("(.*) - Mozilla(<[0-9]+>)", "$1$2$|$1$<...$2")
ioncore.defshortening("(.*) - Mozilla", "$1$|$1$<...")
ioncore.defshortening("XMMS - (.*)", "$1$|...$>$1")
ioncore.defshortening("[^:]+: (.*)(<[0-9]+>)", "$1$2$|$1$<...$2")
ioncore.defshortening("[^:]+: (.*)", "$1$|$1$<...")
ioncore.defshortening("(.*)(<[0-9]+>)", "$1$2$|$1$<...$2")
ioncore.defshortening("(.*)", "$1$|$1$<...")
