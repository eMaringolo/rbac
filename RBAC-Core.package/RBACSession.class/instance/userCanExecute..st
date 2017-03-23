testing
userCanExecute: target
	"Answer whether the user can execute objects of type target."
	
	^self userCanDo: (RBACExecution of: target)