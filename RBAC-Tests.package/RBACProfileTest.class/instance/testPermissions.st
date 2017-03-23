unit tests
testPermissions
	"Test the addition of roles to the user."

	| profile crud1 crud2 crud3 target1 target2 |
	profile := self profile1.
	profile
		addRole: (self simpleRoles at: 1);
		addRole: (self compositeRoles at: 1).
	target1 := Object new.
	target2 := Object new.
	(self compositeRoles at: 1) addRole: (self simpleRoles at: 2).
	crud1 := (RBACPermission target: target1)
		allowsCreation: true;
		allowsUpdate: true;
		yourself.
	crud2 := (RBACPermission target: target2)
		allowsCreation: true;
		allowsRead: true;
		yourself.
	crud3 := (RBACPermission target: target1)
		allowsDeletion: true;
		yourself.
	(self simpleRoles at: 1)
		addPermission: crud1;
		addPermission: crud2.
	(self simpleRoles at: 2) addPermission: crud3.
	self assert: (profile canCreate: target1).
	self assert: (profile canUpdate: target1).
	self assert: (profile canDelete: target1).
	self assert: (profile canCreate: target2).
	self assert: (profile canRead: target2)