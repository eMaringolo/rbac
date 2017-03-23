uncategorized
testAllSubroles

	"Test the allSubroles method."



	self addRoles.

	self 

		assert: (self equalityBetween: (self simpleRoles at: 2) allSubroles and: OrderedCollection new).

	self assert: (self equalityBetween: (self compositeRoles at: 4) allSubroles

				and: (OrderedCollection with: (self simpleRoles at: 3) with: (self simpleRoles at: 4))).

	self assert: (self equalityBetween: (self compositeRoles at: 2) allSubroles

				and: (OrderedCollection 

						with: (self compositeRoles at: 4)

						with: (self simpleRoles at: 3)

						with: (self simpleRoles at: 4)

						with: (self simpleRoles at: 2))).

	self assert: (self equalityBetween: (self compositeRoles at: 1) allSubroles

				and: ((OrderedCollection new)

						add: (self simpleRoles at: 1);

						add: (self compositeRoles at: 2);

						add: (self compositeRoles at: 4);

						add: (self simpleRoles at: 3);

						add: (self simpleRoles at: 4);

						add: (self simpleRoles at: 2);

						yourself))