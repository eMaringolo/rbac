actions
request: aRBACAction ifGranted: grantBlock ifDenied: denyBlock
	"Request the execution of aRBACAction, evaluates grantBlock if the access is granted,
	otherwise evaluates denyBlock."

	^(aRBACAction canBeDoneBy: self user) ifTrue: [grantBlock value] ifFalse: [denyBlock value]