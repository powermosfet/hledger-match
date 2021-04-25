module Main where

import Relude 

import System.IO (hPutStrLn)
import System.Environment (getArgs)
import Lib (findUnmatched)
import qualified Data.Text as T

main :: IO ()
main = do
    args <- getArgs
    let mAccount = viaNonEmpty head args
    case mAccount of
        Just account -> findUnmatched $ T.pack account
        Nothing -> hPutStrLn stderr "Usage: hledger match <account>"
