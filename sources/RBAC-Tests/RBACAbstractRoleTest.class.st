"

"
Class {
	#name : 'RBACAbstractRoleTest',
	#superclass : 'RBACTest',
	#vw_namespace : 'Root',
	#category : 'RBAC-Tests'
}

{ #category : 'as yet unclassified' }
RBACAbstractRoleTest class >> isAbstract [

	^self name = #RBACAbstractRoleTest
]

{ #category : 'uncategorized' }
RBACAbstractRoleTest >> addRoles [
	(self compositeRoles at: 1)
		addRole: (self simpleRoles at: 1);
		addRole: (self compositeRoles at: 2).
	(self compositeRoles at: 2)
		addRole: (self compositeRoles at: 4);
		addRole: (self simpleRoles at: 2).
	(self compositeRoles at: 4)
		addRole: (self simpleRoles at: 3);
		addRole: (self simpleRoles at: 4)
]

{ #category : 'uncategorized' }
RBACAbstractRoleTest >> comparePermission: perm with: comparandPerm [
	^(perm target = comparandPerm target) & (perm bits = comparandPerm bits)
]

{ #category : 'uncategorized' }
RBACAbstractRoleTest >> crudPermissionsEqualityBetween: aCollection and: anotherCollection [ 

	"Private - Answer true if aCollection is equal to anotherCollection."



	aCollection size = anotherCollection size ifFalse: [^false].

	aCollection with: anotherCollection

		do: [:sysop :sysop2 | (self comparePermission: sysop with: sysop2) ifFalse: [^false]].

	^true
]

{ #category : 'uncategorized' }
RBACAbstractRoleTest >> equalityBetween: aCollection and: anotherCollection [
	aCollection size = anotherCollection size
		ifFalse: [ ^ false ].
	aCollection
		do: [ :each | 
			(anotherCollection includes: each)
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : 'uncategorized' }
RBACAbstractRoleTest >> systemPermissionEqualityBetween: aSystemPermission and: anotherSystemPermission [ 

	"Private - Answer true if aSystemPermission is equal to anotherSystemPermission."



	^(aSystemPermission role equals: anotherSystemPermission role) 

		& (aSystemPermission operation = anotherSystemPermission operation)
]

{ #category : 'uncategorized' }
RBACAbstractRoleTest >> systemPermissionsEqualityBetween: aCollection and: anotherCollection [ 

	"Private - Answer true if aCollection is equal to anotherCollection."



	aCollection size = anotherCollection size ifFalse: [^false].

	aCollection do: [:sysop | anotherCollection detect: [:sysop2 | (self systemPermissionEqualityBetween: sysop and: sysop2)] ifNone: [^false]].

	^true
]

{ #category : 'uncategorized' }
RBACAbstractRoleTest >> testAllSubroles [

	"Test the allSubroles method."



	self addRoles.

	self 

		assert: (self equalityBetween: (self simpleRoles at: 2) allSubroles and: OrderedCollection new).

	self assert: (self equalityBetween: (self compositeRoles at: 4) allSubroles

				and: (OrderedCollection with: (self simpleRoles at: 3) with: (self simpleRoles at: 4))).

	self assert: (self equalityBetween: (self compositeRoles at: 2) allSubroles

				and: (OrderedCollection 

						with: (self compositeRoles at: 4)

						with: (self simpleRoles at: 3)

						with: (self simpleRoles at: 4)

						with: (self simpleRoles at: 2))).

	self assert: (self equalityBetween: (self compositeRoles at: 1) allSubroles

				and: ((OrderedCollection new)

						add: (self simpleRoles at: 1);

						add: (self compositeRoles at: 2);

						add: (self compositeRoles at: 4);

						add: (self simpleRoles at: 3);

						add: (self simpleRoles at: 4);

						add: (self simpleRoles at: 2);

						yourself))
]

{ #category : 'uncategorized' }
RBACAbstractRoleTest >> testAllSubrolesDo [
	| result |
	self addRoles.
	result := Set new.
	(self compositeRoles at: 4) allSubrolesDo: [ :each | result add: each ].
	self assert: result = (Set with: (self simpleRoles at: 3) with: (self simpleRoles at: 4)).
	result := OrderedCollection new.
	(self compositeRoles at: 2)
		allSubrolesDo: [ :each | 
			each = (self simpleRoles at: 4)
				ifFalse: [ result add: each ] ].
	self
		assert:
			(result includesAll:
				(OrderedCollection with: (self compositeRoles at: 4) with: (self simpleRoles at: 3) with: (self simpleRoles at: 2))).
	result := false.
	(self compositeRoles at: 1)
		allSubrolesDo: [ :each | 
			each = (self simpleRoles at: 1)
				ifTrue: [ result := true ] ].
	self assert: result.
	result := false.
	(self compositeRoles at: 2)
		allSubrolesDo: [ :each | 
			each = (self simpleRoles at: 1)
				ifTrue: [ result := true ] ].
	self deny: result
]

{ #category : 'uncategorized' }
RBACAbstractRoleTest >> testCRUDPermissionTransitivity [
	| role perm target |
	target := RBACNamedModel new.
	(role := self simpleRoles at: 1) addPermission: (perm := RBACPermission target: target).
	perm allowsUpdate: true.
	self deny: (role permissionFor: target) isTransient.
	(self compositeRoles at: 1) addRole: role.
	self assert: ((self compositeRoles at: 1) permissionFor: target) isTransient.
	self assert: ((self compositeRoles at: 1) permissionFor: target) allowsUpdate
]

{ #category : 'uncategorized' }
RBACAbstractRoleTest >> testDescription [
	"Test the description and description: methods."

	| singleRole compositeRole |
	singleRole := self simpleRoles at: 1.
	compositeRole := self compositeRoles at: 3.
	singleRole description: 'This is a role'.
	compositeRole description: 'This is another role'.
	self assert: singleRole description = 'This is a role'.
	self assert: compositeRole description = 'This is another role'
]

{ #category : 'uncategorized' }
RBACAbstractRoleTest >> testEquals [

	"Test the equals: method."



	self assert: ((self compositeRoles at: 1) equals: (self compositeRoles at: 1)).

	self assert: ((self compositeRoles at: 2) equals: (self compositeRoles at: 2)).

	self assert: ((self compositeRoles at: 3) equals: (self compositeRoles at: 3)).

	self assert: ((self compositeRoles at: 4) equals: (self compositeRoles at: 4)).

	self assert: ((self simpleRoles at: 1) equals: (self simpleRoles at: 1)).

	self assert: ((self simpleRoles at: 2) equals: (self simpleRoles at: 2)).

	self assert: ((self simpleRoles at: 3) equals: (self simpleRoles at: 3)).

	self assert: ((self simpleRoles at: 4) equals: (self simpleRoles at: 4)).

	self deny: ((self compositeRoles at: 1) equals: (self compositeRoles at: 2)).

	self deny: ((self compositeRoles at: 3) equals: (self compositeRoles at: 4)).

	self deny: ((self compositeRoles at: 4) equals: (self compositeRoles at: 3)).

	self deny: ((self compositeRoles at: 4) equals: (self simpleRoles at: 4)).

	self deny: ((self simpleRoles at: 1) equals: (self compositeRoles at: 2)).

	self deny: ((self simpleRoles at: 2) equals: (self compositeRoles at: 3)).

	self deny: ((self simpleRoles at: 3) equals: (self simpleRoles at: 2)).

	self deny: ((self simpleRoles at: 4) equals: (self simpleRoles at: 1))
]

{ #category : 'uncategorized' }
RBACAbstractRoleTest >> testIncludesRole [
	self addRoles.
	self assert: ((self compositeRoles at: 1) containsRole: (self simpleRoles at: 1)).
	self assert: ((self compositeRoles at: 2) containsRole: (self simpleRoles at: 2)).
	self assert: ((self compositeRoles at: 2) containsRole: (self compositeRoles at: 4)).
	self assert: ((self compositeRoles at: 4) containsRole: (self simpleRoles at: 3)).
	self assert: ((self compositeRoles at: 4) containsRole: (self simpleRoles at: 4)).

	self assert: ((self compositeRoles at: 1) containsRole: (self simpleRoles at: 3)).
	self assert: ((self compositeRoles at: 1) containsRole: (self simpleRoles at: 4)).
	self assert: ((self compositeRoles at: 1) containsRole: (self compositeRoles at: 4)).
	self assert: ((self compositeRoles at: 2) containsRole: (self simpleRoles at: 3)).



	"Equality between simple roles"
	self assert: ((self simpleRoles at: 1) containsRole: (self simpleRoles at: 1)).
	self assert: ((self simpleRoles at: 4) containsRole: (self simpleRoles at: 4)).



	"No inclusion"
	self deny: ((self simpleRoles at: 1) containsRole: (self simpleRoles at: 2)).
	self deny: ((self simpleRoles at: 2) containsRole: (self simpleRoles at: 3)).
	self deny: ((self simpleRoles at: 2) containsRole: (self compositeRoles at: 1)).
	self deny: ((self simpleRoles at: 2) containsRole: (self compositeRoles at: 4)).
	self deny: ((self simpleRoles at: 3) containsRole: (self compositeRoles at: 3)).
	self deny: ((self compositeRoles at: 4) containsRole: (self compositeRoles at: 2)).
	self deny: ((self compositeRoles at: 4) containsRole: (self compositeRoles at: 1)).
	self deny: ((self compositeRoles at: 3) containsRole: (self compositeRoles at: 4)).
	self deny: ((self compositeRoles at: 3) containsRole: (self simpleRoles at: 4)).
	self deny: ((self compositeRoles at: 2) containsRole: (self simpleRoles at: 1)).
	self deny: ((self compositeRoles at: 1) containsRole: (self simpleRoles at: 5)).
	self deny: ((self compositeRoles at: 4) containsRole: (self simpleRoles at: 1))
]

{ #category : 'uncategorized' }
RBACAbstractRoleTest >> testIncludesSystemPermissionFor [
	"Test the includesSystemPermissionFor: method."

	| sysop sysop2 sysop3 sysop4 |
	self addRoles.
	sysop := RBACPermission role: (self simpleRoles at: 1) target: (self operations at: 1).
	sysop2 := RBACPermission role: (self simpleRoles at: 2) target: (self operations at: 1).
	sysop3 := RBACPermission role: (self simpleRoles at: 3) target: (self operations at: 2).
	sysop4 := RBACPermission role: (self simpleRoles at: 4) target: (self operations at: 2).
	(self simpleRoles at: 1) permissions: (Set with: sysop).
	(self simpleRoles at: 2) permissions: (Set with: sysop2).
	(self simpleRoles at: 3) permissions: (Set with: sysop3 with: sysop4).
	(self simpleRoles at: 4) permissions: Set new.
	self
		assert: ((self simpleRoles at: 1) hasPermissionFor: (self operations at: 1)).
	self
		deny: ((self simpleRoles at: 1) hasPermissionFor: (self operations at: 2)).
	self
		deny: ((self simpleRoles at: 3) hasPermissionFor: (self operations at: 1)).
	self
		assert: ((self simpleRoles at: 3) hasPermissionFor: (self operations at: 2)).
	self
		deny: ((self simpleRoles at: 4) hasPermissionFor: (self operations at: 1)).
	self
		deny: ((self simpleRoles at: 4) hasPermissionFor: (self operations at: 2)).
	self
		assert: ((self compositeRoles at: 1) hasPermissionFor: (self operations at: 1)).
	self
		assert: ((self compositeRoles at: 1) hasPermissionFor: (self operations at: 2)).
	self
		assert: ((self compositeRoles at: 2) hasPermissionFor: (self operations at: 1)).
	self
		assert: ((self compositeRoles at: 2) hasPermissionFor: (self operations at: 2)).
	self
		deny: ((self compositeRoles at: 3) hasPermissionFor: (self operations at: 1)).
	self
		deny: ((self compositeRoles at: 3) hasPermissionFor: (self operations at: 2)).
	self
		deny: ((self compositeRoles at: 4) hasPermissionFor: (self operations at: 1)).
	self
		assert: ((self compositeRoles at: 4) hasPermissionFor: (self operations at: 2))
]

{ #category : 'uncategorized' }
RBACAbstractRoleTest >> testIsComposite [

	"Test the isComposite method."



	self assert: (self compositeRoles at: 1) isComposite.

	self assert: (self compositeRoles at: 2) isComposite.

	self assert: (self compositeRoles at: 3) isComposite.

	self assert: (self compositeRoles at: 4) isComposite.

	self deny: (self simpleRoles at: 1) isComposite.

	self deny: (self simpleRoles at: 2) isComposite.

	self deny: (self simpleRoles at: 3) isComposite.

	self deny: (self simpleRoles at: 4) isComposite
]

{ #category : 'uncategorized' }
RBACAbstractRoleTest >> testRecursiveRoleAdditionValidation [

	(self compositeRoles at: 1)

		addRole: (self simpleRoles at: 1);

		addRole: (self compositeRoles at: 3).

	(self compositeRoles at: 3)

		addRole: (self simpleRoles at: 5);

		addRole: (self simpleRoles at: 3).

	(self compositeRoles at: 5) addRole: (self compositeRoles at: 3).

	self should: [(self compositeRoles at: 3) addRole: (self compositeRoles at: 5)]

		raise: RBACRoleRecursion.

	self should: [(self compositeRoles at: 3) addRole: (self compositeRoles at: 3)] raise: RBACSameRole.

	self should: [(self compositeRoles at: 1) addRole: (self simpleRoles at: 1)]

		raise: RBACRoleAlreadyAssigned
]

{ #category : 'uncategorized' }
RBACAbstractRoleTest >> testSystemPermissionAddition [
	| role |
	(role := self simpleRoles at: 1) addPermissionFor: (self operations at: 1).
	self assert: (role canExecute: (self operations at: 1)).
	(self compositeRoles at: 1) addRole: role.
	self assert: ((self compositeRoles at: 1) canExecute: self operations first)
]

{ #category : 'uncategorized' }
RBACAbstractRoleTest >> testWithAllSubroles [

	"Test the withAllSubroles method."



	self addRoles.

	self assert: (self equalityBetween: (self simpleRoles at: 2) withAllSubroles

				and: (OrderedCollection with: (self simpleRoles at: 2))).

	self assert: (self equalityBetween: (self compositeRoles at: 4) withAllSubroles

				and: (OrderedCollection 

						with: (self compositeRoles at: 4)

						with: (self simpleRoles at: 3)

						with: (self simpleRoles at: 4))).

	self assert: (self equalityBetween: (self compositeRoles at: 2) withAllSubroles

				and: (OrderedCollection new

						add: (self compositeRoles at: 2);

						add: (self compositeRoles at: 4);

						add: (self simpleRoles at: 3);

						add: (self simpleRoles at: 4);

						add: (self simpleRoles at: 2);
						yourself)).

	self assert: (self equalityBetween: (self compositeRoles at: 1) withAllSubroles

				and: ((OrderedCollection new)

						add: (self compositeRoles at: 1);

						add: (self simpleRoles at: 1);

						add: (self compositeRoles at: 2);

						add: (self compositeRoles at: 4);

						add: (self simpleRoles at: 3);

						add: (self simpleRoles at: 4);

						add: (self simpleRoles at: 2);

						yourself))
]
