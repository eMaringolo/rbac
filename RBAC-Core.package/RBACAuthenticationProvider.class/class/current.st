uncategorized
current
	"Answer the current instance of provider."
	
	Current ifNil: [self initializeCurrent].
	^Current