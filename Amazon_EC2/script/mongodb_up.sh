while read public_machine
do

ssh -i keys/server_node.pem ubuntu@${public_machine} -o StrictHostKeyChecking=no << 'ENDSSH'

ps auwx | grep mongodb | awk '{print $2}' | sed -n 1,1p > mongopid.txt

read pmongo < mongopid.txt

sudo kill ${pmongo}

sleep 2

rm mongodb/tmp/*

read ip < private_address.txt

mongod --dbpath /home/ubuntu/mongodb/tmp/ --bind_ip $ip --replSet replica --logpath /home/ubuntu/mongodb/mongodlog.txt &

ENDSSH

done < address/public_address.txt
