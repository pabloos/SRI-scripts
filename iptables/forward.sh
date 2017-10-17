source nets.sh

#Regla para permitir el reenvío entre interfaces
echo "1" > /proc/sys/net/ipv4/ip_forward

#Permitimos el trafico de LAN a WAN
iptables -A FORWARD -i $Green -o $Red -j ACCEPT
iptables -t nat -A POSTROUTING -o $Red -j MASQUERADE
iptables -A FORWARD -i $Red -o $Green -m state --state ESTABLISHED,RELATED -j ACCEPT

#Permitimos el trafico de la WAN a LAN
iptables -A FORWARD -i $Red -o $Green -j ACCEPT 
iptables -t nat -A POSTROUTING -o $Green -j MASQUERADE
iptables -A FORWARD -i $Green -o $Red -m state --state ESTABLISHED,RELATED -j ACCEPT