uncategorized
testPermissions
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
					(Set
						with: sysop3
						with: sysop4
						with: sysop5
						with: sysop6
						with: sysop7)).
	self assert: (self equalityBetween: (self compositeRoles at: 3) permissions and: Set new).
	self assert: (self equalityBetween: (self compositeRoles at: 4) permissions and: (Set with: sysop5 with: sysop6 with: sysop7))