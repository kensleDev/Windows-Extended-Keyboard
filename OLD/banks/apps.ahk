activateAppsMenu() {
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
}


appBank() {

  APP_1_NAME=Visual Studio Code
  APP_2_NAME=Chrome
  APP_3_NAME=Franz

  APP_6_NAME=Postman

  THE_MENU := assembleMenu([APP_1_NAME, APP_2_NAME, APP_3_NAME, DUMMY, DUMMY, APP_6_NAME])

  ToolTip % THE_MENU

  Input Key, L1
    ToolTip
    if Key=a
      RunOrActivate(APP_1_NAME)
    Else If Key=s
      RunOrActivate(APP_2_NAME)
    Else If Key=d
      RunOrActivate(APP_3_NAME)
    ; Else If Key=z
    ;   RunOrActivate()
    ; Else If Key=x
    ;   RunOrActivate()
    Else If Key=c
      RunOrActivate(APP_6_NAME)
  Return
}

s_LaunchApp:
  appBank()
Return

l_LaunchApp:
  appBank()
Return

d_LaunchApp:
  appBank()
Return