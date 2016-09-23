#NoEnv
#NoTrayIcon
#SingleInstance Force

; #c::Run "C:\Program Files\"
#c::Run "C:\Users\csimon\Desktop\Documents.lnk"
#p::Run "C:\Users\csimon\Documents\Music\Music\Playlists\All Music.wpl"
#h::Run "C:\Users\csimon\Desktop\Homework.lnk"
#f::Run "C:\Program Files (x86)\Mozilla Firefox\firefox.exe"
^`::Run "C:\Users\csimon\Desktop\debian.lnk"
^+#!S::Shutdown, 1  ; Shutdown
^+#!R::Shutdown, 6  ; Restart
^+#!H::DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0) ; Sleep
; ^+#!H::DllCall("PowrProf\SetSuspendState", "int", 1, "int", 0, "int", 0) ; Hibernate
Return