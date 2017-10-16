import os
import time
import datetime

ruta="/etc/network/"

now = datetime.datetime.now()

x = now.hour

if x >= 8 and x < 15:
	print "estas en clase"

	#cambiamos el nombre del archivo clase por interfaces solo
	os.system("cat " + ruta + "interfaces_clase > " + ruta + "interfaces")
elif x >= 15 or x < 8:
	print "estas en casa"

	#cambiamos el nombre del archivo casa por interfaces solo
	os.system("cat " + ruta + "interfaces_casa > " + ruta + "interfaces")

else:
	print "ERROR"
os.system("service networking restart")
