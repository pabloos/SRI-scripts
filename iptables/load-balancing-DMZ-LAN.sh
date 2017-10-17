source nets.sh

#reglas balanceo DMZ-LAN
iptables -t nat -A PREROUTING -p tcp -i $Red --dport 80 -m state --state NEW -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 10.33.1.201:80
iptables -t nat -A PREROUTING -p tcp -i $Red --dport 80 -m state --state NEW -m statistic --mode nth --every 2 --packet 1 -j DNAT --to-destination 192.168.80.100:80
