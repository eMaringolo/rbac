"

"
Class {
	#name : 'RBACProfileTest',
	#superclass : 'RBACTest',
	#instVars : [
		'inferiorEntity',
		'inferiorEntity2',
		'superiorEntity',
		'middleEntity'
	],
	#vw_namespace : 'Root',
	#category : 'RBAC-Tests'
}

{ #category : 'uncategorized' }
RBACProfileTest class >> isAbstract [
	^ self name = #RBACProfileTest
]

{ #category : 'configuration' }
RBACProfileTest >> classToTest [
	self shouldBeImplemented.
]

{ #category : 'instantiation' }
RBACProfileTest >> profile1 [

	^self classToTest new
]

{ #category : 'instantiation' }
RBACProfileTest >> profile2 [

	^self classToTest new
]

{ #category : 'unit tests' }
RBACProfileTest >> testHasRole [

	| samProfile |
	samProfile := self profile1.
	samProfile roles: (Set with: (self compositeRoles at: 2)).
	(self compositeRoles at: 1)
		subroles: (Set with: (self simpleRoles at: 1) with: (self compositeRoles at: 2)).
	(self compositeRoles at: 2)
		subroles: (Set with: (self simpleRoles at: 2) with: (self compositeRoles at: 4)).
	(self compositeRoles at: 4)
		subroles: (Set with: (self simpleRoles at: 3) with: (self simpleRoles at: 4)).
	self deny: (samProfile hasRole: (self simpleRoles at: 5)).
	samProfile addRole: (self compositeRoles at: 3).
	(self compositeRoles at: 3) subroles: (Set with: (self simpleRoles at: 5)).
	self assert: (samProfile hasRole: (self simpleRoles at: 2)).
	self assert: (samProfile hasRole: (self simpleRoles at: 3)).
	self assert: (samProfile hasRole: (self compositeRoles at: 4)).
	self deny: (samProfile hasRole: (self simpleRoles at: 1)).
	self deny: (samProfile hasRole: (self compositeRoles at: 1)).
	self assert: (samProfile hasRole: (self simpleRoles at: 5))
]

{ #category : 'unit tests' }
RBACProfileTest >> testPermissions [
	"Test the addition of roles to the user."

	| profile crud1 crud2 crud3 target1 target2 |
	profile := self profile1.
	profile
		addRole: (self simpleRoles at: 1);
		addRole: (self compositeRoles at: 1).
	target1 := Object new.
	target2 := Object new.
	(self compositeRoles at: 1) addRole: (self simpleRoles at: 2).
	crud1 := (RBACPermission target: target1)
		allowsCreation: true;
		allowsUpdate: true;
		yourself.
	crud2 := (RBACPermission target: target2)
		allowsCreation: true;
		allowsRead: true;
		yourself.
	crud3 := (RBACPermission target: target1)
		allowsDeletion: true;
		yourself.
	(self simpleRoles at: 1)
		addPermission: crud1;
		addPermission: crud2.
	(self simpleRoles at: 2) addPermission: crud3.
	self assert: (profile canCreate: target1).
	self assert: (profile canUpdate: target1).
	self assert: (profile canDelete: target1).
	self assert: (profile canCreate: target2).
	self assert: (profile canRead: target2)
]

{ #category : 'unit tests' }
RBACProfileTest >> testRemoveRoleIfAbsent [

	| samProfile temp |
	samProfile := self profile1.
	samProfile roles: (Set with: (self simpleRoles at: 1) with: (self compositeRoles at: 1)).
	self
		should: [ samProfile removeRole: (self simpleRoles at: 3) ifAbsent: [ NotFound signalFor: (self simpleRoles at: 3) ] ]
		raise: NotFound.
	self shouldnt: [ samProfile removeRole: (self simpleRoles at: 2) ifAbsent: [ temp := 3 ] ] raise: NotFound.
	self assert: temp = 3.
	self shouldnt: [ samProfile removeRole: (self simpleRoles at: 2) ifAbsent: [  ] ] raise: NotFound
]

{ #category : 'unit tests' }
RBACProfileTest >> testRoleAdditionAndRemotion [
	"Test the addition and remotion of roles to the user."

	| samProfile |
	samProfile := self profile1.
	samProfile addRole: (self simpleRoles at: 1).
	self assert: samProfile roles = (Set with: (self simpleRoles at: 1)).
	samProfile addRole: (self compositeRoles at: 1).
	self assert: samProfile roles = (Set with: (self simpleRoles at: 1) with: (self compositeRoles at: 1)).
	samProfile removeRole: (self simpleRoles at: 1).
	self should: [ samProfile removeRole: (self simpleRoles at: 1) ] raise: NotFoundError.
	self assert: samProfile roles = (Set with: (self compositeRoles at: 1)).
	samProfile addRole: (self simpleRoles at: 2).
	self assert: samProfile roles = (Set with: (self compositeRoles at: 1) with: (self simpleRoles at: 2)).
	self should: [ samProfile removeRole: (self simpleRoles at: 3) ] raise: NotFoundError.
	samProfile removeAllRoles.
	self assert: samProfile roles isEmpty
]

{ #category : 'unit tests' }
RBACProfileTest >> testRoles [
	| profile |
	profile := self users at: 1.
	profile
		roles:
			(Set
				with: (self simpleRoles at: 1)
				with: (self simpleRoles at: 2)
				with: (self compositeRoles at: 1)).
	self
		assert:
			(profile roles
				difference:
					(OrderedCollection
						with: (self simpleRoles at: 1)
						with: (self simpleRoles at: 2)
						with: (self compositeRoles at: 1))) isEmpty.
	profile roles: Set new.
	self assert: profile roles isEmpty.
	profile roles: (Set with: (self simpleRoles at: 1)).
	self
		assert: (profile roles difference: (OrderedCollection with: (self simpleRoles at: 1))) isEmpty.
	profile initializeRoles.
	self assert: profile roles isEmpty
]
