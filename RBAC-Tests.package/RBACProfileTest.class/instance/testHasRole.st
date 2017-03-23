unit tests
testHasRole

	| samProfile |
	samProfile := self profile1.
	samProfile roles: (Set with: (self compositeRoles at: 2)).
	(self compositeRoles at: 1)
		subroles: (Set with: (self simpleRoles at: 1) with: (self compositeRoles at: 2)).
	(self compositeRoles at: 2)
		subroles: (Set with: (self simpleRoles at: 2) with: (self compositeRoles at: 4)).
	(self compositeRoles at: 4)
		subroles: (Set with: (self simpleRoles at: 3) with: (self simpleRoles at: 4)).
	self deny: (samProfile hasRole: (self simpleRoles at: 5)).
	samProfile addRole: (self compositeRoles at: 3).
	(self compositeRoles at: 3) subroles: (Set with: (self simpleRoles at: 5)).
	self assert: (samProfile hasRole: (self simpleRoles at: 2)).
	self assert: (samProfile hasRole: (self simpleRoles at: 3)).
	self assert: (samProfile hasRole: (self compositeRoles at: 4)).
	self deny: (samProfile hasRole: (self simpleRoles at: 1)).
	self deny: (samProfile hasRole: (self compositeRoles at: 1)).
	self assert: (samProfile hasRole: (self simpleRoles at: 5))