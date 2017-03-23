uncategorized
testSystemPermissionAddition
	| role |
	(role := self simpleRoles at: 1) addPermissionFor: (self operations at: 1).
	self assert: (role canExecute: (self operations at: 1)).
	(self compositeRoles at: 1) addRole: role.
	self assert: ((self compositeRoles at: 1) canExecute: self operations first)