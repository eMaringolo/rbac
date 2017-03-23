unit tests
testAdditionRemotionAndInclusionOfMembers
	"Test addMember: , removeAllMembers , removeMember: and includesMember: methods."

	self sampleGroup initializeMembers.
	self deny: (self sampleGroup includesMember: (self users at: 1)).
	self deny: (self sampleGroup includesMember: (self users at: 2)).
	self sampleGroup addMember: (self users at: 1).
	self assert: (self sampleGroup includesMember: (self users at: 1)).
	self deny: (self sampleGroup includesMember: (self users at: 2)).
	self sampleGroup addMember: (self users at: 2).
	self assert: (self sampleGroup includesMember: (self users at: 1)).
	self assert: (self sampleGroup includesMember: (self users at: 2)).
	self sampleGroup removeMember: (self users at: 1).
	self deny: (self sampleGroup includesMember: (self users at: 1)).
	self assert: (self sampleGroup includesMember: (self users at: 2)).
	self sampleGroup addMember: (self users at: 3).
	self assert: (self sampleGroup includesMember: (self users at: 3)).
	self sampleGroup removeAllMembers.
	self deny: (self sampleGroup includesMember: (self users at: 1)).
	self deny: (self sampleGroup includesMember: (self users at: 2)).
	self deny: (self sampleGroup includesMember: (self users at: 3))