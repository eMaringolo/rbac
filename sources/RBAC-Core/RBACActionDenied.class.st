"

"
Class {
	#name : 'RBACActionDenied',
	#superclass : 'RBACException',
	#instVars : [
		'user'
	],
	#vw_namespace : 'Root',
	#category : 'RBAC-Core'
}

{ #category : 'uncategorized' }
RBACActionDenied class >> denialErrorText [
	"Answer the description text for these exceptions."
	^ 'You are not authorized for doing this operation.'
]

{ #category : 'instance creation' }
RBACActionDenied class >> signalForUser: aRBACUser [ 
	
	^self new 
		user: aRBACUser;
		signal
]

{ #category : 'accessing' }
RBACActionDenied >> user: aRBACUser [
	user := aRBACUser
]
