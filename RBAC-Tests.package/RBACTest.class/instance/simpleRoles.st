accessing
simpleRoles
	simpleRoles ifNil: [ self initializeSimpleRoles ].
	^ simpleRoles 