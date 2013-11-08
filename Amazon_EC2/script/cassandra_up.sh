num_nodes=`wc -l "address/private_address.txt" | awk '{print $1}'`
./script/token-generator 1 $num_nodes > tokens.txt

echo 'inizialization of '${num_nodes}' nodes'

i=0
x=0

while read single_seed
do

	if [ $x -eq $i ]
		then seed=$single_seed
		x=$(($x+1))
	else
		seed=$seed','$single_seed
	fi

done < address/private_address.txt

i=1
x=0

while read public_address
do

	i=$(($i+1))
	x=$(($x+1))
	token=`sed -n $i{p} tokens.txt`
	private_address=`sed -n $x{p} address/private_address.txt`

	cp script/cassandra_BKP_Random.yaml cassandra.yaml
	sed -i "s/KKKK_TOKEN/$token/g" cassandra.yaml
	sed -i "s/KKKK_LOCALHOST/$private_address/g" cassandra.yaml
	sed -i "s/KKKK_SEED/$seed/g" cassandra.yaml

	scp -i keys/server_node.pem cassandra.yaml ubuntu@${public_address}:/home/ubuntu/apache-cassandra-2.0.2/conf/

	sleep 2

ssh -i keys/server_node.pem ubuntu@${public_address} -o StrictHostKeyChecking=no << 'ENDSSH'

./apache-cassandra-2.0.2/bin/cassandra

ENDSSH

done < address/public_address.txt
