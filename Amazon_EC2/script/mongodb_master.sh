stringa='rs.initiate({"_id" : "replica", "members" : ['
i=0
z=0

while read machine
do

	if [ $i -eq $z ]
		then stringa=$stringa'{"_id" : '$i', "host" : "'${machine}':27017"}'
	else
		stringa=$stringa', {"_id" : '$i', "host" : "'${machine}':27017"}'
	fi
	i=$(($i+1))

done < address/private_address.txt

stringa=$stringa']})'

echo $stringa > rsinitiate.txt

read ip_master < public_address.txt

scp -i keys/server_node.pem rsinitiate.txt ubuntu@$ip_master:/home/ubuntu
sleep 2
ssh -i keys/server_node.pem ubuntu@$ip_master -o StrictHostKeyChecking=no << 'ENDSSH'

read ip < private_address.txt

read rsinitiate < rsinitiate.txt

mongo --host $ip --eval "printjson($rsinitiate)"

ENDSSH
