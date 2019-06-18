"

"
Class {
	#name : 'RBACRoleTest',
	#superclass : 'RBACAbstractRoleTest',
	#vw_namespace : 'Root',
	#category : 'RBAC-Tests'
}

{ #category : 'uncategorized' }
RBACRoleTest >> testAllSubrolesDo [
	"Test the allSubrolesBreadthFirstDo: method."

	| result |
	result := false.
	(self simpleRoles at: 2) allSubrolesDo: [ :each | result := true ].
	self deny: result.
	result := 0.
	(self simpleRoles at: 1) allSubrolesDo: [ :each | result := result + 2 ].
	self assert: result = 0
]

{ #category : 'uncategorized' }
RBACRoleTest >> testCanExecute [
	"Test the canExecute: method."

	| role |
	role := self simpleRoles at: 1.
	self deny: (role canExecute: (self operations at: 1)).
	self deny: (role canExecute: (self operations at: 2)).
	role addPermissionFor: (self operations at: 1).
	role addPermission: (RBACPermission target: (self operations at: 2)).
	self assert: (role canExecute: (self operations at: 1)).
	self deny: (role canExecute: (self operations at: 2)).
	role removePermissionFor: (self operations at: 2).
	role addPermission: ((RBACPermission target: (self operations at: 2)) allowsExecution: true).
	self assert: (role canExecute: (self operations at: 1)).
	self assert: (role canExecute: (self operations at: 2))
]

{ #category : 'uncategorized' }
RBACRoleTest >> testPermissionAddition [
	| role perm perm2 perm3 perm4 menuA |
	menuA := RBACNamedModel new.
	role := self simpleRoles at: 1.
	perm := (RBACPermission target: menuA)
		allowsCreation: true;
		allowsUpdate: true.
	perm2 := (RBACPermission target: menuA)
		allowsCreation: true;
		allowsUpdate: true.
	perm3 := (RBACPermission target: menuA)
		allowsCreation: true;
		allowsDeletion: true.
	perm4 := (RBACPermission target: menuA)
		allowsRead: true;
		allowsDeletion: true.
	role addPermission: perm.
	role addPermission: perm2.
	self assert: (self comparePermission: (role permissionFor: menuA) with: perm2).
	role addPermission: perm3.
	self assert: (self comparePermission: (role permissionFor: menuA) with: (perm2 copy allowsDeletion: true)).
	role addPermission: perm2.
	self assert: (self comparePermission: (role permissionFor: menuA) with: (perm2 copy allowsDeletion: true)).
	role addPermission: perm4.
	self
		assert:
			(self
				comparePermission: (role permissionFor: menuA)
				with:
					((RBACPermission target: menuA)
						allowsCreation: true;
						allowsDeletion: true;
						allowsRead: true;
						allowsUpdate: true))
]

{ #category : 'uncategorized' }
RBACRoleTest >> testPermissionAdditionAndRemoval [
	| role menuA menuB |
	menuA := RBACNamedModel new.
	menuB := RBACNamedModel new.
	(role := self simpleRoles at: 1)
		addPermission: (RBACPermission target: menuA);
		addPermission: (RBACPermission target: menuB).
	self deny: (role permissionFor: menuA) isTransient.
	self deny: (role permissionFor: menuB) isTransient.
	role removePermissionFor: menuA.
	role removePermission: (role permissionFor: menuB).
	self assert: (role permissionFor: menuA) isTransient.
	self assert: (role permissionFor: menuB) isTransient
]
