import os
import sys
import time
import datetime

option = str(sys.argv[1])

try:
	option
except Null:
	print ""	
else:
	print "cambiando a configuracion de " + option

ruta="/etc/network/"

now = datetime.datetime.now()

x = now.hour

if (x >= 8 and x < 15) or (option == "clase") :
	print "estas en clase"

	#cambiamos el nombre del archivo clase por interfaces solo
	os.system("cat " + ruta + "interfaces_clase > " + ruta + "interfaces")
elif (x >= 15 or x < 8) or (option == "casa"):
	print "estas en casa"

	#cambiamos el nombre del archivo casa por interfaces solo
	os.system("cat " + ruta + "interfaces_casa > " + ruta + "interfaces")

else:
	print "ERROR"
os.system("service networking restart")
