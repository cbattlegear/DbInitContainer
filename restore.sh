#!/bin/bash

trap "echo -e '\nTerminated by Ctrl+c'; exit" SIGINT

main() {
    wget https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2019.bak -O /restore/AdventureWorks2019.bak
    restore
}

restore() {
    trap "echo -e 'Connection failed, waiting 30 seconds and retrying'; restore" ERR
    sleep 30
    /opt/mssql-tools18/bin/sqlcmd -S $SQL_SERVER_ENDPOINT -U $SQL_SERVER_USERNAME -P $SQL_SERVER_PASSWORD -Q "RESTORE DATABASE AdventureWorks2019 FROM  DISK = N'/restore/AdventureWorks2019.bak' WITH MOVE 'AdventureWorks2017' TO '/var/opt/mssql/data/AdventureWorks2019.mdf', MOVE 'AdventureWorks2017_Log' TO '/var/opt/mssql/data/AdventureWorks2019_Log.ldf'"
}

main