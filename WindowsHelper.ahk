
; -------------------------> Init

  Menu, Tray, Icon, img/icon.png

  #Include, lib.ahk

  ; ---> READ IN SETTINGS

    SETTING := {}
    MENUS := {}

    ; SETTING.HK1 := IniReader("Hotkeys", "1")
    ; SETTING.HK2 := IniReader("Hotkeys", "2")
    ; SETTING.HK3 := IniReader("Hotkeys", "3")
    ; SETTING.HK4 := IniReader("Hotkeys", "4")
    ; SETTING.HK5 := IniReader("Hotkeys", "5")
    ; SETTING.HK6 := IniReader("Hotkeys", "6")

    SETTING.BM1 := IniReader("Bookmarks", "1")
    SETTING.BM2 := IniReader("Bookmarks", "2")
    SETTING.BM3 := IniReader("Bookmarks", "3")
    SETTING.BM4 := IniReader("Bookmarks", "4")
    SETTING.BM5 := IniReader("Bookmarks", "5")
    SETTING.BM6 := IniReader("Bookmarks", "6")

    ; SETTING.APP1 := IniReader("App", "1")
    ; SETTING.APP2 := IniReader("App", "2")
    ; SETTING.APP3 := IniReader("App", "3")
    ; SETTING.APP4 := IniReader("App", "4")
    ; SETTING.APP5 := IniReader("App", "5")
    ; SETTING.APP6 := IniReader("App", "6")

    SETTING.FOLDER1 := IniReader("Folder", "1")
    SETTING.FOLDER2 := IniReader("Folder", "2")
    SETTING.FOLDER3 := IniReader("Folder", "3")
    SETTING.FOLDER4 := IniReader("Folder", "4")
    SETTING.FOLDER5 := IniReader("Folder", "5")
    SETTING.FOLDER6 := IniReader("Folder", "6")

    MENUS.BM_1 := IniReader("BMMenu", "1")
    MENUS.BM_2 := IniReader("BMMenu", "2")
    MENUS.BM_3 := IniReader("BMMenu", "3")
    MENUS.BM_4 := IniReader("BMMenu", "4")
    MENUS.BM_5 := IniReader("BMMenu", "5")
    MENUS.BM_6 := IniReader("BMMenu", "6")

    MENUS.BM := assembleMenu([MENUS.BM_1, MENUS.BM_2, MENUS.BM_3, MENUS.BM_4, MENUS.BM_5, MENUS.BM_6])

    ; MENUS.APP_1 := IniReader("APPMenu", "1")
    ; MENUS.APP_2 := IniReader("APPMenu", "2")
    ; MENUS.APP_3 := IniReader("APPMenu", "3")
    ; MENUS.APP_4 := IniReader("APPMenu", "4")
    ; MENUS.APP_5 := IniReader("APPMenu", "5")
    ; MENUS.APP_6 := IniReader("APPMenu", "6")

    ; MENUS.APP := assembleMenu([MENUS.APP_1, MENUS.APP_2, MENUS.APP_3, MENUS.APP_4, MENUS.APP_5, MENUS.APP_6])

    MENUS.FOLDER_1 := IniReader("FOLDERMenu", "1")
    MENUS.FOLDER_2 := IniReader("FOLDERMenu", "2")
    MENUS.FOLDER_3 := IniReader("FOLDERMenu", "3")
    MENUS.FOLDER_4 := IniReader("FOLDERMenu", "4")
    MENUS.FOLDER_5 := IniReader("FOLDERMenu", "5")
    MENUS.FOLDER_6 := IniReader("FOLDERMenu", "6")

    MENUS.FOLDER := assembleMenu([MENUS.FOLDER_1, MENUS.FOLDER_2, MENUS.FOLDER_3, MENUS.FOLDER_4, MENUS.FOLDER_5, MENUS.FOLDER_6])

  ; --|

  ; Keyboard Detection
    FileReadLine, keyboardType, C:\Dev\os.txt, 1
    If (%keyboardType% = mac)
      ; Alt::LWin
      ; LWin::Alt
      ; RWin::Alt

      ; --> Media Buttons

        ;next song
        F15::Send {Media_Next}
        return

        ;previous song
        F14::Send {Media_Prev}
        return

        ;play/pause
        F13::Send {Media_Play_Pause}
        return


      ; --|
    ; Else
      ; --> Media Buttons
        ; Ctrl + Numpad1::Send {Media_Play_Pause}
        ; return

        ; Ctrl + Numpad2::Send {Media_Prev}
        ; return

        ; Ctrl + Numpad3::Send {Media_Next}
        ; return
      ; --|
    Return
  ; --|

  ; Configure Caps Lock
    #Persistent
    SetCapsLockState, AlwaysOff
    ; Caps Lock Disable
    capslock::return
    ; Caps Lock with shift+caps
    +Capslock::
      If GetKeyState("CapsLock", "T") = 1
          SetCapsLockState, AlwaysOff
      Else
          SetCapsLockState, AlwaysOn
    Return
  ; --|

  ; Reload Script
    ^!+r:: ; press control+r to reload
      Msgbox, Reload Windows Helper?
      ifMsgBox, Yes
        Reload
    return
  ; --|


  ; esacape
    Capslock & space::send, {Escape}
  ; --|

; --|

; -------------------------> Banks

  #Include, banks/search.ahk

  #Include, banks/apps.ahk

  #Include, banks/folders.ahk

  #Include, banks/bookmarks.ahk

  #Include, banks/utils.ahk


  ;--> GUI
    GUI_FILE := "\gui\Gui.ahk"

    s_SettingsLauncher:
      Run %A_AHKPath% "D:\Dev\AHK\MacroTool\Gui.ahk"
    Return

    l_SettingsLauncher:
      Run %A_AHKPath% "D:\Dev\AHK\MacroTool\Gui.ahk"
    Return

    d_SettingsLauncher:
      Run %A_AHKPath% "D:\Dev\AHK\MacroTool\Gui.ahk"
    Return


  ;--|

; --|

; -------------------------> Vendor

  ; #Include, vendor/virtualDesktops.ahk

  ; Run, vendor/vde/vde.ahk

; --|


; -------------------------> Hotkeys

  ; Search
    CapsLock & z::

      key=s
      shortLabel=s_Search
      longLabel=l_Search
      doubleLabel=d_Search

      KeyWait, %key%, T0.1

        If (ErrorLevel) {
          Gosub, %longLabel% ; Send long
          ; MsgBox, longg
        }
        Else {
          KeyWait, %key%, D T0.1
          if (ErrorLevel)
            Gosub, %shortLabel% ; Send single
            ; MsgBox, Single
          else
            Gosub, %doubleLabel% ; Send double
            ; MsgBox, double
        }
        KeyWait, %key%
    Return
  ;--|

  ; Launch Apps
    CapsLock & d::

      key=a
      shortLabel=s_LaunchApp
      longLabel=l_LaunchApp
      doubleLabel=d_LaunchApp

      KeyWait, %key%, T0.1

        If (ErrorLevel) {
          Gosub, %longLabel% ; Send long
        }
        Else {
          KeyWait, %key%, D T0.1
          if (ErrorLevel)
            Gosub, %shortLabel% ; Send single
          else
            Gosub, %doubleLabel% ; Send double
        }
        KeyWait, %key%
    Return
  ;--|

  ; Launch Folders
    CapsLock & e::

      key=e
      shortLabel=s_LaunchFolder
      longLabel=l_LaunchFolder
      doubleLabel=d_LaunchFolder

      KeyWait, %key%, T0.1

        If (ErrorLevel) {
          Gosub, %longLabel% ; Send long
        }
        Else {
          KeyWait, %key%, D T0.1
          if (ErrorLevel)
            Gosub, %shortLabel% ; Send single
          else
            Gosub, %doubleLabel% ; Send double
        }
        KeyWait, %key%
    Return
  ;--|

  ; Launch Bookmarks
    CapsLock & w::

      key=w
      shortLabel=s_BookmarkLauncher
      longLabel=s_BookmarkLauncher
      doubleLabel=s_BookmarkLauncher

      KeyWait, %key%, T0.1

        If (ErrorLevel) {
          Gosub, %longLabel% ; Send long
        }
        Else {
          KeyWait, %key%, D T0.1
          if (ErrorLevel)
            Gosub, %shortLabel% ; Send single
          else
            Gosub, %doubleLabel% ; Send double
        }
        KeyWait, %key%
    Return
  ;--|


  ; Settings
    CapsLock & c::

      key=c
      shortLabel=s_SettingsLauncher
      longLabel=l_SettingsLauncher
      doubleLabel=d_SettingsLauncher

      KeyWait, %key%, T0.1

        If (ErrorLevel) {
          Gosub, %longLabel% ; Send long
        }
        Else {
          KeyWait, %key%, D T0.1
          if (ErrorLevel)
            Gosub, %shortLabel% ; Send single
          else
            Gosub, %doubleLabel% ; Send double
        }
        KeyWait, %key%
    Return
  ;--|

  ; Navigation

    CapsLock & h::Left
    CapsLock & j::Down
    CapsLock & k::Up
    CapsLock & l::Right

    Capslock & q::send, !{Space}
    CapsLock & n::openWindowsNotification()

    PgDn::
      send, {Down}
      send, {Down}
      send, {Down}
      send, {Down}
      send, {Down}
      send, {Down}
      send, {Down}
      send, {Down}
      send, {Down}
      send, {Down}
      send, {Down}
      send, {Down}
    return

    PgUp::
      send, {Up}
      send, {Up}
      send, {Up}
      send, {Up}
      send, {Up}
      send, {Up}
      send, {Up}
      send, {Up}
      send, {Up}
      send, {Up}
      send, {Up}
      send, {Up}
    return

    CapsLock & PgDn::PgDn
    CapsLock & PgUp::PgUp

  ;--|

;--\


; -------------------------------------- Virtual Desktops

  ; Globals
  DesktopCount = 2 ; Windows starts with 2 desktops at boot
  CurrentDesktop = 1 ; Desktop count is 1-indexed (Microsoft numbers them this way)
  ;
  ; This function examines the registry to build an accurate list of the current virtual desktops and which one we're currently on.
  ; Current desktop UUID appears to be in HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo\1\VirtualDesktops
  ; List of desktops appears to be in HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops
  ;
  mapDesktopsFromRegistry() {
    global CurrentDesktop, DesktopCount
    ; Get the current desktop UUID. Length should be 32 always, but there's no guarantee this couldn't change in a later Windows release so we check.
    IdLength := 32
    SessionId := getSessionId()
    if (SessionId) {
      RegRead, CurrentDesktopId, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo\%SessionId%\VirtualDesktops, CurrentVirtualDesktop
      if (CurrentDesktopId) {
        IdLength := StrLen(CurrentDesktopId)
      }
    }
    ; Get a list of the UUIDs for all virtual desktops on the system
    RegRead, DesktopList, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops, VirtualDesktopIDs
    if (DesktopList) {
      DesktopListLength := StrLen(DesktopList)
      ; Figure out how many virtual desktops there are
      DesktopCount := DesktopListLength / IdLength
    } else {
      DesktopCount := 1
    }
    ; Parse the REG_DATA string that stores the array of UUID's for virtual desktops in the registry.
    i := 0
    while (CurrentDesktopId and i < DesktopCount) {
      StartPos := (i * IdLength) + 1
      DesktopIter := SubStr(DesktopList, StartPos, IdLength)
      OutputDebug, The iterator is pointing at %DesktopIter% and count is %i%.
      ; Break out if we find a match in the list. If we didn't find anything, keep the
      ; old guess and pray we're still correct :-D.
      if (DesktopIter = CurrentDesktopId) {
        CurrentDesktop := i + 1
        OutputDebug, Current desktop number is %CurrentDesktop% with an ID of %DesktopIter%.
        break
      }
      i++
    }
  }

  getSessionId() {
    ProcessId := DllCall("GetCurrentProcessId", "UInt")
    if ErrorLevel {
      OutputDebug, Error getting current process id: %ErrorLevel%
      return
    }
    OutputDebug, Current Process Id: %ProcessId%
    DllCall("ProcessIdToSessionId", "UInt", ProcessId, "UInt*", SessionId)
    if ErrorLevel {
      OutputDebug, Error getting session id: %ErrorLevel%
      return
    }
    OutputDebug, Current Session Id: %SessionId%
    return SessionId
  }

  switchDesktopByNumber(targetDesktop) {
    global CurrentDesktop, DesktopCount
    ; Re-generate the list of desktops and where we fit in that. We do this because
    ; the user may have switched desktops via some other means than the script.
    mapDesktopsFromRegistry()
    ; Don't attempt to switch to an invalid desktop
    if (targetDesktop > DesktopCount || targetDesktop < 1) {
      OutputDebug, [invalid] target: %targetDesktop% current: %CurrentDesktop%
      return
    }
    ; Go right until we reach the desktop we want
    while(CurrentDesktop < targetDesktop) {
      Send ^#{Right}
      CurrentDesktop++
      OutputDebug, [right] target: %targetDesktop% current: %CurrentDesktop%
    }
    ; Go left until we reach the desktop we want
    while(CurrentDesktop > targetDesktop) {
      Send ^#{Left}
      CurrentDesktop--
      OutputDebug, [left] target: %targetDesktop% current: %CurrentDesktop%
    }
  }

  createVirtualDesktop() {
    global CurrentDesktop, DesktopCount
    Send, #^d
    DesktopCount++
    CurrentDesktop = %DesktopCount%
    OutputDebug, [create] desktops: %DesktopCount% current: %CurrentDesktop%
  }

  deleteVirtualDesktop() {
    global CurrentDesktop, DesktopCount
    Send, #^{F4}
    DesktopCount--
    CurrentDesktop--
    OutputDebug, [delete] desktops: %DesktopCount% current: %CurrentDesktop%
  }


  ; Main
  SetKeyDelay, 75
  mapDesktopsFromRegistry()
  OutputDebug, [loading] desktops: %DesktopCount% current: %CurrentDesktop%

  ; User config!
  ; This section binds the key combo to the switch/create/delete actions
  CapsLock & 1::switchDesktopByNumber(1)
  CapsLock & 2::switchDesktopByNumber(2)
  CapsLock & 3::switchDesktopByNumber(3)
  CapsLock & 4::switchDesktopByNumber(4)
  CapsLock & 5::switchDesktopByNumber(5)

  CapsLock & s::switchDesktopByNumber(CurrentDesktop + 1)
  CapsLock & a::switchDesktopByNumber(CurrentDesktop - 1)
  ;^!s::switchDesktopByNumber(CurrentDesktop + 1)
  ;^!a::switchDesktopByNumber(CurrentDesktop - 1)
  ;^!c::createVirtualDesktop()
  ;^!d::deleteVirtualDesktop()

; ---|