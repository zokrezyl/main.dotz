local function get_winame()
   local name=""
   local cur=ioncore.find_manager(ioncore.current(), "WClientWin")
   if cur ~= nil then
      name = cur:name()
   end
   
   local desired = 70 

   local len = name:len()
   if desired < len  then 
      name = name:sub(0, desired)
   else
      name = name .. string.rep(" ", desired-len)
   end

   mod_statusbar.inform('winname', name)
end

local function hookhandler(reg, how)
   ioncore.defer(function() get_winame() mod_statusbar.update() end)
end

ioncore.get_hook("region_notify_hook"):add(hookhandler)
