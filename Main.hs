{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

import Control.Applicative
import Data.Monoid (mconcat)
import Web.Scotty
import Model
import Action
import Database.Persist.Sqlite as P
import qualified Network.HTTP.Types      as HT

--import qualified Data.Aeson as AE

db = runSqlite "hogesql.sqlite3"

main = scotty 3000 $ do

  post "/user" $ do
    (u :: Model.User) <- jsonData
    key            <- db $ P.insert u
    res <- db $ P.get key
    json res

  post "/comment" $ do
    db $ runMigration migrateAll
    (c :: Comment) <- jsonData
    key            <- db $ P.insert c
    res            <- db $ P.get key
    json res
