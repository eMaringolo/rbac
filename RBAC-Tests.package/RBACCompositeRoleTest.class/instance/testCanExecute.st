uncategorized
testCanExecute
	| role role2 role3 compositeRole |
	role := RBACRole new.
	role2 := RBACRole new.
	role3 := RBACRole new.
	compositeRole := RBACCompositeRole new
		addRole: role;
		addRole: role2;
		addRole: role3.
	role addPermissionFor: (self operations at: 1).
	role2 addPermissionFor: (self operations at: 2).
	role3 addPermissionFor: (self operations at: 3).
	self assert: (compositeRole canExecute: (self operations at: 1)).
	self assert: (compositeRole canExecute: (self operations at: 2)).
	self assert: (compositeRole canExecute: (self operations at: 3)).
	self deny: (compositeRole canExecute: (self operations at: 4))