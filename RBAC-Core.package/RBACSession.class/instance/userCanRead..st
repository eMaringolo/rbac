testing
userCanRead: target
	"Answer whether the user can read objects of type target."
	
	^self userCanDo: (RBACRead of: target)