uncategorized
testPermissionAdditionAndRemoval
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