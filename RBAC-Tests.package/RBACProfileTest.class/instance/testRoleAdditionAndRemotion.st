unit tests
testRoleAdditionAndRemotion
	"Test the addition and remotion of roles to the user."

	| samProfile |
	samProfile := self profile1.
	samProfile addRole: (self simpleRoles at: 1).
	self assert: samProfile roles = (Set with: (self simpleRoles at: 1)).
	samProfile addRole: (self compositeRoles at: 1).
	self assert: samProfile roles = (Set with: (self simpleRoles at: 1) with: (self compositeRoles at: 1)).
	samProfile removeRole: (self simpleRoles at: 1).
	self should: [ samProfile removeRole: (self simpleRoles at: 1) ] raise: NotFound.
	self assert: samProfile roles = (Set with: (self compositeRoles at: 1)).
	samProfile addRole: (self simpleRoles at: 2).
	self assert: samProfile roles = (Set with: (self compositeRoles at: 1) with: (self simpleRoles at: 2)).
	self should: [ samProfile removeRole: (self simpleRoles at: 3) ] raise: NotFound.
	samProfile removeAllRoles.
	self assert: samProfile roles isEmpty