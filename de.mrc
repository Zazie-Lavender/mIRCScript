;DarkEngine Professional 4.xx Series
;Software developed by _aprentice_ (c) 2008 <--- Credit to this user for this script. I did not write it; it is only included in this project as
;a component of my scripts. Some of my code may come to depend on it later...depending on needs and I may update it a bit to reflect appropriate
;versions of windows if existing ones do not already exist.
;http://www.darkengine.net/

on *:load:{ echo -ae DarkEngine installed sucessfully... | dek 3 | fde }

alias biosvendor { dem Bios Vendor: $de(bios_vendor) }
alias biosdate { dem Bios Date: $de(bios_date) }
alias biosversion { dem Bios Version: $de(bios_version) }

;Operating System Information
;----
alias osver { dem Operating System: $de(winver) }
alias winuser { dem Windows User: $de(win_username) }
alias osinfo { dem OS info: $de(win_username) on $de(winver) }
alias uptime { dem Uptime: $de(uptime_short) }
alias luptime { dem Uptime: $de(uptime) }
alias record { dem Record Uptime: $de(record_uptime) }
alias winstall { dem Installed On: $de(win_install_date) }
alias winall { dem OS Info: $de(winver) $+  [ $+ $de(win_username) $+ ] installed on  $+ $de(win_install_date) }
alias pcname { dem Computer Name: $de(computer_name) }

;Central Processing Unit Information
;----
alias cpu { dem CPU: $de(cpuname) }
alias cpuspeed { dem CPU Speed: $de(cpuspeed) }
alias cpudetail { dem CPU Details: $de(cpudetails) }
alias cpuload { dem CPU Load: $de(cpuload) }
alias cpuarch { dem CPU Architecture: $de(cpuarchitech) }
alias cpucount { dem CPU Count: $de(cpucount) }
alias cpuinfo { dem CPU: $de(cpuname) $+ , $de(cpuspeed) $+ ,  $+ $de(cpu_cache_l2) $+  ( $+ $de(cpuload) Load $+ ) }
alias l1cache { dem L1 Cache: $de(cpu_cache_l1) }
alias l2cache { dem L2 Cache: $de(cpu_cache_l2) }
alias l3cache { dem L3 Cache: $de(cpu_cache_l3) }
alias cpu_socket { dem CPU Socket: $de(cpu_sockettype) }
alias cpu_cores { dem CPU Cores: $de(cpu_core_count) }
alias cpu_extclock { dem CPU External Clock: $de(cpu_external_clock) $+  MHz }
alias cpu_multiplier { dem CPU Multiplier: $de(cpu_multiplier) }

;Video Information
;----
alias monitor { dem Monitor: $de(monitor) }
alias videocard { dem Video Card: $de(videocard) }
alias res { dem Resolution: $de(screen_res) }
alias video { dem Video: $de(monitor) on $de(videocard)  $chr(40) $+ $de(screen_res) $+ $chr(41) }

;Sound Information
;----
alias soundcard { dem Sound Card: $de(soundcard) }

;Hard Drive Information
;----
alias hd { dem Hard Drives: $de(harddrive_space) }
alias hdspace { dem Hard Drive: $dll(deultimate.dll,harddrive_space_drive,$1) }
alias hdtotal { dem Total Free: $de(harddrive_space_free) $+ / $+ $de(harddrive_space_total) }
alias hdtotal2 { dem Total Free: $de(harddrive_space_free_exclude_network) $+ / $+ $de(harddrive_space_total_exclude_network) }

;Memory Information
;----
alias memload { dem Memory Load: $de(memory_load) }
alias mem { dem Avaliable Memory: $de(memory_avail) MB }
alias usedmem { dem Used Memory: $de(memory_used) MB }
alias totalmem { dem Total Memory: $de(memory_total) MB }
alias memratio { dem RAM: Used: $de(memory_used) $+ / $+ $de(memory_total) $+ MB }
alias vmemratio { dem Virtual RAM: Used: $de(memory_virtual_used) $+ / $+ $de(memory_virtual_total) $+ MB }
alias memsum { dem RAM: Used: $de(memory_used) $+ / $+ $de(memory_total) $+ MB ( $+ $de(memory_load) Load $+ ) }
alias memslots { dem Total Memory Slots: $de(memory_slots) }

;Internet Connection Information
;----
alias conn { dem Connection: $de(adapter_info_all) }
alias chadapter { $de(adapter_change) }
alias totaldown { dem Total Downloaded: $de(bandwidth_down_total) $+ MB }
alias totalup { dem Total Uploaded: $de(bandwidth_up_total) $+ MB }
alias tottrans { msg $active  $+ $dek $+ Downloaded: $de(bandwidth_down_total) MB  $+ $dek $+  Uploaded: $de(bandwidth_up_total) MB }

alias band { 
  set %de.band.down $de(bandwidth_down_total)
  set %de.band.down.ticks $ticks
  .timer 1 1 de_band_calc_down
}

alias upband {
  set %de.band.up $de(bandwidth_up_total)
  set %de.band.up.ticks $ticks
  .timer 1 1 de_band_calc_up
}

alias totband { 
  set %de.band.up $de(bandwidth_up_total)
  set %de.band.up.ticks $ticks
  set %de.band.down $de(bandwidth_down_total)
  set %de.band.down.ticks $ticks
  .timer 1 1 de_band_calc_total 
}

alias de_band_calc_down {
  set %de.band.down2 $de(bandwidth_down_total)
  set %de.band.down.curr $calc( ( %de.band.down2 - %de.band.down ) * 1000000 / ( $ticks - %de.band.down.ticks ) )
  dem Current Downstream:  $+ $round( %de.band.down.curr,2 ) $+  KBytes/s 
  unset %de.band.down
  unset %de.band.down2
  unset %de.band.down.curr
  unset %de.band.down.ticks
}

alias de_band_calc_up {
  set %de.band.up2 $de(bandwidth_up_total)
  set %de.band.up.curr $calc( ( %de.band.up2 - %de.band.up ) * 1000000 / ( $ticks - %de.band.up.ticks ) )
  dem Current Upstream:  $+ $round( %de.band.up.curr,2 ) $+  KBytes/s
  unset %de.band.up
  unset %de.band.up2
  unset %de.band.up.curr
  unset %de.band.up.ticks
}

alias de_band_calc_total {
  set %de.band.down2 $de(bandwidth_down_total)
  set %de.band.down.curr $calc( ( %de.band.down2 - %de.band.down ) * 1000000 / ( $ticks - %de.band.down.ticks ) )
  set %de.band.up2 $de(bandwidth_up_total)
  set %de.band.up.curr $calc( ( %de.band.up2 - %de.band.up ) * 1000000 / ( $ticks - %de.band.up.ticks ) )
  dem Downstream:  $+ $round( %de.band.down.curr, 2 ) $+   KBytes/s  $+ $dek $+  Upstream:  $+ $round( %de.band.up.curr, 2 ) $+  KBytes/s
  unset %de.band.down
  unset %de.band.down2
  unset %de.band.down.curr
  unset %de.band.down.ticks
  unset %de.band.up
  unset %de.band.up2
  unset %de.band.up.curr
  unset %de.band.up.ticks
}

;Misc Functions
;----
alias about { $de(about) }
alias sys { dem OS: $de(winver)  $+ $dek $+ CPU: $de(cpuname) $+ ,  $de(cpuspeed) $+ ,  $+ $de(cpu_cache_l2) $+   $+  $+ $dek $+ Video: $de(videocard) $+  ( $+ $de(screen_res) $+ )  $+ $dek $+ Sound:  $+ $de(soundcard)  $+ $dek $+ Memory: Used: $de(memory_used) $+ / $+ $de(memory_total) $+ MB  $+ $dek $+ Uptime: $de(uptime_short)  $+ $dek $+ HD Space: Free: $de(harddrive_space_free) $+ / $+ $de(harddrive_space_total)  $+ $dek $+ Connection: $de(adapter_info_all) }

;Mainboard Functions
;----
alias mobo_manu { dem Mainboard Vendor: $de(mobo_vendor) }
alias mobo_name { dem Mainboard Name: $de(mobo_name) }
alias mobo_ver { dem Mainboard Version: $de(mobo_version) }

;Beta Functions
;----
alias cdrom_drive { dem CDRom Drive: $de(cdrom_name) }
alias video_card_ram { dem Video Card RAM: $de(video_card_ram) $+  MB }

;Unsupport Functions
;----
;alias batlife { dem Battery Life: $de(BatteryLifeLeft) }
;alias batcharge { dem Battery Charged: $de(BatteryChargeStatus) }
;alias batpower { dem AC Power: $de(ACPowerStatus) }

;Darkengine Core Functions (do not modify)
;----
alias fde { flushini de.ini }
alias de { return $dll(deultimate.dll,$1,_) }
alias dem { msg $active  $+ $dek $+  $+ $1- } 
alias deq { return $$?="Enter message/text" }
alias dek { if ($isid == $true) { return $readini(de.ini,options,color) } | if ($isid == $false) { writeini de.ini options color $remove($1,) | flushini de.ini } }



; Darkengine Script Menus
;---
menu channel,query {
  DE
  .System Information.:/sys
  .-
  Operating System
  ..Version:/osver
  ..Username:/winuser
  ..Install Date:/winstall
  ..Computer Name:/pcname
  ..-
  ..Show All:/winall
  Processor Details
  ..Name:/cpu
  ..Load:/cpuload
  ..Multiplier:/cpu_multiplier
  ..Clock Speed:/cpuspeed
  ..External Clock Speed:/cpu_extclock
  ..-
  ;..Model Details:/cpudetail
  ;..Architecture:/cpuarch
  ..Socket:/cpu_socket
  ..Total Cores:/cpu_cores
  ..-
  ..L1 Cache:/l1cache
  ..L2 Cache:/l2cache
  ..L3 Cache:/l3cache
  ..-
  ..Show All:/cpuinfo
  Memory
  ..Memory Load:/memload
  ..-
  ..Total Memory Used:/memratio
  ..Total Memory Slots:/memslots
  ..-
  ..Total Virtual Memory Used:/vmemratio
  ..-
  ..Show All Physical:/memsum
  Hard Drive
  ..Total Space (Local):/hdtotal2
  ..Total Space (Local + Networked):/hdtotal
  ..-
  ..Show All Drives: /hd
  .System Uptime: say 3Uptime: $de(uptime) 3Record Uptime: $de(record_uptime)
  Video
  ..Video Card:/videocard
  ..-
  ..Screen Resolution:/res
  ..Monitor Manufacturer:/monitor
  ..-
  ..Show All:/Video
  .Sound Card:/soundcard
  Internet
  ..Connection Info:/conn
  ..-
  ..Current Upstream Usage:/upband
  ..Current Downstream Usage :/band
  ..Current Bandwidth Usage:/totband
  ..-
  ..Total Transferred:/tottrans
  ..-
  ..Change Adapter:/chadapter
  Mainboard
  ..Manufacturer:/mobo_manu
  ..Product Name:/mobo_name
  ..Version:/mobo_ver
  System Bios
  ..Vendor:/biosvendor
  ..Date:/biosdate
  ..Version:/biosversion
  Beta Functions
  ..CDRom Drive:/cdrom_drive
  ..Video Card RAM:/video_card_ram
  .-
  Winamp
  ..Current Playing:/wamp
  .-
  Help
  ..About:/about
}
