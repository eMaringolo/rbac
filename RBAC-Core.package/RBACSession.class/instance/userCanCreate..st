testing
userCanCreate: target 
	"Answer whether the user can create objects of type target."

	^self userCanDo: (RBACCreation of: target)