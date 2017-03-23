uncategorized
testRecursiveRoleAdditionValidation

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