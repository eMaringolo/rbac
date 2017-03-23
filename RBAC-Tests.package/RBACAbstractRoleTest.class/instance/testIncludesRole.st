uncategorized
testIncludesRole
	self addRoles.
	self assert: ((self compositeRoles at: 1) containsRole: (self simpleRoles at: 1)).
	self assert: ((self compositeRoles at: 2) containsRole: (self simpleRoles at: 2)).
	self assert: ((self compositeRoles at: 2) containsRole: (self compositeRoles at: 4)).
	self assert: ((self compositeRoles at: 4) containsRole: (self simpleRoles at: 3)).
	self assert: ((self compositeRoles at: 4) containsRole: (self simpleRoles at: 4)).

	self assert: ((self compositeRoles at: 1) containsRole: (self simpleRoles at: 3)).
	self assert: ((self compositeRoles at: 1) containsRole: (self simpleRoles at: 4)).
	self assert: ((self compositeRoles at: 1) containsRole: (self compositeRoles at: 4)).
	self assert: ((self compositeRoles at: 2) containsRole: (self simpleRoles at: 3)).



	"Equality between simple roles"
	self assert: ((self simpleRoles at: 1) containsRole: (self simpleRoles at: 1)).
	self assert: ((self simpleRoles at: 4) containsRole: (self simpleRoles at: 4)).



	"No inclusion"
	self deny: ((self simpleRoles at: 1) containsRole: (self simpleRoles at: 2)).
	self deny: ((self simpleRoles at: 2) containsRole: (self simpleRoles at: 3)).
	self deny: ((self simpleRoles at: 2) containsRole: (self compositeRoles at: 1)).
	self deny: ((self simpleRoles at: 2) containsRole: (self compositeRoles at: 4)).
	self deny: ((self simpleRoles at: 3) containsRole: (self compositeRoles at: 3)).
	self deny: ((self compositeRoles at: 4) containsRole: (self compositeRoles at: 2)).
	self deny: ((self compositeRoles at: 4) containsRole: (self compositeRoles at: 1)).
	self deny: ((self compositeRoles at: 3) containsRole: (self compositeRoles at: 4)).
	self deny: ((self compositeRoles at: 3) containsRole: (self simpleRoles at: 4)).
	self deny: ((self compositeRoles at: 2) containsRole: (self simpleRoles at: 1)).
	self deny: ((self compositeRoles at: 1) containsRole: (self simpleRoles at: 5)).
	self deny: ((self compositeRoles at: 4) containsRole: (self simpleRoles at: 1))