unit tests
testRoles
	| profile |
	profile := self users at: 1.
	profile
		roles:
			(Set
				with: (self simpleRoles at: 1)
				with: (self simpleRoles at: 2)
				with: (self compositeRoles at: 1)).
	self
		assert:
			(profile roles
				difference:
					(OrderedCollection
						with: (self simpleRoles at: 1)
						with: (self simpleRoles at: 2)
						with: (self compositeRoles at: 1))) isEmpty.
	profile roles: Set new.
	self assert: profile roles isEmpty.
	profile roles: (Set with: (self simpleRoles at: 1)).
	self
		assert: (profile roles difference: (OrderedCollection with: (self simpleRoles at: 1))) isEmpty.
	profile initializeRoles.
	self assert: profile roles isEmpty