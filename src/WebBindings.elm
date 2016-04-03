module WebBindings (..) where

import Native.WebBindings


toFixed : Int -> Float -> Result String String
toFixed =
  Native.WebBindings.toFixed
