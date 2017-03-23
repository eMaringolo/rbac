uncategorized
testEquals

	"Test the equals: method."



	self assert: ((self compositeRoles at: 1) equals: (self compositeRoles at: 1)).

	self assert: ((self compositeRoles at: 2) equals: (self compositeRoles at: 2)).

	self assert: ((self compositeRoles at: 3) equals: (self compositeRoles at: 3)).

	self assert: ((self compositeRoles at: 4) equals: (self compositeRoles at: 4)).

	self assert: ((self simpleRoles at: 1) equals: (self simpleRoles at: 1)).

	self assert: ((self simpleRoles at: 2) equals: (self simpleRoles at: 2)).

	self assert: ((self simpleRoles at: 3) equals: (self simpleRoles at: 3)).

	self assert: ((self simpleRoles at: 4) equals: (self simpleRoles at: 4)).

	self deny: ((self compositeRoles at: 1) equals: (self compositeRoles at: 2)).

	self deny: ((self compositeRoles at: 3) equals: (self compositeRoles at: 4)).

	self deny: ((self compositeRoles at: 4) equals: (self compositeRoles at: 3)).

	self deny: ((self compositeRoles at: 4) equals: (self simpleRoles at: 4)).

	self deny: ((self simpleRoles at: 1) equals: (self compositeRoles at: 2)).

	self deny: ((self simpleRoles at: 2) equals: (self compositeRoles at: 3)).

	self deny: ((self simpleRoles at: 3) equals: (self simpleRoles at: 2)).

	self deny: ((self simpleRoles at: 4) equals: (self simpleRoles at: 1))