testing
userCanUpdate: target
	"Answer whether the user can perform updates on objects of type target."
	
	^self userCanDo: (RBACUpdate of: target)