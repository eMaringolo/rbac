private
initializeRandomName
	name := (self class name copyFrom: 5 to: self class name size)
		, 10000000 atRandom printString