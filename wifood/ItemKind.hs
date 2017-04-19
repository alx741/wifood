{-# LANGUAGE TemplateHaskell #-}

module ItemKind where

import Database.Persist.TH
import Prelude (Show, Read, Eq, Enum, Bounded)

data ItemKind = Main | Dessert | Drink deriving (Show, Read, Eq)

derivePersistField "ItemKind"
