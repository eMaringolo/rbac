"
I'm the main actor of this framework, all permissions are assigned to me, and I, in turn, am assigned to users.

The role represents a  unit of behavior, so one user or group can have several roles assigned instead of having a separate user for each role.
"
Class {
	#name : #RBACRole,
	#superclass : #RBACAbstractRole,
	#instVars : [
		'permissions'
	],
	#category : 'RBAC-Core'
}

{ #category : #permissions }
RBACRole >> addPermission: aRBACPermission [
	| previous |
	aRBACPermission role: self.
	^ (self hasPermissionFor: aRBACPermission target)
		ifTrue: [ (self permissionFor: aRBACPermission target) mergeFrom: aRBACPermission ]
		ifFalse: [ self permissions add: aRBACPermission ]
]

{ #category : #permissions }
RBACRole >> addPermissionFor: target [
	(self includesPermissionFor: target)
		ifFalse: [ self permissions add: (RBACPermission role: self target: target) allowAll ]
]

{ #category : #members }
RBACRole >> addUser: aRBACUser [
	self addProfile: aRBACUser
]

{ #category : #members }
RBACRole >> allSubrolesDo: aBlock [
]

{ #category : #private }
RBACRole >> canExecute: anObject [
	^ self permissions anySatisfy: [ :one | one target = anObject and: [ one allowsExecution ] ]
]

{ #category : #uncategorized }
RBACRole >> containsRole: aRole [
	^ aRole = self
]

{ #category : #permissions }
RBACRole >> ensurePermissionFor: anObject [

	^(self lookupPermissionFor: anObject)
		ifNil: [self addPermissionFor: anObject]
		ifNotNil: [:permission | permission]
]

{ #category : #permissions }
RBACRole >> includesPermissionFor: target [
	^ self permissions anySatisfy: [ :one | one target = target ]
]

{ #category : #testing }
RBACRole >> initialize [
	super initialize.
	self initializePermissions.
]

{ #category : #private }
RBACRole >> initializePermissions [
	permissions := OrderedCollection new
]

{ #category : #permissions }
RBACRole >> lookupPermissionFor: anObject [

	^self permissions detect: [:one | one target = anObject] ifNone: [nil]
]

{ #category : #permissions }
RBACRole >> permissionFor: anObject [

	| perm |
	perm := self lookupPermissionFor: anObject.
	^perm
		ifNil: [RBACTransientPermission role: self target: anObject]
		ifNotNil: 
			[perm target = anObject
				ifTrue: [perm]
				ifFalse: [perm asTransient target: anObject]]
]

{ #category : #accessing }
RBACRole >> permissions [
	permissions ifNil: [ self initializePermissions ].
	^ permissions
]

{ #category : #accessing }
RBACRole >> permissions: anObject [
	permissions := anObject
]

{ #category : #permissions }
RBACRole >> removeAllPermissions [
	
	self permissions removeAll
]

{ #category : #permissions }
RBACRole >> removePermission: aRBACCRUDPermission [
	^self permissions remove: aRBACCRUDPermission
]

{ #category : #members }
RBACRole >> removeUser: aRBACUser [ 
	
	(self users includes: aRBACUser) ifTrue: [ self users remove: aRBACUser ]
]

{ #category : #accessing }
RBACRole >> users [
	
	^self profiles select: [ :each | each isUser ]
]
