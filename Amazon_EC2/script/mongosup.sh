

ssh -i keys/server_node.pem ubuntu@54.194.9.114 -o StrictHostKeyChecking=no << 'ENDSSH'

ps auwx | grep mongodb | awk '{print $2}' | sed -n 1,1p > mongopid.txt

read pmongo < mongopid.txt

sudo kill ${pmongo}

sleep 2

rm mongodb/tmp/*

read ip < private_address.txt

mongos --configdb IPCFGSRV --chunkSize 1

sleep 2

mongo --host IPPROPRIO/admin --eval "db.runCommand( { addshard : "firstset/ip1,ip2..." } )"

ENDSSH
