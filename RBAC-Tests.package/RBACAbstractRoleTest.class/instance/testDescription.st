uncategorized
testDescription
	"Test the description and description: methods."

	| singleRole compositeRole |
	singleRole := self simpleRoles at: 1.
	compositeRole := self compositeRoles at: 3.
	singleRole description: 'This is a role'.
	compositeRole description: 'This is another role'.
	self assert: singleRole description = 'This is a role'.
	self assert: compositeRole description = 'This is another role'