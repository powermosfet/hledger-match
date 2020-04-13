# hledger-find-unmatched

If you track transfers between accounts using a intermediate account, it can sometimes be tricky to figure why its balance is not zero.

All transactions into the transfer account should have an equal, opposite transaction going out of the account.

This simple tool takes data from standard input, and prints any transactions that do not form such a pair with another transaction:

```
% hledger print -p thismonth | findunmatched assets:transfer

2020/02/03 Some kind of transfer
    assets:bank:mybank:savings       -78.85 EUR
    assets:transfer                   78.85 EUR

```
