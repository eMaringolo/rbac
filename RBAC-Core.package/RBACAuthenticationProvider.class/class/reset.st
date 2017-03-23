uncategorized
reset
	"Resets the current instance of receiver."
	
	Current ifNotNil: [:c | c shutDown ].
	Current := nil