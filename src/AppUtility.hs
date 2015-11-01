{-# LANGUAGE FlexibleContexts #-}
module AppUtility where

import           Control.Monad.Trans
import           Control.Applicative
import           Web.Scotty
import qualified Database.Persist.Sqlite as P

runDb pool action = liftIO $ P.runSqlPool action pool

paramKey v = P.toSqlKey <$> param v
