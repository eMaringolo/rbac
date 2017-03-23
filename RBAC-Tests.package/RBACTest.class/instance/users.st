accessing
users
	users ifNil: [ self initializeUsers ].
	^ users