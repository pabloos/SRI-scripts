#Borramos reglas anteriores
iptables -F
iptables -X
iptables -Z
iptables -t nat -F