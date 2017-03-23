accessing
permissions
	permissions ifNil: [ self initializePermissions ].
	^ permissions