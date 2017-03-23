accessing
compositeRoles
	compositeRoles ifNil: [ self initializeCompositeRoles ].
	^ compositeRoles