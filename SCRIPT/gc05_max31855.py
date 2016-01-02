# coding:utf-8 Copy Right Atelier Grenouille © 2015 -
import sys 
sys.path.append("/home/pi/SCRIPT/max31855-master")
from max31855 import MAX31855, MAX31855Error

def gc05_read_max31854():
	cs_pin = 24
	clock_pin = 23
	data_pin = 22
	units = "c"
	thermocouple = MAX31855(cs_pin, clock_pin, data_pin, units)
	while 1:
		try:
			value = thermocouple.get()
			break
		except:
			pass
	thermocouple.cleanup()
	return value

def gc05_read_data():
	cs_pin = 24
	clock_pin = 23
	data_pin = 22
	units = "c"
	thermocouple = MAX31855(cs_pin, clock_pin, data_pin, units)
	while 1:
		try:
			value = thermocouple.get()
			break
		except:
			pass
	thermocouple.cleanup()
	return [{'value': value, 'unit': "℃"}]

if __name__ == '__main__':
	print gc05_read_max31854()
	print gc05_read_data()
