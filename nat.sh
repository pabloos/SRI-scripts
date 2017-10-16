#!/bin/sh 

#Variables 
Green="eth1"
Red="eth0"
Orange="eth2"

echo "############################"
echo "Generando reglas de iptables"
echo "############################"

#Borramos reglas anteriores
iptables -F
iptables -X
iptables -Z
iptables -t nat -F

#Politicas por defecto
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

#Reglas para localhost
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

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

#reglas para la redireccion ssh
iptables -t nat -A PREROUTING -p tcp --dport 2227 -i $Red -j DNAT --to-destination 192.168.80.100:27
iptables -t nat -A PREROUTING -p tcp --dport 2225 -i $Red -j DNAT --to-destination 10.33.1.201:25

#reglas para el dnat hacia web servers (sin balanceo de carga)
#iptables -t nat -A PREROUTING -p tcp --dport 80 -i $Red -j DNAT --to-destination 10.33.1.200:80
#iptables -t nat -A PREROUTING -p tcp --dport 8080 -i $Red -j DNAT --to-destination 10.33.1.202:80

#reglas balanceo DMZ-LAN
iptables -t nat -A PREROUTING -p tcp -i $Red --dport 80 -m state --state NEW -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 10.33.1.201:80
iptables -t nat -A PREROUTING -p tcp -i $Red --dport 80 -m state --state NEW -m statistic --mode nth --every 2 --packet 1 -j DNAT --to-destination 192.168.80.100:80

#reglas para el dnat hacia web servers (con balanceo de carga aleatorio)
#iptables -t nat -A PREROUTING -i $Red -p tcp --dport 80 -m state --state NEW -m statistic --mode random --probability .50 -j DNAT --to-destination 10.33.1.200:80
#iptables -t nat -A PREROUTING -i $Red -p tcp --dport 80 -m state --state NEW -m statistic --mode random --probability .50 -j DNAT --to-destination 10.33.1.202:80

#reglas para el dnat hacia web servers (con balanceo de carga por conteo)
#iptables -t nat -A PREROUTING -i $Red -p tcp --dport 80 -m state --state NEW -m statistic --mode nth --every 4 --packet 1 -j DNAT --to-destination 10.33.1.200:80
#iptables -t nat -A PREROUTING -i $Red -p tcp --dport 80 -m state --state NEW -m statistic --mode nth --every 4 --packet 0 -j DNAT --to-destination 10.33.1.202:80

echo "Puedes listar las reglas con iptables -L -n -v"
echo
