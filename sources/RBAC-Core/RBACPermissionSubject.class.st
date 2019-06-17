"

"
Class {
	#name : 'RBACPermissionSubject',
	#superclass : 'RBACNamedModel',
	#instVars : [
		'tag'
	],
	#vw_namespace : 'Root',
	#category : 'RBAC-Core'
}

{ #category : 'testing' }
RBACPermissionSubject >> isOperation [

	^false
]

{ #category : 'private' }
RBACPermissionSubject >> subjectType [
	"No op for Glorp filtered hierarchy"
]

{ #category : 'private' }
RBACPermissionSubject >> subjectType: aString [
	"No op for Glorp filtered hierarchy"
]

{ #category : 'accessing' }
RBACPermissionSubject >> tag [

	^tag
]

{ #category : 'accessing' }
RBACPermissionSubject >> tag: anObject [

	tag := anObject
]
