read ip_master < address/public_address.txt

scp -i keys/server_node.pem script/cassandra_keyspace_down ubuntu@$ip_master:/home/ubuntu/apache-cassandra-1.2.11/

ssh -i keys/server_node.pem ubuntu@$ip_master -o StrictHostKeyChecking=no << 'ENDSSH'

read ip < private_address.txt

./apache-cassandra-1.2.11/bin/cassandra-cli -h ${ip} -f /home/ubuntu/apache-cassandra-1.2.11/cassandra_keyspace_down

ENDSSH
