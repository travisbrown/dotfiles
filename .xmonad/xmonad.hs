import XMonad
import XMonad.Hooks.DynamicLog (xmobar)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName (setWMName)
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Util.EZConfig (additionalKeysP)

main = xmonad =<< xmobar myConfig

myConfig = defaultConfig
  { terminal           = "xterm"
  , normalBorderColor  = "#cccccc"
  , focusedBorderColor = "#ff2b06"
  , layoutHook  = smartBorders $ tiled ||| Mirror tiled ||| Full
  , manageHook  = myManageHook <+> manageHook defaultConfig
  , startupHook = setWMName "LG3D" >> broadcastMessage ToggleStruts
  }
  `additionalKeysP`
  [ ("M-x c", spawn "chromium")
  , ("M-x f", spawn "firefox")
  , ("M-x t", spawn "thunderbird")
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

