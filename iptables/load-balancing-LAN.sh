source nets.sh

#reglas para el dnat hacia web servers (con balanceo de carga aleatorio)
#iptables -t nat -A PREROUTING -i $Red -p tcp --dport 80 -m state --state NEW -m statistic --mode random --probability .50 -j DNAT --to-destination 10.33.1.200:80
#iptables -t nat -A PREROUTING -i $Red -p tcp --dport 80 -m state --state NEW -m statistic --mode random --probability .50 -j DNAT --to-destination 10.33.1.202:80

#reglas para el dnat hacia web servers (con balanceo de carga por conteo)
#iptables -t nat -A PREROUTING -i $Red -p tcp --dport 80 -m state --state NEW -m statistic --mode nth --every 4 --packet 1 -j DNAT --to-destination 10.33.1.200:80
#iptables -t nat -A PREROUTING -i $Red -p tcp --dport 80 -m state --state NEW -m statistic --mode nth --every 4 --packet 0 -j DNAT --to-destination 10.33.1.202:80