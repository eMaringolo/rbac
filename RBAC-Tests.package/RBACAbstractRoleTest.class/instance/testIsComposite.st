uncategorized
testIsComposite

	"Test the isComposite method."



	self assert: (self compositeRoles at: 1) isComposite.

	self assert: (self compositeRoles at: 2) isComposite.

	self assert: (self compositeRoles at: 3) isComposite.

	self assert: (self compositeRoles at: 4) isComposite.

	self deny: (self simpleRoles at: 1) isComposite.

	self deny: (self simpleRoles at: 2) isComposite.

	self deny: (self simpleRoles at: 3) isComposite.

	self deny: (self simpleRoles at: 4) isComposite