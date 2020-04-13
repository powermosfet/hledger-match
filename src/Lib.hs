module Lib
    ( findUnmatched
    ) where

import Relude

import Hledger (jtxns)
import Hledger.Read (readJournal, InputOpts(..), definputopts)
import Hledger.Query (Query(..), matchesTransaction)
import Data.Text.IO (getContents)

inputOptions :: InputOpts
inputOptions =
    definputopts { ignore_assertions_ = True }

findUnmatched ::String -> IO ()
findUnmatched account = do
    result <- getContents >>= readJournal inputOptions Nothing
    case result of
        Left err -> putStrLn err
        Right j -> do
            let accountQuery = Acct account
            let interestingTxns = filter (matchesTransaction accountQuery) (jtxns j)
            putStrLn ("Transactions: " <> show (length (interestingTxns)))
            putStrLn ("Got account " <> account)
