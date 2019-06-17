"
I'm a composite role, all I contain is other roles.
As a composite I know how to walk through my subroles to lookup permissions.

I have to admit I'm convoluted and in practice I'm not used much and instead profiles like users and groups are assigned different non-composite roles to achieve the same behavior.
"
Class {
	#name : 'RBACCompositeRole',
	#superclass : 'RBACAbstractRole',
	#instVars : [
		'subroles'
	],
	#vw_namespace : 'Root',
	#category : 'RBAC-Core'
}

{ #category : 'roles' }
RBACCompositeRole >> addRole: aRBACRole [
	"Adds aRBACRole to the receiver subroles."
	
	self validateRoleAddition: aRBACRole.
	self subroles add: aRBACRole
]

{ #category : 'roles' }
RBACCompositeRole >> allSubrolesDo: aBlock [
	self subroles
		do: [ :each | 
			aBlock value: each.
			each allSubrolesDo: aBlock ]
]

{ #category : 'permissions' }
RBACCompositeRole >> canExecute: target [
	self
		allSubrolesDo: [ :each | 
			(each canExecute: target)
				ifTrue: [ ^ true ] ].
	^false
]

{ #category : 'roles' }
RBACCompositeRole >> containsRole: aRole [ 

	aRole = self ifTrue: [^true].
	self allSubrolesDo: [:each | each = aRole ifTrue: [^true]].
	^false
]

{ #category : 'private' }
RBACCompositeRole >> initializeSubroles [
	subroles := Set new
]

{ #category : 'testing' }
RBACCompositeRole >> isComposite [
	 "Answer whether receiver is composite."
	
	^true
]

{ #category : 'permissions' }
RBACCompositeRole >> permissionFor: anObject [ 
	"Answer the CRUD permission of the receiver for anObject."

	| permissions |
	permissions := OrderedCollection new.
	self allSubrolesDo: 
			[:each | 
			| perm |
			(perm := each permissionFor: anObject) isTransient ifFalse: [permissions add: perm]].
	^permissions inject: (RBACTransientPermission target: anObject)
		into: [:answer :perm | answer permissionOr: perm]
]

{ #category : 'permissions' }
RBACCompositeRole >> permissions [
	"Answer the CRUD permissions of the receiver."
	
	| crudPermissions |
	crudPermissions := Set new.
	self allSubrolesDo: [:each | crudPermissions addAll: each permissions ].
	^crudPermissions asOrderedCollection
]

{ #category : 'roles' }
RBACCompositeRole >> removeAllSubroles [
	"Removes all the subroles of receiver."
	
	self subroles removeAll
]

{ #category : 'roles' }
RBACCompositeRole >> removeRole: aRole [
	"Remove aRole from the receiver."
	
	^self subroles remove: aRole
]

{ #category : 'roles' }
RBACCompositeRole >> subroles [
	"Answer the value of the receiver's ''subroles'' instance variable."

	subroles ifNil: [self initializeSubroles].
	^subroles
]

{ #category : 'roles' }
RBACCompositeRole >> subroles: aCollection [ 
	"Private - Set the value of the receiver's ''subroles'' instance variable to the argument, aCollection."

	subroles := aCollection
]

{ #category : 'roles' }
RBACCompositeRole >> validateRoleAddition: role [ 
	"Adds role to the receiver list of subroles."

	(role equals: self) ifTrue: [RBACSameRole signalWith: role].
	(role containsRole: self) ifTrue: [RBACRoleRecursion signalWith: role].
	(self containsRole: role) ifTrue: [RBACRoleAlreadyAssigned signalWith: role]
]
