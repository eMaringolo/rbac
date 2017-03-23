unit tests
testRemoveRoleIfAbsent

	| samProfile temp |
	samProfile := self profile1.
	samProfile roles: (Set with: (self simpleRoles at: 1) with: (self compositeRoles at: 1)).
	self
		should: [ samProfile removeRole: (self simpleRoles at: 3) ifAbsent: [ NotFound signalFor: (self simpleRoles at: 3) ] ]
		raise: NotFound.
	self shouldnt: [ samProfile removeRole: (self simpleRoles at: 2) ifAbsent: [ temp := 3 ] ] raise: NotFound.
	self assert: temp = 3.
	self shouldnt: [ samProfile removeRole: (self simpleRoles at: 2) ifAbsent: [  ] ] raise: NotFound