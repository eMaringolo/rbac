"

"
Class {
	#name : 'RBACCompositeRoleTest',
	#superclass : 'RBACAbstractRoleTest',
	#vw_namespace : 'Root',
	#category : 'RBAC-Tests'
}

{ #category : 'uncategorized' }
RBACCompositeRoleTest >> hasTheSameCRUDPermissions: aCollection than: anotherCollection [ 

	"Private - Answer true if aCollection has the same CRUDPermissions than anotherCollection not necessarily at the same order."



	aCollection size = anotherCollection size ifFalse: [^false].

	aCollection do: [:each | (self isIncluded: each in: anotherCollection) ifFalse: [^false]].

	^true
]

{ #category : 'uncategorized' }
RBACCompositeRoleTest >> isIncluded: aCRUDPermission in: aCollection [ 

	"Private - Answer true if aCRUDPermission is included in aCollection."



	^(aCollection detect: [:one | self comparePermission: one with: aCRUDPermission] ifNone: []) notNil
]

{ #category : 'uncategorized' }
RBACCompositeRoleTest >> orderByRoleAndOperation: aCollection [ 

	"Private - Order aCollection (that contains system permissions) by role and then by operation."



	^aCollection asSortedCollection: 

			[:a :b | 

			a role id < b role id | (a role id = b role id & (a operation id < b operation id))]
]

{ #category : 'uncategorized' }
RBACCompositeRoleTest >> testAllSubrolesDo [
	super testAllSubrolesDo
]

{ #category : 'uncategorized' }
RBACCompositeRoleTest >> testCanExecute [
	| role role2 role3 compositeRole |
	role := RBACRole new.
	role2 := RBACRole new.
	role3 := RBACRole new.
	compositeRole := RBACCompositeRole new
		addRole: role;
		addRole: role2;
		addRole: role3.
	role addPermissionFor: (self operations at: 1).
	role2 addPermissionFor: (self operations at: 2).
	role3 addPermissionFor: (self operations at: 3).
	self assert: (compositeRole canExecute: (self operations at: 1)).
	self assert: (compositeRole canExecute: (self operations at: 2)).
	self assert: (compositeRole canExecute: (self operations at: 3)).
	self deny: (compositeRole canExecute: (self operations at: 4))
]

{ #category : 'uncategorized' }
RBACCompositeRoleTest >> testPermissions [
	| sysop sysop2 sysop3 sysop4 sysop5 sysop6 sysop7 |
	self addRoles.
	sysop := RBACPermission role: (self simpleRoles at: 1) target: (self operations at: 1).
	sysop2 := RBACPermission role: (self simpleRoles at: 1) target: (self operations at: 2).
	sysop3 := RBACPermission role: (self simpleRoles at: 2) target: (self operations at: 1).
	sysop4 := RBACPermission role: (self simpleRoles at: 2) target: (self operations at: 2).
	sysop5 := RBACPermission role: (self simpleRoles at: 3) target: (self operations at: 1).
	sysop6 := RBACPermission role: (self simpleRoles at: 3) target: (self operations at: 2).
	sysop7 := RBACPermission role: (self simpleRoles at: 4) target: (self operations at: 2).
	(self simpleRoles at: 1) permissions: (Set with: sysop with: sysop2).
	(self simpleRoles at: 2) permissions: (Set with: sysop3 with: sysop4).
	(self simpleRoles at: 3) permissions: (Set with: sysop5 with: sysop6).
	(self simpleRoles at: 4) permissions: (Set with: sysop7).
	self
		assert:
			(self
				equalityBetween: (self compositeRoles at: 1) permissions
				and:
					(Set new
						add: sysop;
						add: sysop2;
						add: sysop3;
						add: sysop4;
						add: sysop5;
						add: sysop6;
						add: sysop7;
						yourself)).
	self
		assert:
			(self
				equalityBetween: (self compositeRoles at: 2) permissions
				and:
					(Set new
						add: sysop3;
						add: sysop4;
						add: sysop5;
						add: sysop6;
						add: sysop7;
						yourself)).
	self assert: (self equalityBetween: (self compositeRoles at: 3) permissions and: Set new).
	self assert: (self equalityBetween: (self compositeRoles at: 4) permissions and: (Set with: sysop5 with: sysop6 with: sysop7))
]

{ #category : 'uncategorized' }
RBACCompositeRoleTest >> testRemoveRoles [
	self addRoles.
	(self compositeRoles at: 1) removeAllSubroles.
	(self compositeRoles at: 2) removeRole: (self compositeRoles at: 4).
	(self compositeRoles at: 4) removeRole: (self simpleRoles at: 4).
	self assert: (self compositeRoles at: 1) subroles isEmpty.
	self
		assert:
			(self
				equalityBetween: (self compositeRoles at: 2) subroles
				and: (OrderedCollection with: (self simpleRoles at: 2))).
	self
		assert:
			(self
				equalityBetween: (self compositeRoles at: 4) subroles
				and: (OrderedCollection with: (self simpleRoles at: 3))).
	(self compositeRoles at: 4) removeRole: (self simpleRoles at: 3).
	self assert: (self compositeRoles at: 4) subroles isEmpty
]

{ #category : 'uncategorized' }
RBACCompositeRoleTest >> testSubroles [
	self addRoles.
	self
		assert: (self equalityBetween: (self compositeRoles at: 4) subroles and: (Set with: (self simpleRoles at: 3) with: (self simpleRoles at: 4))).
	self
		assert: (self equalityBetween: (self compositeRoles at: 2) subroles and: (Set with: (self compositeRoles at: 4) with: (self simpleRoles at: 2))).
	self
		assert:
			(self
				equalityBetween: (self compositeRoles at: 1) allSubroles
				and:
					(Set new
						add: (self simpleRoles at: 1);
						add: (self compositeRoles at: 2);
						add: (self compositeRoles at: 4);
						add: (self simpleRoles at: 3);
						add: (self simpleRoles at: 4);
						add: (self simpleRoles at: 2);
						yourself)).
	(self compositeRoles at: 4) subroles: (Set with: (self compositeRoles at: 3) with: (self simpleRoles at: 2)).
	self
		assert: (self equalityBetween: (self compositeRoles at: 4) subroles and: (Set with: (self compositeRoles at: 3) with: (self simpleRoles at: 2))).
	(self compositeRoles at: 4) subroles: nil.
	self assert: (self equalityBetween: (self compositeRoles at: 4) subroles and: Set new)
]

{ #category : 'uncategorized' }
RBACCompositeRoleTest >> testvalidateRoleAddition [

	"Test the validateRoleAddition: method."



	self addRoles.

	self should: [(self compositeRoles at: 1) validateRoleAddition: (self compositeRoles at: 2)]

		raise: RBACRoleAlreadyAssigned.

	self should: [(self compositeRoles at: 1) validateRoleAddition: (self compositeRoles at: 4)]

		raise: RBACRoleAlreadyAssigned.

	self should: [(self compositeRoles at: 2) validateRoleAddition: (self simpleRoles at: 3)]

		raise: RBACRoleAlreadyAssigned.

	self should: [(self compositeRoles at: 1) validateRoleAddition: (self simpleRoles at: 4)]

		raise: RBACRoleAlreadyAssigned.

	self should: [(self compositeRoles at: 4) validateRoleAddition: (self compositeRoles at: 1)]

		raise: RBACRoleRecursion.

	self should: [(self compositeRoles at: 4) validateRoleAddition: (self compositeRoles at: 2)]

		raise: RBACRoleRecursion.

	self should: [(self compositeRoles at: 2) validateRoleAddition: (self compositeRoles at: 1)]

		raise: RBACRoleRecursion.

	self should: [(self compositeRoles at: 1) validateRoleAddition: (self compositeRoles at: 1)]

		raise: RBACSameRole.

	self should: [(self compositeRoles at: 2) validateRoleAddition: (self compositeRoles at: 2)]

		raise: RBACSameRole.

	self shouldnt: [(self compositeRoles at: 1) validateRoleAddition: (self compositeRoles at: 3)]

		raise: RBACRoleError.

	self shouldnt: [(self compositeRoles at: 2) validateRoleAddition: (self compositeRoles at: 5)]

		raise: RBACRoleError.

	self shouldnt: [(self compositeRoles at: 4) validateRoleAddition: (self simpleRoles at: 5)]

		raise: RBACRoleError.

	self shouldnt: [(self compositeRoles at: 5) validateRoleAddition: (self simpleRoles at: 2)]

		raise: RBACRoleError
]
