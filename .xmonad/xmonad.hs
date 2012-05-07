import XMonad
import XMonad.Hooks.ManageDocks
  ( avoidStruts
  , manageDocks
  , ToggleStruts(ToggleStruts)
  )
import XMonad.Hooks.SetWMName (setWMName)
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Util.EZConfig (additionalKeysP)

main = xmonad $ defaultConfig
  { terminal           = "xterm"
  , normalBorderColor  = "#cccccc"
  , focusedBorderColor = "#ff2b06"
  , layoutHook  = avoidStruts . smartBorders $ tiled ||| Mirror tiled ||| Full
  , manageHook  = myManageHook <+> manageHook defaultConfig
  , startupHook
    =  setWMName "LG3D"
    >> spawn "xmobar"
    >> broadcastMessage ToggleStruts
  }
  `additionalKeysP`
  [ ("M-x c", spawn "chromium")
  , ("M-x f", spawn "firefox")
  , ("M-x t", spawn "thunderbird")
  , ("M-b",   sendMessage ToggleStruts)
  ]
  where
    tiled   = Tall nmaster delta ratio
    nmaster = 1
    ratio   = 1 / 2
    delta   = 3 / 100

myManageHook = composeAll
  [ className =? "Firefox"  --> doShift "2"
  , className =? "Chromium" --> doShift "9"
  , manageDocks
  ]

