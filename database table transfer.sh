#!/bin/bash
export PGPASSWORD=''
#add ip of source and destination_db
source_db=
destination_db=

#psql -U postgres -d transfer_table_copy2 -c "alter table auditlog_log rename to \"$table1\" ";
#psql -U postgres -d transfer_table_copy2 -c "alter table  auditlog_log_line rename to \"$table2\" ";
#psql -U postgres -d transfer_table_copy2 -c "alter sequence auditlog_log rename to \"$sequence1\" ";
#psql -U postgres -d transfer_table_copy2 -c "alter sequence auditlog_log rename to \"$sequence2\" ";


pg_dump -U postgres -d $source_db -t auditlog_log | psql $destination_db  -U postgres
pg_dump -U postgres -d $source_db -t auditlog_log_line | psql $destination_db -U postgres
pg_dump -U postgres -d $source_db -t auditlog_http_session | psql $destination_db -U postgres
pg_dump -U postgres -d $source_db -t auditlog_http_request | psql $destination_db -U postgres

psql -U postgres -d $source_db -c "delete from auditlog_log ";
psql -U postgres -d $source_db -c "delete from auditlog_log_line";
psql -U postgres -d $source_db -c "delete from auditlog_http_session";
psql -U postgres -d $source_db -c "delete from auditlog_http_request";


pg_dump -U postgres -d $source_db -t auditlog_http_session | psql $destination_db -U postgres
pg_dump -U postgres -d $source_db -t auditlog_http_request | psql $destination_db -U postgres
pg_dump -U postgres -d $source_db -t auditlog_log | psql $destination_db  -U postgres
pg_dump -U postgres -d $source_db -t auditlog_log_line | psql $destination_db -U postgres
