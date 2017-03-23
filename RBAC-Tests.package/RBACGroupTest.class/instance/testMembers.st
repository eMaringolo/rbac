unit tests
testMembers
	self sampleGroup members: (Set with: (self users at: 1) with: (self users at: 2) with: (self users at: 3)).
	self
		assert: (self sampleGroup members difference: (OrderedCollection with: (self users at: 2) with: (self users at: 1) with: (self users at: 3))) isEmpty.
	self sampleGroup members: (Set with: (self users at: 2)).
	self assert: (self sampleGroup members difference: (Set with: (self users at: 2))) isEmpty.
	self sampleGroup initializeMembers.
	self assert: self sampleGroup members isEmpty