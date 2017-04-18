accessing
allowsCreation: aBoolean
	bits := bits
		bitAt: 1
		put:
			(aBoolean
				ifTrue: [ 1 ]
				ifFalse: [ 0 ])