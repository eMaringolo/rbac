uncategorized
testCanExecute
	"Test the canExecute: method."

	| role |
	role := self simpleRoles at: 1.
	self deny: (role canExecute: (self operations at: 1)).
	self deny: (role canExecute: (self operations at: 2)).
	role addPermissionFor: (self operations at: 1).
	role addPermission: (RBACPermission target: (self operations at: 2)).
	self assert: (role canExecute: (self operations at: 1)).
	self deny: (role canExecute: (self operations at: 2)).
	role removePermissionFor: (self operations at: 2).
	role addPermission: ((RBACPermission target: (self operations at: 2)) allowsExecution: true).
	self assert: (role canExecute: (self operations at: 1)).
	self assert: (role canExecute: (self operations at: 2))