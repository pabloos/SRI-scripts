source nets.sh

#reglas para el dnat hacia web servers (sin balanceo de carga)
#iptables -t nat -A PREROUTING -p tcp --dport 80 -i $Red -j DNAT --to-destination 10.33.1.200:80
#iptables -t nat -A PREROUTING -p tcp --dport 8080 -i $Red -j DNAT --to-destination 10.33.1.202:80