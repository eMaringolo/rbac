actions
request: aRBACAction ifGranted: grantBlock
	"Request the execution of aRBACAction, evaluates grantBlock if the access is granted,
	otherwise evaluates denyBlock."

	^self request: aRBACAction
		ifGranted: grantBlock
		ifDenied: [aRBACAction notifyDenialFor: self user]