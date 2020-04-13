module Lib
    ( findUnmatched
    ) where

import Relude

import Hledger (Transaction(..), MixedAmount, jtxns, pamount, showTransaction)
import Hledger.Read (readJournal, InputOpts(..), definputopts)
import Hledger.Query (Query(..), matchesTransaction, matchesPosting)
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
            findMatchRecursively accountQuery interestingTxns

accountAmount :: Query -> Transaction -> Maybe MixedAmount
accountAmount accountQuery tx =
    pamount <$> viaNonEmpty head (filter (matchesPosting accountQuery) (tpostings tx))

accountAmountIs :: Query -> MixedAmount -> Transaction -> Bool
accountAmountIs accountQuery amount tx =
    accountAmount accountQuery tx == Just amount

removeSingle :: (a -> Bool) -> [a] -> [a]
removeSingle predicate items =
    let
        (before, afterIncludingMatch) = break predicate items
        after = maybe [] id (viaNonEmpty tail afterIncludingMatch)
    in
    before <> after

findMatchRecursively :: Query -> [Transaction] -> IO ()
findMatchRecursively _ [] = return ()
findMatchRecursively accountQuery (tx:txs) = do
    case accountAmount accountQuery tx of
        Nothing -> 
            findMatchRecursively accountQuery txs

        Just amount -> do
            let newTxs = removeSingle (accountAmountIs accountQuery (negate amount)) txs
            if length newTxs == length txs then do
                putStrLn (showTransaction tx)
                putStrLn ""
                findMatchRecursively accountQuery txs
            else 
                findMatchRecursively accountQuery newTxs
