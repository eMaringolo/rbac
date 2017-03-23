uncategorized
addRoles
	(self compositeRoles at: 1)
		addRole: (self simpleRoles at: 1);
		addRole: (self compositeRoles at: 2).
	(self compositeRoles at: 2)
		addRole: (self compositeRoles at: 4);
		addRole: (self simpleRoles at: 2).
	(self compositeRoles at: 4)
		addRole: (self simpleRoles at: 3);
		addRole: (self simpleRoles at: 4)