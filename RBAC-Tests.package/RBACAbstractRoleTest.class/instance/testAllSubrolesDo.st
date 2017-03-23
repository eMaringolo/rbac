uncategorized
testAllSubrolesDo
	| result |
	self addRoles.
	result := Set new.
	(self compositeRoles at: 4) allSubrolesDo: [ :each | result add: each ].
	self assert: result = (Set with: (self simpleRoles at: 3) with: (self simpleRoles at: 4)).
	result := OrderedCollection new.
	(self compositeRoles at: 2)
		allSubrolesDo: [ :each | 
			each = (self simpleRoles at: 4)
				ifFalse: [ result add: each ] ].
	self
		assert:
			(result includesAll:
				(OrderedCollection with: (self compositeRoles at: 4) with: (self simpleRoles at: 3) with: (self simpleRoles at: 2))).
	result := false.
	(self compositeRoles at: 1)
		allSubrolesDo: [ :each | 
			each = (self simpleRoles at: 1)
				ifTrue: [ result := true ] ].
	self assert: result.
	result := false.
	(self compositeRoles at: 2)
		allSubrolesDo: [ :each | 
			each = (self simpleRoles at: 1)
				ifTrue: [ result := true ] ].
	self deny: result