unit tests
testEquals

	"Test the equals: method."

	

	self assert: self sampleGroup = self sampleGroup.

	self assert: (self groups at: 2) = (self groups at: 2).

	self assert: (self groups at: 3) = (self groups at: 3).

	self deny: (self groups at: 3) = (self groups at: 2).

	self deny: (self groups at: 2) = (self groups at: 3).	

	self deny: self sampleGroup = (self groups at: 2).

	self deny: self sampleGroup = (self users at: 2)

