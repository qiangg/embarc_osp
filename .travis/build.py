#! /usr/bin/env python
import json
import os
import sys

example = {"arc_feature_cache":"baremetal/arc_feature/cache",
		"arc_feature_timer_interrupt":"baremetal/arc_feature/timer_interrupt",
		"arc_feature_udma":"baremetal/arc_feature/udma",
		"ble_hm1x":"baremetal/ble_hm1x",
		"blinky":"baremetal/blinky",
		"bootloader":"baremetal/bootloader"}

result = {"arc_feature_cache":0,
		"arc_feature_timer_interrupt":0,
		"arc_feature_udma":0,
		"blinky":0,
		"bootloader":0}

folder = ".travis"

if __name__ == '__main__':
	print(example)
	for (k,v) in example.items():
		print("example[%s]=" %k,v)
		pathin = "../example/"+v
		os.chdir(pathin)
		os.system("make "+sys.argv[1]+" clean")
		if os.system("make "+sys.argv[1]+" -k") != 0:
			result[k] = 1
		pathout = pathin.count('/')*"../"+folder
		os.chdir(pathout)
	print(result)

	for (k,v) in result.items():
		if v == 1:
			sys.exit(1)
	
	sys.exit(0)
