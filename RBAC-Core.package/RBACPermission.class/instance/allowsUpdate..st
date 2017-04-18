accessing
allowsUpdate: aBoolean
	bits := bits
		bitAt: 3
		put:
			(aBoolean
				ifTrue: [ 1 ]
				ifFalse: [ 0 ])