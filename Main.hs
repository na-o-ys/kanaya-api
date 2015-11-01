{-# LANGUAGE DeriveDataTypeable   #-}
{-# LANGUAGE FlexibleInstances    #-}
{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE TypeSynonymInstances #-}

import           Control.Monad.Logger
import qualified Web.Scotty              as S
import qualified Database.Persist.Sqlite as P
import           Model
import           Api

createConn = runNoLoggingT $
             P.createSqlitePool "db/development.sqlite3" 5
migrate    = P.runSqlPool $ P.runMigration migrateAll

main = do
    pool <- createConn
    migrate pool

    S.scotty 3000 $ do
        Api.app pool
