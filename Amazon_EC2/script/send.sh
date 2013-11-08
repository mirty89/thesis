while read public_address
do

scp -i keys/server_node.pem cassandra-topology.properties ubuntu@${public_address}:/home/ubuntu/apache-cassandra-2.0.2/conf/

done < address/public_address.txt
