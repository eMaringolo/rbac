"
I represent a user in the framework, I can belong to groups and have different roles.
"
Class {
	#name : 'RBACUser',
	#superclass : 'RBACProfile',
	#instVars : [
		'behaviors',
		'password',
		'displayName',
		'groups',
		'isSuperuser',
		'persona',
		'passwordSalt',
		'email'
	],
	#vw_namespace : 'Root',
	#category : 'RBAC-Core'
}

{ #category : 'accessing' }
RBACUser class >> displayName [
	^'Users'
]

{ #category : 'configuration' }
RBACUser class >> superUserName [
	^ 'admin'
]

{ #category : 'comparing' }
RBACUser >> <= anObject [ 

	^self name <= anObject name
]

{ #category : 'groups' }
RBACUser >> addToRole: aRBACRole [ 

	aRBACRole addUser: self
]

{ #category : 'groups' }
RBACUser >> allRoles [
	^ self groups
		inject: Set new
		into: [ :coll :each | 
			coll
				addAll: each roles;
				yourself ]
]

{ #category : 'accessing' }
RBACUser >> basicDisplayName [
	"Answer the value of the receiver's ''displayName'' instance variable."

	^displayName
]

{ #category : 'behaviors' }
RBACUser >> behaviorAt: aByteString [ 
	
	^self behaviorAt: aByteString ifAbsent:[NotFound signalFor: aByteString]
]

{ #category : 'behaviors' }
RBACUser >> behaviorAt: aByteString ifAbsent: aBlock [
	^self behaviors at: aByteString ifAbsent: aBlock
]

{ #category : 'groups' }
RBACUser >> behaviorAt: aByteString put: aRBACUserBehavior [ 
	
	self behaviors at: aByteString put: aRBACUserBehavior
]

{ #category : 'behaviors' }
RBACUser >> behaviorOfClass: aRBACUserBehaviorClass [ 

	^self behaviors detect: [:one | one class= aRBACUserBehaviorClass ] ifNone: [NotFound signalFor:  aRBACUserBehaviorClass]
]

{ #category : 'groups' }
RBACUser >> behaviors [

	behaviors ifNil: [self initializeBehaviors].
	^behaviors
]

{ #category : 'groups' }
RBACUser >> behaviors: aDictionary [ 

	behaviors:= aDictionary
]

{ #category : 'permissions' }
RBACUser >> canExecute: target [
	^ (super canExecute: target)
		ifTrue: [ true ]
		ifFalse: [ self groups anySatisfy: [ :one | one canExecute: target ] ]
]

{ #category : 'accessing' }
RBACUser >> displayName [
	"Answer the value of the receiver's ''displayName'' instance variable."

	self basicDisplayName isNil ifTrue: [^self name].
	^displayName
]

{ #category : 'accessing' }
RBACUser >> displayName: anObject [
	"Set the value of the receiver's ''displayName'' instance variable to the argument, anObject."
	( anObject notNil and: [ anObject trimBlanks isEmpty ] )
		ifTrue: [ displayName := nil ]
		ifFalse: [ displayName := anObject ]
]

{ #category : 'tags-person' }
RBACUser >> email [

	^email ifNil: [email := String new]
]

{ #category : 'tags-person' }
RBACUser >> email: aString [

	email := aString
]

{ #category : 'private' }
RBACUser >> generateNewSalt [

	self passwordSalt: (Grease.GRPlatform current newRandom nextInt: SmallInteger maxVal * (10 raisedTo: 100)) asString
]

{ #category : 'accessing' }
RBACUser >> groups [
	"Answer the groups to which the receiver belongs."

	groups ifNil: [self initializeGroups].
	^groups
]

{ #category : 'accessing' }
RBACUser >> groups: aCollection [
	groups := aCollection
]

{ #category : 'behaviors' }
RBACUser >> hasBehavior: aRBACUserBehaviorClass [ 

	^self behaviors anySatisfy: [ :each | each class = aRBACUserBehaviorClass ]
]

{ #category : 'testing' }
RBACUser >> hasPersona [
	^ self persona notNil
]

{ #category : 'roles' }
RBACUser >> hasRole: aRole [
	^ (super hasRole: aRole)
		ifTrue: [ true ]
		ifFalse: [ self groups
				do: [ :each | 
					(each hasRole: aRole)
						ifTrue: [ ^ true ] ].
			false ]
]

{ #category : 'private' }
RBACUser >> initialize [
	super initialize.
	isSuperuser := false
]

{ #category : 'private' }
RBACUser >> initializeBehaviors [

	behaviors := Dictionary new
]

{ #category : 'private' }
RBACUser >> initializeGroups [
	groups := Set new
]

{ #category : 'accessing' }
RBACUser >> isSuperuser [
	"Answer the value of the receiver's ''isSuperuser'' instance variable."

	^isSuperuser
]

{ #category : 'accessing' }
RBACUser >> isSuperuser: anObject [
	"Set the value of the receiver's ''isSuperuser'' instance variable to the argument, anObject."

	isSuperuser := anObject
]

{ #category : 'testing' }
RBACUser >> isUser [

	^true
]

{ #category : 'groups' }
RBACUser >> onAddedToGroup: aRBACGroup [
	self groups add: aRBACGroup
]

{ #category : 'groups' }
RBACUser >> onRemovedFromGroup: aRBACGroup [
	self groups remove: aRBACGroup ifAbsent: [  ]
]

{ #category : 'accessing' }
RBACUser >> password [

	^password
]

{ #category : 'accessing' }
RBACUser >> password: anObject [

	password := anObject
]

{ #category : 'accessing' }
RBACUser >> passwordSalt [

	^passwordSalt
]

{ #category : 'accessing' }
RBACUser >> passwordSalt: anObject [

	passwordSalt := anObject
]

{ #category : 'permissions' }
RBACUser >> permissionFor: anObject [
	^ self groups
		inject: (super permissionFor: anObject) asTransient
		into: [ :perm :group | 
			perm
				permissionOr: (group permissionFor: anObject) ]
]

{ #category : 'accessing' }
RBACUser >> persona [
	^ persona
]

{ #category : 'accessing' }
RBACUser >> persona: anObject [
	persona := anObject
]

{ #category : 'printing' }
RBACUser >> rolesString [

	^String streamContents: 
			[:stream |
			self roles asArray asSortedCollection
				do: [:role | stream nextPutAll: role name]
				separatedBy: [stream nextPutAll: ', ']]
]

{ #category : 'accessing' }
RBACUser >> setNewPassword: passwordString [

	self setNewPassword: passwordString salt: nil
]

{ #category : 'accessing' }
RBACUser >> setNewPassword: passwordString salt: saltString [

	password := passwordString.
	saltString isEmptyOrNil
		ifTrue: [self generateNewSalt]
		ifFalse: [passwordSalt := saltString].
]
