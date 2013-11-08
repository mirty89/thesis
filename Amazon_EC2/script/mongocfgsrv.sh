

ssh -i keys/server_node.pem ubuntu@54.194.8.140 -o StrictHostKeyChecking=no << 'ENDSSH'

ps auwx | grep mongodb | awk '{print $2}' | sed -n 1,1p > mongopid.txt

read pmongo < mongopid.txt

sudo kill ${pmongo}

sleep 2

rm mongodb/tmp/*

read ip < private_address.txt

mongod --configsvr--dbpath /home/ubuntu/mongodb/tmp/

ENDSSH
