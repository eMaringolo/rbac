uncategorized
testPermissionAddition
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