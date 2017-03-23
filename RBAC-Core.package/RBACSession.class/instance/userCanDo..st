testing
userCanDo: aRBACAction
	"Answer whether the user can perform aRBACAction."
	
	^self request: aRBACAction ifGranted: [true] ifDenied: [false]