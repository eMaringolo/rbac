accessing
roles
	roles ifNil: [ self initializeRoles ].
	^ roles