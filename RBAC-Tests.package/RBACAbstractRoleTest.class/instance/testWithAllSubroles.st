uncategorized
testWithAllSubroles
	"Test the withAllSubroles method."

	self addRoles.
	self
		assert:
			(self
				equalityBetween: (self simpleRoles at: 2) withAllSubroles
				and: (OrderedCollection with: (self simpleRoles at: 2))).
	self
		assert:
			(self
				equalityBetween: (self compositeRoles at: 4) withAllSubroles
				and:
					(OrderedCollection
						with: (self compositeRoles at: 4)
						with: (self simpleRoles at: 3)
						with: (self simpleRoles at: 4))).
	self
		assert:
			(self
				equalityBetween: (self compositeRoles at: 2) withAllSubroles
				and:
					(OrderedCollection new
						add: (self compositeRoles at: 2);
						add: (self compositeRoles at: 4);
						add: (self simpleRoles at: 3);
						add: (self simpleRoles at: 4);
						add: (self simpleRoles at: 2);
						yourself)).
	self
		assert:
			(self
				equalityBetween: (self compositeRoles at: 1) withAllSubroles
				and:
					(OrderedCollection new
						add: (self compositeRoles at: 1);
						add: (self simpleRoles at: 1);
						add: (self compositeRoles at: 2);
						add: (self compositeRoles at: 4);
						add: (self simpleRoles at: 3);
						add: (self simpleRoles at: 4);
						add: (self simpleRoles at: 2);
						yourself))