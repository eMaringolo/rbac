"
I represent a Menu item that is commonly used as a target for RBACPermissions
"
Class {
	#name : 'RBACMenu',
	#superclass : 'RBACPermissionSubject',
	#instVars : [
		'priority',
		'icon',
		'componentClass',
		'modelClass',
		'parent',
		'children'
	],
	#originalCategory : 'STAVEX-Security',
	#vw_namespace : 'Root',
	#category : 'RBAC-Core'
}

{ #category : 'accessing' }
RBACMenu >> children [

	^children
]

{ #category : 'accessing' }
RBACMenu >> children: anObject [

	children := anObject
]

{ #category : 'accessing' }
RBACMenu >> componentClass [

	^componentClass
]

{ #category : 'accessing' }
RBACMenu >> componentClass: anObject [

	componentClass := anObject
]

{ #category : 'accessing' }
RBACMenu >> icon [

	^icon
]

{ #category : 'accessing' }
RBACMenu >> icon: anObject [

	icon := anObject
]

{ #category : 'accessing' }
RBACMenu >> modelClass [

	^modelClass
]

{ #category : 'accessing' }
RBACMenu >> modelClass: anObject [

	modelClass := anObject
]

{ #category : 'accessing' }
RBACMenu >> parent [

	^parent
]

{ #category : 'accessing' }
RBACMenu >> parent: anObject [

	parent := anObject
]

{ #category : 'accessing' }
RBACMenu >> priority [

	^priority
]

{ #category : 'accessing' }
RBACMenu >> priority: anObject [

	priority := anObject
]
