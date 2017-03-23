uncategorized
testIncludesSystemPermissionFor
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