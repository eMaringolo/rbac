accessing
allowsDeletion: aBoolean
	bits := bits
		bitAt: 4
		put:
			(aBoolean
				ifTrue: [ 1 ]
				ifFalse: [ 0 ])