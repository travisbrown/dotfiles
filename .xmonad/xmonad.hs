import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName (setWMName)
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Util.EZConfig (additionalKeysP)
import Control.Monad (liftM2)
import qualified Data.Map as M

toggleStrutsKey :: XConfig t -> (KeyMask, KeySym)
toggleStrutsKey XConfig{modMask = modm} = (modm, xK_b )

myStatusBar conf = do
  spawn "xmobar"
  return $ conf
    { layoutHook = avoidStruts (layoutHook conf)
    , logHook    = logHook conf
    , manageHook = manageHook conf <+> manageDocks
    , keys       = liftM2 M.union keys' (keys conf)
    }
    where keys' = (`M.singleton` sendMessage ToggleStruts) . toggleStrutsKey

main = xmonad =<< myStatusBar myConfig

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

