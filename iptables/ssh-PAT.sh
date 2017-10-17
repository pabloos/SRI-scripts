source nets.sh

#reglas para la redireccion ssh
iptables -t nat -A PREROUTING -p tcp --dport 2227 -i $Red -j DNAT --to-destination 192.168.80.100:27
iptables -t nat -A PREROUTING -p tcp --dport 2225 -i $Red -j DNAT --to-destination 10.33.1.201:25