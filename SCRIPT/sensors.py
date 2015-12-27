# coding:utf-8 Copy Right Atelier Grenouille © 2015 -

import gc05_max31855

def gc05_read(sensor):
	if sensor == "max31855":
		return gc05_max31855.gc05_read_max31854()
	elif sensor == "":
		pass

if __name__ == '__main__':
	print gc05_read("max31855")

