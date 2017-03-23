uncategorized
testCRUDPermissionTransitivity
	| role perm target |
	target := RBACNamedModel new.
	(role := self simpleRoles at: 1) addPermission: (perm := RBACPermission target: target).
	perm allowsUpdate: true.
	self deny: (role permissionFor: target) isTransient.
	(self compositeRoles at: 1) addRole: role.
	self assert: ((self compositeRoles at: 1) permissionFor: target) isTransient.
	self assert: ((self compositeRoles at: 1) permissionFor: target) allowsUpdate