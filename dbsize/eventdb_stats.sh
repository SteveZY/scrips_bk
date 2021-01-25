#!/bin/bash
db_host='host_url'
db_username='username'
db_core='db_core'
db_password='pass'

work_path=$(dirname $0)
cd ./${work_path}

SHELL_FOLDER=$(pwd)
cd -
export PGPASSFILE=~/.pgpass #format host:port:db:username:password
filename_csv="dbs.csv"
#"`date "+%Y%m%d_%H%M%S"`_dbs.csv"
#getting all the DBs 

#PGPASSWORD=${db_password} #set password / use the PGPASSFILE
psql -h $db_host -U $db_username -d $db_core -w -t -A -F"," -f $SHELL_FOLDER/gettingdbs.sql > $SHELL_FOLDER/${filename_csv}
# sed -e '$d' -e '1d' $SHELL_FOLDER/${filename_csv} > $SHELL_FOLDER/xxtmp.csv
# sed '1d' $SHELL_FOLDER/${filename_csv}
# mv $SHELL_FOLDER/xxtmp.csv $SHELL_FOLDER/${filename_csv}
evt_db_size="`date "+%Y%m%d_%H%M%S"`_db_size.csv"
echo "db,table,num_rows,tbl_size" > ${evt_db_size}
while read line  
do
    db_event=${line}
    # echo $db_event
    PGPASSWORD=${db_password} psql -h $db_host -U $db_username -d $db_event -w -t -A -F"," -f $SHELL_FOLDER/dbsize.sql >> ${evt_db_size}

done < $SHELL_FOLDER/${filename_csv}