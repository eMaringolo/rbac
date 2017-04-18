accessing
allowsExecution: aBoolean
	bits := bits
		bitAt: 5
		put:
			(aBoolean
				ifTrue: [ 1 ]
				ifFalse: [ 0 ])