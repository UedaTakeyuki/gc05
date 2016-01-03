# coding:utf-8 Copy Right Atelier Grenouille © 2015 -
import datetime 
import time
import paho.mqtt.client as mqtt
import logging
import importlib
#import sensors
#import sys 
#sys.path.append("/home/pi/SCRIPT/max31855-master")

# read configration.
import ConfigParser
configfile = '/home/pi/SCRIPT/config.ini'
ini = ConfigParser.SafeConfigParser()
ini.read(configfile)

# configure sensor reader.
reader_name = "gc05_"+ini.get("main","sensor")
sensor = importlib.import_module(reader_name)

# configure logfile
#logfile_path = "/boot/DATA/log/"+ini.get("main","sensor")+".csv"
logfile_path = ini.get("main","log_base")+ini.get("main","sensor")+".csv"
logging.basicConfig(format='%(message)s',filename=logfile_path,level=logging.INFO)

# connect mqtt server
port = 1883
host = 'localhost'
topic = 'value'
client = mqtt.Client()
#client.username_pw_set(username, password=password)
client.connect(host, port=port, keepalive=60)

while 1:
	# get current time.
	now = datetime.datetime.now()
	now_string = now.strftime("%Y/%m/%d %H:%M:%S")+"."+"%03d" % (now.microsecond // 1000)

	# read a sensor value.
	#value = sensors.gc05_read(ini.get("main","sensor"))
	value = sensor.gc05_read_data()[0]["value"]

	# send to mqtt server.
	client.publish(topic, '{0},{1}'.format(now_string,value))

	# log to logfile.
	logging.info('{0},{1}'.format(now_string,value))

	# sleep
	now_after=datetime.datetime.now()
	elapsed=(now_after - now).seconds +  float((now_after - now).microseconds)/1000000
#	msg_log ("Elapsed: "+str(elapsed))
	if (elapsed < float(ini.get("main","duration"))):
		time.sleep(float(ini.get("main","duration"))-elapsed) # need to adjusting.