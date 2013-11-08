rm address/public_address.txt
rm address/private_address.txt

while read id_mach
do

ec2-start-instances ${id_mach} -K keys/pk-1.pem -C keys/cert-1.pem --region eu-west-1

ec2-describe-instances ${id_mach} -K keys/pk-1.pem -C keys/cert-1.pem --region eu-west-1 | grep -oP "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" | sed -n 1,1p >> address/public_address.txt

ec2-describe-instances ${id_mach} -K keys/pk-1.pem -C keys/cert-1.pem --region eu-west-1 | grep -oP "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" | sed -n 2,2p >> address/private_address.txt

done < address/id_machines.txt
