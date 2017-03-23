accessing
preferences
	"Answer the value of the receiver's ''preferences'' instance variable."

	preferences ifNil: [self initializePreferences].
	^preferences