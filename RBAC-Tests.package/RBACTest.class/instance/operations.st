accessing
operations
	operations ifNil: [ self initializeOperations ].
	^ operations