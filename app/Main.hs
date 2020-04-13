module Main where

import Relude

import System.IO (hPutStrLn)
import System.Environment (getArgs)
import Lib (findUnmatched)

main :: IO ()
main = do
    args <- getArgs
    let mAccount = viaNonEmpty head args
    case mAccount of
        Just account -> findUnmatched account
        Nothing -> hPutStrLn stderr "Usage: findunmatched <account>"
