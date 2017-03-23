uncategorized
testSubroles
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