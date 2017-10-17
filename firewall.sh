#!/bin/sh

echo "##############################"
echo "#Generando reglas de iptables#"
echo "##############################"

sh iptables/flush.sh
sh iptables/localhost.sh
sh iptables/default-policies.sh
sh iptables/forward.sh
sh iptables/ssh-PAT.sh
#sh iptables/http-PAT.sh
#sh iptables/load-balancing-LAN.sh
sh  iptables/load-balancing-DMZ-LAN.sh

echo "Puedes listar las reglas con iptables -L -n -v"
echo
