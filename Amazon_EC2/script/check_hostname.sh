echo "control hostname: output -> public ip's machine : hostname"

i=0
num=0

while read line
do
num=$(($num+1))
done < address/public_address.txt

#in questo caso il while read < public_address da problemi poichè esegue una sola volta il ciclo!!!
while [ $i -lt $num ] 
do

i=$(($i+1))

ip=$(sed -n ${i}p 'address/public_address.txt')

hostname=$(ssh -i keys/server_node.pem ubuntu@${ip} -o StrictHostKeyChecking=no 'echo $HOSTNAME')

check=$(echo "$hostname" | awk '{print $1}' | cut -d'-' -f2)

if [ ${#check} -gt 3 ];
	then echo "${ip} : ${hostname}"
fi

done #< address/public_address.txt
