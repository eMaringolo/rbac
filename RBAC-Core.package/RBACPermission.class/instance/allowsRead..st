accessing
allowsRead: aBoolean
	bits := bits
		bitAt: 2
		put:
			(aBoolean
				ifTrue: [ 1 ]
				ifFalse: [ 0 ])