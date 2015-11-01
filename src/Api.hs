{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Api where

import           Control.Applicative
import           Web.Scotty
import qualified Database.Persist.Sqlite as P
import           Model
import           AppUtility

app :: P.ConnectionPool -> ScottyM ()
app pool = do
    let db = runDb pool

    get "/memos" $ do
        (memos :: [P.Entity Memo]) <- db $ P.selectList [] []
        json memos

    get "/memos/:id" $ do
        (key :: MemoId) <- paramKey "id"
        memo            <- db $ P.get key
        json memo

    put "/memos/:id" $ do
        (key :: MemoId) <- paramKey "id"
        (memo :: Memo)  <- jsonData
        db $ P.replace key memo
        json memo

    post "/memos" $ do
        (memo :: Memo) <- jsonData
        db $ P.insert memo
        json memo

    delete "/memos/:id" $ do
        (key :: MemoId) <- paramKey "id"
        db $ P.delete key
        json True
