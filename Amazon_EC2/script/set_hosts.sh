#setting hostname and pa.txt (file with private ip)

while read public_address
do

ssh -i keys/server_node.pem ubuntu@${public_address} -o StrictHostKeyChecking=no << 'ENDSSH'

/sbin/ifconfig eth0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}' > private_address.txt

read ip < private_address.txt

hostname=$HOSTNAME

changed=$(sudo sed -n 2p /etc/hosts)

if [ ! -z "$changed" ];
	then sudo sed -i '2d' /etc/hosts
fi

sudo sed -i "s/127.0.0.1 localhost/127.0.0.1 localhost\n$ip $hostname/g" /etc/hosts

ENDSSH

done < address/public_address.txt
