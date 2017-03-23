testing
userCanDelete: target
	"Answer whether the user can perform deletes on objects of type target."
	
	^self userCanDo: (RBACDeletion of: target)