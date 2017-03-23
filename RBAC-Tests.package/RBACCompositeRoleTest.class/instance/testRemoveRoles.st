uncategorized
testRemoveRoles
	self addRoles.
	(self compositeRoles at: 1) removeAllSubroles.
	(self compositeRoles at: 2) removeRole: (self compositeRoles at: 4).
	(self compositeRoles at: 4) removeRole: (self simpleRoles at: 4).
	self assert: (self compositeRoles at: 1) subroles isEmpty.
	self
		assert:
			(self
				equalityBetween: (self compositeRoles at: 2) subroles
				and: (OrderedCollection with: (self simpleRoles at: 2))).
	self
		assert:
			(self
				equalityBetween: (self compositeRoles at: 4) subroles
				and: (OrderedCollection with: (self simpleRoles at: 3))).
	(self compositeRoles at: 4) removeRole: (self simpleRoles at: 3).
	self assert: (self compositeRoles at: 4) subroles isEmpty