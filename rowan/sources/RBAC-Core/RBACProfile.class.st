"
I'm the abstract class representing profiles in the framework.
"
Class {
	#name : 'RBACProfile',
	#superclass : 'RBACNamedModel',
	#instVars : [
		'roles',
		'preferences',
		'inheritPreferences'
	],
	#vw_namespace : 'Root',
	#category : 'RBAC-Core'
}

{ #category : 'uncategorized' }
RBACProfile class >> isAbstract [
	"Answer whether the receiver is an Abstract class."
	
	^self == RBACProfile
]

{ #category : 'roles' }
RBACProfile >> addRole: aRole [
	
	self roles add: aRole.
	aRole addProfile: self.
]

{ #category : 'members' }
RBACProfile >> addToRole: aRBACRole [ 

	aRBACRole addProfile: self
]

{ #category : 'roles' }
RBACProfile >> allRoles [
	^ self roles
]

{ #category : 'roles' }
RBACProfile >> canAdd: aRole [
	"Answer whether aRole can be added to receiver."
	
	^self hasRole: aRole
]

{ #category : 'permissions' }
RBACProfile >> canCreate: anObject [
	"Answer whether receiver can create anObject."
	
	^(self permissionFor: anObject) canCreate
]

{ #category : 'permissions' }
RBACProfile >> canDelete: anObject [
	"Answer whether receiver can delete anObject."
	
	^(self permissionFor: anObject) canDelete
]

{ #category : 'permissions' }
RBACProfile >> canExecute: target [
	^ self roles anySatisfy: [ :one | one canExecute: target ]
]

{ #category : 'permissions' }
RBACProfile >> canRead: anObject [
	"Answer whether receiver can read anObject."
	
	^(self permissionFor: anObject) canRead
]

{ #category : 'permissions' }
RBACProfile >> canUpdate: anObject [
	"Answer whether receiver can update anObject."
	
	^(self permissionFor: anObject) canUpdate
]

{ #category : 'accessing' }
RBACProfile >> description [
	"Answer the value of the receiver's ''description'' instance variable."

	^description
]

{ #category : 'accessing' }
RBACProfile >> description: aString [
	description := aString
]

{ #category : 'accessing' }
RBACProfile >> groups [
	^ OrderedCollection new
]

{ #category : 'roles' }
RBACProfile >> hasRole: aRole [
	self roles
		do: [ :each | 
			(each containsRole: aRole)
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : 'accessing' }
RBACProfile >> inheritPreferences [
	^ inheritPreferences
]

{ #category : 'accessing' }
RBACProfile >> inheritPreferences: aBoolean [
	inheritPreferences := aBoolean
]

{ #category : 'private' }
RBACProfile >> initialize [
	super initialize.
	inheritPreferences := false
]

{ #category : 'private' }
RBACProfile >> initializePreferences [
	preferences := OrderedCollection new
]

{ #category : 'private' }
RBACProfile >> initializeRoles [
	"Private - Initializes the roles of receiver."

	roles := Set new
]

{ #category : 'testing' }
RBACProfile >> isAdmin [

	^self name = self class superUserName
]

{ #category : 'testing' }
RBACProfile >> isGroup [

	^false
]

{ #category : 'testing' }
RBACProfile >> isUser [

	^false
]

{ #category : 'accessing' }
RBACProfile >> members [
	^ OrderedCollection with: self
]

{ #category : 'roles' }
RBACProfile >> onAddedToRole: anRBACRole [

	self roles add: anRBACRole
]

{ #category : 'roles' }
RBACProfile >> onRemovedFromRole: aRBACRole [ 
	self roles remove: aRBACRole ifAbsent: [  ]
]

{ #category : 'testing' }
RBACProfile >> ownOrInheritedPreferences [
	self inheritPreferences
		ifTrue: [ ^ self groups flatCollect: [ :each | each ownOrInheritedPreferences ] ].
	^ self preferences
]

{ #category : 'testing' }
RBACProfile >> ownPreferenceAt: sectionName named: preferenceName [
	^ self preferences
		detect: [ :one | one section = sectionName and: [ one name = preferenceName ] ]
		ifNone: [ nil ]
]

{ #category : 'testing' }
RBACProfile >> ownPreferenceValueAt: sectionName named: preferenceName [
	^ (self ownPreferenceAt: sectionName named: preferenceName) ifNotNil: [ :p | p value ]
]

{ #category : 'permissions' }
RBACProfile >> permissionFor: anObject [
	| permissions |
	permissions := OrderedCollection new.
	self roles do: [ :each | permissions add: (each permissionFor: anObject) ].
	^ permissions inject: (RBACTransientPermission target: anObject) into: [ :answer :perm | answer mergeFrom: perm ]
]

{ #category : 'preferences' }
RBACProfile >> preferenceAt: sectionName named: preferenceName [ 
	"Answer the preference named preferenceName located in the 
	section named sectionName."

	^self ownOrInheritedPreferences detect: [:one | one section = sectionName and: [one name = preferenceName]]
		ifNone: [nil]
]

{ #category : 'preferences' }
RBACProfile >> preferenceClass [
	^ self class preferenceClass
]

{ #category : 'preferences' }
RBACProfile >> preferenceValueAt: sectionName named: preferenceName [
	^ (self preferenceAt: sectionName named: preferenceName) ifNotNil: [ :p | p value ]
]

{ #category : 'preferences' }
RBACProfile >> preferenceValueAt: sectionName named: preferenceName ifAbsent: aBlock [
	^ (self preferenceAt: sectionName named: preferenceName)
		ifNil: aBlock
		ifNotNil: [ :p | p value ]
]

{ #category : 'preferences' }
RBACProfile >> preferenceValueAt: sectionName named: preferenceName put: newValue [

	^((self preferenceAt: sectionName named: preferenceName)
		ifNil: 
			[self preferences add: ((self profilePreferenceClass named: preferenceName
						section: sectionName)
						owner: self;
						yourself)])
			value: newValue
]

{ #category : 'accessing' }
RBACProfile >> preferences [
	"Answer the value of the receiver's ''preferences'' instance variable."

	preferences ifNil: [self initializePreferences].
	^preferences
]

{ #category : 'accessing' }
RBACProfile >> preferences: anObject [
	"Set the value of the receiver's ''preferences'' instance variable to the argument, anObject."

	preferences := anObject
]

{ #category : 'preferences' }
RBACProfile >> preferencesAt: sectionName [
	| dict |
	dict := Dictionary new.
	dict
		addAll: ( ( self ownOrInheritedPreferences
				select: [ :each | each section = sectionName ] )
					collect: [ :each | each name -> each ] ).
	^ dict
]

{ #category : 'accessing' }
RBACProfile >> profilePreferenceClass [
	^ RBACProfilePreference
]

{ #category : 'private' }
RBACProfile >> profileType [
	"No op for Glorp filtered hierarchy"
]

{ #category : 'private' }
RBACProfile >> profileType: aString [
	"No op for Glorp filtered hierarchy"
]

{ #category : 'roles' }
RBACProfile >> removeAllRoles [
	self roles copy
		do: [ :each | 
			roles remove: each.
			each removeProfile: self ]
]

{ #category : 'roles' }
RBACProfile >> removeRole: aRole [
	self roles remove: aRole.
	aRole onRemovedFromProfile: self
]

{ #category : 'roles' }
RBACProfile >> removeRole: aRole ifAbsent: exceptionBlock [
	^ self roles remove: aRole ifAbsent: exceptionBlock
]

{ #category : 'accessing' }
RBACProfile >> roles [
	roles ifNil: [ self initializeRoles ].
	^ roles
]

{ #category : 'accessing' }
RBACProfile >> roles: aCollection [
	roles := aCollection
]

{ #category : 'roles' }
RBACProfile >> validateRoleAddition: aRole [
	(self canAdd: aRole)
		ifTrue: [ RBACRoleAlreadyAssigned signalWith: aRole ]
]
