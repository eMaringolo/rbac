accessing
name
	name ifNil: [ self initializeRandomName ].
	^name