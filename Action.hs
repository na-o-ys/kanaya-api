{-# LANGUAGE DeriveGeneric, StandaloneDeriving #-} 
{-# LANGUAGE EmptyDataDecls       #-}
{-# LANGUAGE FlexibleContexts     #-}
{-# LANGUAGE FlexibleInstances    #-}
{-# LANGUAGE GADTs                #-}
{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE QuasiQuotes          #-}
{-# LANGUAGE TemplateHaskell      #-}
{-# LANGUAGE TypeFamilies         #-}
{-# LANGUAGE TypeSynonymInstances #-}
module Action where

import Control.Monad.Trans
import Control.Monad.Trans.Control
import Data.Text
import Database.Persist.Sqlite
import Model

ins :: (MonadBaseControl IO m, MonadIO m) => Text -> m ()
ins eml = runSqlite path $ do
  --runMigration migrateAll
  insert $ User {
    userEmail = eml,
    userPassword = Just "hoge"
  }
  return ()
    where
      path = "hogesql.sqlite3"
