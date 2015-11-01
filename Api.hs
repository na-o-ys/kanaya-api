{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Api where

import           Control.Monad.Trans
import           Control.Applicative
import           Web.Scotty
import qualified Database.Persist.Sqlite as P
import qualified Network.HTTP.Types      as HT
import           Model

app :: P.ConnectionPool -> ScottyM ()
app pool = do
    let db action = liftIO $ P.runSqlPool action pool

    post "/user" $ do
        (u :: Model.User) <- jsonData
        key               <- db $ P.insert u
        res               <- db $ P.get key
        json res

    post "/comment" $ do
        (c :: Comment) <- jsonData
        key            <- db $ P.insert c
        res            <- db $ P.get key
        json res
