while read public_address
do

ssh -i keys/server_node.pem ubuntu@${public_address} -o StrictHostKeyChecking=no << 'ENDSSH'

sudo pkill -f java

ENDSSH

done < address/public_address.txt
