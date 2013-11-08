while read public_address
do

ssh -i keys/server_node.pem ubuntu@$public_address -o StrictHostKeyChecking=no << 'ENDSSH'

rm -r /var/lib/cassandra/*

ENDSSH

done < address/public_address.txt
