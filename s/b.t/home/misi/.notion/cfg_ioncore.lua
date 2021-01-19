--
-- Ion core configuration file
--

-- 
-- Bindings. This includes global bindings and bindings common to
-- screens and all types of frames only. See modules' configuration 
-- files for other bindings.
--
defbindings("WGroupWS", {

   -- it is important to know that the _ reffers to the current object
   -- so we need to be inside a workspace to rename it
   --
   -- whereas if we create a workspace in this context, the parrent will be the current workspace
   --
   -- so the result workspace inside workspace
  submap(META.."W", {
     kpress("R", "mod_query.query_renameworkspace(nil, _)"),
   })
})

-- WScreen context bindings
--
-- The bindings in this context are available all the time.
--
-- The variable META should contain a string of the form 'Mod1+'
-- where Mod1 maybe replaced with the modifier you want to use for most
-- of the bindings. Similarly META may be redefined to add a 
-- modifier to some of the F-key bindings.

-- key names are found in keysymdef.h without XK_ prefix

defbindings("WScreen", {
   bdoc("Switch to n:th object (workspace, full screen client window) "..
   "within current screen."),

   -- the following could be defined on the parent class as well         
   kpress(META.."F1", "WScreen.switch_nth(_, 0)"),
   kpress(META.."F2", "WScreen.switch_nth(_, 1)"),
   kpress(META.."F3", "WScreen.switch_nth(_, 2)"),
   kpress(META.."F4", "WScreen.switch_nth(_, 3)"),
   kpress(META.."F5", "WScreen.switch_nth(_, 4)"),
   kpress(META.."F6", "WScreen.switch_nth(_, 5)"),
   kpress(META.."F7", "WScreen.switch_nth(_, 6)"),
   kpress(META.."F8", "WScreen.switch_nth(_, 7)"),
   kpress(META.."F9", "WScreen.switch_nth(_, 8)"),
   kpress(META.."F10", "WScreen.switch_nth(_, 9)"),

   bdoc("Switch to next/previous object within current screen."),
   kpress(META.."comma", "WScreen.switch_prev(_)"),
   kpress(META.."period", "WScreen.switch_next(_)"),

   -- vim like bindings
   -- equivalent of window in vim is a screen here


   bdoc("Forward-circulate focus."),
   -- '_chld' used here stands to for an actual child window that may not
   -- be managed by the screen itself, unlike '_sub', that is likely to be
   -- the managing group of that window. The right/left directions are
   -- used instead of next/prev, because they work better in conjunction
   -- with tilings.
   --kpress(META.."Tab", "ioncore.goto_next(_chld, 'right')", "_chld:non-nil"),
   kpress(META.."Tab", "ioncore.goto_next(_chld, 'any')", "_chld:non-nil"),
   kpress(META.."Tab", "ioncore.goto_next(_chld, 'right')", "_chld:non-nil"),
   kpress(META.."a", "ioncore.goto_next(_chld, 'left')", "_chld:non-nil"),
   kpress(META.."u", "ioncore.goto_next(_chld, 'right')", "_chld:non-nil"),
   kpress(META.."q", "ioncore.goto_next(_chld, 'down')", "_chld:non-nil"),
   kpress(META.."j", "ioncore.goto_next(_chld, 'up')", "_chld:non-nil"),

   
   -- all related to menus 
   -- moved to frame
--   submap(META.."M", {
--      bdoc("Display the main menu."),
--      kpress(META.."M", "mod_menu.bigmenu(_, _sub, 'mainmenu')"), 
--      kpress("M", "mod_query.query_menu(_, _sub, 'mainmenu', 'Main menu:')"), 
--      kpress(META.."C", "mod_query.query_menu(_, _sub, 'ctxmenu', 'Context menu:')"),
--      kpress("C", "mod_query.query_menu(_, _sub, 'ctxmenu', 'Context menu:')"),
--      kpress(META.."F", "mod_menu.grabmenu(_, _sub, 'focuslist')"),
--      kpress("F", "mod_menu.grabmenu(_, _sub, 'focuslist')"),
--      kpress("W", "mod_menu.grabmenu(_, _sub, 'windowlist')"),
--      kpress(META.."W", "mod_menu.grabmenu(_, _sub, 'windowlist')"),
--      kpress(META.."L", "mod_query.query_lua(_)"),
--      kpress("L", "mod_query.query_lua(_)"),
--      kpress(META.."", "mod_query.query_exec(_)"),
--      kpress("R", "mod_query.query_exec(_)"),
--   }),

   -- all related to workspaces
   submap(META.."W", {
     kpress(META.."N", "ioncore.create_ws(_)"),
     kpress("N", "ioncore.create_ws(_)"),
     kpress(META.."Q", "mod_query.query_workspace(_)"),
     kpress("Q", "mod_query.query_workspace(_)"),
     -- R (rename) moved to the context of the workspace itself
  --    kpress("R", "mod_query.query_renameworkspace(nil, _)"),
   })

})

-- Client window bindings
--
-- These bindings affect client windows directly.

defbindings("WClientWin", {
--    kpress_wait(META.."L", "WClientWin.nudge(_)"),
--    submap(META.."C", {
--       bdoc("Kill client owning the client window."),
--       kpress("X", "WClientWin.kill(_)"),

--      bdoc("Send next key press to the client window. "..
--      "Some programs may not allow this by default."),
--      kpress("Q", "WClientWin.quote_next(_)"),
--   }),
})


-- Client window group bindings

defbindings("WGroupCW", {
   bdoc("Toggle client window group full-screen mode"),
   kpress_wait(META.."Return", "WGroup.set_fullscreen(_, 'toggle')"),
})


-- WMPlex context bindings
--
-- These bindings work in frames and on screens. The innermost of such
-- contexts/objects always gets to handle the key press. 

defbindings("WMPlex", {
   bdoc("Close current object."),
   submap(META.."P", {
      kpress_wait(META.."C", "WRegion.rqclose_propagate(_, _sub)")
   })

})

-- Frames for transient windows ignore this bindmap
defbindings("WMPlex.toplevel", {
-- commands to start programs... "Mute/Unmute Sound."),
    kpress("AnyModifier+XF86AudioMute", "ioncore.exec_on(_, 'amixer sset Master toggle')"),
    bdoc("Increase Volume."),
    kpress("AnyModifier+XF86AudioRaiseVolume", "ioncore.exec_on(_, 'amixer sset Master 3%+')"),
    bdoc("Decrease Volume."),
    kpress("AnyModifier+XF86AudioLowerVolume", "ioncore.exec_on(_, 'amixer sset Master 3%-')"),

   submap(META.."R", 
   {
      kpress(META.."T", "ioncore.exec_on(_, '/usr/bin/kitty' )"),
      -- kpress(META.."T", "ioncore.exec_on(_, '/usr/bin/xterm -fa Monospace -fs 22 -fg white -bg black' )"),
      --kpress("T", "ioncore.exec_on(_, '/usr/bin/xterm -fa Monospace -fs 22 -fg white -bg black' )"),
      --kpress("T", "ioncore.exec_on(_, '/usr/bin/xterm -fa Monospace -fs 16 -fg white -bg black' )"),
      kpress("T", "ioncore.exec_on(_, '/usr/bin/xterm -fa Monospace -fs 12 -fg white -bg black' )"),
      --kpress(META.."G", "ioncore.exec_on(_, '/usr/bin/gnome-terminal --hide-menubar' )"),
      --kpress("G", "ioncore.exec_on(_, '/usr/bin/gnome-terminal --hide-menubar' )"),
      kpress(META.."S", "ioncore.exec_on(_, '/usr/bin/stterm  -f \"Liberation Mono:size=22\"' )"),
      kpress("S", "ioncore.exec_on(_, '/usr/bin/stterm  -f \"Liberation Mono:size=22\"' )"),
      kpress(META.."B", "ioncore.exec_on(_, 'google-chrome')"),
      kpress("B", "ioncore.exec_on(_, 'google-chrome')"),
   }),   
   
   submap(META.."H", 
   {
      kpress(META.."H", "ioncore.exec_on(_, '/usr/bin/mpc next' )"),
      kpress("H", "ioncore.exec_on(_, '/usr/bin/mpc next' )"),
      kpress(META.."D", "ioncore.exec_on(_, '/usr/bin/mpc prev')"),
      kpress("D", "ioncore.exec_on(_, '/usr/bin/mpc prev')"),
      kpress(META.."S", "ioncore.exec_on(_, '/usr/bin/mpc stop')"),
      kpress("S", "ioncore.exec_on(_, '/usr/bin/mpc stop')"),
      kpress(META.."T", "ioncore.exec_on(_, '/usr/bin/mpc toggle')"),
      kpress("T", "ioncore.exec_on(_, '/usr/bin/mpc toggle')"),
   })    

})


-- WFrame context bindings
--
-- These bindings are common to all types of frames. Some additional
-- frame bindings are found in some modules' configuration files.

defbindings("WFrame", {
   submap(META.."F", {
      bdoc("Maximize the frame horizontally/vertically."),
      kpress("H", "WFrame.maximize_horiz(_)"),
      kpress("V", "WFrame.maximize_vert(_)"),
      bdoc("Begin move/resize mode."),
      --kpress("R", "WFrame.begin_kbresize(_)"),
      --kpress("M", "mod_menu.pmenu(_, _sub, 'ctxmenu')"),
      kpress("R", "mod_query.query_renameframe(nil, _)"),
      kpress("T", "Wframe.set_mode(_, 'tiled_alt')"),
   }),

   bdoc("Display context menu."),
   mpress("Button3", "mod_menu.pmenu(_, _sub, 'ctxmenu')"),


   bdoc("Switch the frame to display the object indicated by the tab."),
   mclick("Button1@tab", "WFrame.p_switch_tab(_)"),
   mclick("Button2@tab", "WFrame.p_switch_tab(_)"),

   bdoc("Resize the frame."),
   mdrag("Button1@border", "WFrame.p_resize(_)"),
   mdrag(META.."Button3", "WFrame.p_resize(_)"),

   bdoc("Move the frame."),
   mdrag(META.."Button1", "WFrame.p_move(_)"),

   bdoc("Move objects between frames by dragging and dropping the tab."),
   mdrag("Button1@tab", "WFrame.p_tabdrag(_)"),
   mdrag("Button2@tab", "WFrame.p_tabdrag(_)"),

})

-- Frames for transient windows ignore this bindmap

defbindings("WFrame", {
   bdoc("Query for a client window to attach."),

   bdoc("Switch to n:th object within the frame."),
   kpress(META.."1", "WFrame.switch_nth(_, 0)"),
   kpress(META.."2", "WFrame.switch_nth(_, 1)"),
   kpress(META.."3", "WFrame.switch_nth(_, 2)"),
   kpress(META.."4", "WFrame.switch_nth(_, 3)"),
   kpress(META.."5", "WFrame.switch_nth(_, 4)"),
   kpress(META.."6", "WFrame.switch_nth(_, 5)"),
   kpress(META.."7", "WFrame.switch_nth(_, 6)"),
   kpress(META.."8", "WFrame.switch_nth(_, 7)"),
   kpress(META.."9", "WFrame.switch_nth(_, 8)"),
   kpress(META.."0", "WFrame.switch_nth(_, 0)"),

   -- kpress(META.."e", "WFrame.switch_next(_)"),
   -- the above and below lines are equivalent
   kpress(META.."e", "_:switch_next()"),
   kpress(META.."o", "WFrame.switch_prev(_)"),

   submap(META.."F", {
      -- Display tab numbers when modifiers are released
      submap_wait("ioncore.tabnum.show(_)"),
      bdoc("Switch to next/previous object within the frame."),

      bdoc("Move current object within the frame left/right."),
      kpress("o", "WFrame.dec_index(_, _sub)", "_sub:non-nil"),
      kpress("e", "WFrame.inc_index(_, _sub)", "_sub:non-nil"),

      bdoc("Maximize the frame horizontally/vertically."),
      kpress("H", "WFrame.maximize_horiz(_)"),
      kpress("V", "WFrame.maximize_vert(_)"),

      bdoc("Attach tagged objects to this frame."),
      kpress("A", "ioncore.tagged_attach(_)"),
   }),
   submap(META.."M", {
      bdoc("Display the main menu."),
      kpress(META.."M", "mod_menu.bigmenu(_, _sub, 'mainmenu')"), 
      kpress("M", "mod_query.query_menu(_, _sub, 'mainmenu', 'Main menu:')"), 
      kpress(META.."C", "mod_query.query_menu(_, _sub, 'ctxmenu', 'Context menu:')"),
      kpress("C", "mod_query.query_menu(_, _sub, 'ctxmenu', 'Context menu:')"),
      kpress(META.."F", "mod_menu.grabmenu(_, _sub, 'focuslist')"),
      kpress("F", "mod_menu.grabmenu(_, _sub, 'focuslist')"),
      kpress("W", "mod_menu.grabmenu(_, _sub, 'windowlist')"),
      kpress(META.."W", "mod_menu.grabmenu(_, _sub, 'windowlist')"),
      kpress(META.."L", "mod_query.query_lua(_)"),
      kpress("L", "mod_query.query_lua(_)"),
      kpress(META.."", "mod_query.query_exec(_)"),
      kpress("R", "mod_query.query_exec(_)"),
   }),
})

-- Bindings for floating frames.

defbindings("WFrame.floating", {
   bdoc("Toggle shade mode"),
   mdblclick("Button1@tab", "WFrame.set_shaded(_, 'toggle')"),

   bdoc("Raise the frame."),
   mpress("Button1@tab", "WRegion.rqorder(_, 'front')"),
   mpress("Button1@border", "WRegion.rqorder(_, 'front')"),
   mclick(META.."Button1", "WRegion.rqorder(_, 'front')"),

   bdoc("Lower the frame."),
   mclick(META.."Button3", "WRegion.rqorder(_, 'back')"),

   bdoc("Move the frame."),
   mdrag("Button1@tab", "WFrame.p_move(_)"),
})


-- WMoveresMode context bindings
-- 
-- These bindings are available keyboard move/resize mode. The mode
-- is activated on frames with the command begin_kbresize (bound to
-- META.."R" above by default).

defbindings("WMoveresMode", {
--    bdoc("Cancel the resize mode."),
--    kpress("AnyModifier+Escape","WMoveresMode.cancel(_)"),
-- 
--    bdoc("End the resize mode."),
--    kpress("AnyModifier+Return","WMoveresMode.finish(_)"),
-- -- TODO revisit these ones
--    bdoc("Grow in specified direction."),
--    kpress("H",  "WMoveresMode.resize(_, -1, 0, 0, 0)"),
--    kpress("L", "WMoveresMode.resize(_, 0, 1, 0, 0)"),
--    kpress("K",    "WMoveresMode.resize(_, 0, 0, 1, 0)"),
--    kpress("J",  "WMoveresMode.resize(_, 0, 0, 0, 1)"),
--    kpress("F",     "WMoveresMode.resize(_, 1, 0, 0, 0)"),
--    kpress("B",     "WMoveresMode.resize(_, 0, 1, 0, 0)"),
--    kpress("P",     "WMoveresMode.resize(_, 0, 0, 1, 0)"),
--    kpress("N",     "WMoveresMode.resize(_, 0, 0, 0, 1)"),
-- 
--    bdoc("Shrink in specified direction."),
--    kpress("Shift+H",  "WMoveresMode.resize(_,-1, 0, 0, 0)"),
--    kpress("Shift+L", "WMoveresMode.resize(_, 0,-1, 0, 0)"),
--    kpress("Shift+K",    "WMoveresMode.resize(_, 0, 0,-1, 0)"),
--    kpress("Shift+J",  "WMoveresMode.resize(_, 0, 0, 0,-1)"),
--    kpress("Shift+F",     "WMoveresMode.resize(_,-1, 0, 0, 0)"),
--    kpress("Shift+B",     "WMoveresMode.resize(_, 0,-1, 0, 0)"),
--    kpress("Shift+P",     "WMoveresMode.resize(_, 0, 0,-1, 0)"),
--    kpress("Shift+N",     "WMoveresMode.resize(_, 0, 0, 0,-1)"),
-- 
--    bdoc("Move in specified direction."),
--    kpress(META.."H",  "WMoveresMode.move(_,-1, 0)"),
--    kpress(META.."L", "WMoveresMode.move(_, 1, 0)"),
--    kpress(META.."K",    "WMoveresMode.move(_, 0,-1)"),
--    kpress(META.."J",  "WMoveresMode.move(_, 0, 1)"),
--    kpress(META.."F",     "WMoveresMode.move(_,-1, 0)"),
--    kpress(META.."B",     "WMoveresMode.move(_, 1, 0)"),
--    kpress(META.."P",     "WMoveresMode.move(_, 0,-1)"),
--    kpress(META.."N",     "WMoveresMode.move(_, 0, 1)"),
})


--
-- Menu definitions
--


-- Main menu
defmenu("mainmenu", {
   menuentry("Run...",         "mod_query.query_exec(_)"),
   menuentry("Terminal",       "ioncore.exec_on(_, XTERM or 'x-terminal-emulator')"),
   menuentry("Lock screen",
   "ioncore.exec_on(_, ioncore.lookup_script('ion-lock'))"),
   menuentry("Help",           "mod_query.query_man(_)"),
   menuentry("About Ion",      "mod_query.show_about_ion(_)"),
   submenu("Styles",           "stylemenu"),
   --submenu("Debian",           "Debian"),
   submenu("Session",          "sessionmenu"),
})


-- Session control menu
defmenu("sessionmenu", {
   menuentry("Save",           "ioncore.snapshot()"),
   menuentry("Restart",        "ioncore.restart()"),
   menuentry("Restart TWM",    "ioncore.restart_other('twm')"),
   menuentry("Exit",           "ioncore.shutdown()"),
})


-- Context menu (frame actions etc.)
defctxmenu("WFrame", "Frame", {
   -- Note: this propagates the close to any subwindows; it does not
   -- destroy the frame itself, unless empty. An entry to destroy tiled
   -- frames is configured in cfg_tiling.lua.
   menuentry("Close",          "WRegion.rqclose_propagate(_, _sub)"),
   -- Low-priority entries
   menuentry("Attach tagged", "ioncore.tagged_attach(_)", { priority = 0 }),
   menuentry("Clear tags",    "ioncore.tagged_clear()", { priority = 0 }),
   menuentry("Window info",   "mod_query.show_tree(_, _sub)", { priority = 0 }),
   menuentry("Rename Frame",   "mod_query.query_renameframe(_)", { priority = 0 }),
})


-- Context menu for groups (workspaces, client windows)
defctxmenu("WGroup", "Group", {
   menuentry("Toggle tag",     "WRegion.set_tagged(_, 'toggle')"),
   menuentry("De/reattach",    "ioncore.detach(_, 'toggle')"), 
})


-- Context menu for workspaces
defctxmenu("WGroupWS", "Workspace", {
   menuentry("Close",          "WRegion.rqclose(_)"),
   menuentry("Rename",         "mod_query.query_renameworkspace(nil, _)"),
   menuentry("Attach tagged",  "ioncore.tagged_attach(_)"),
})


-- Context menu for client windows
defctxmenu("WClientWin", "Client window", {
   menuentry("Kill",           "WClientWin.kill(_)"),
})

