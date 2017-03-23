unit tests
testPermissionsInheritanceFromGroups
	"Test the addition of roles to the user."

	| profile group1 group2 permission target |
	profile := self profile1.
	profile addRole: (self simpleRoles at: 1).
	profile addRole: (self compositeRoles at: 1).
	(self compositeRoles at: 1) addRole: (self simpleRoles at: 2).
	group1 := self groups at: 1.
	group2 := self groups at: 2.
	target := (RBACNamedModel new).
	group1 addMember: profile.
	group2 addMember: profile.
	group1 addRole: (self simpleRoles at: 3).
	group2 addRole: (self simpleRoles at: 4).
	permission := RBACPermission target: target.
	permission
		allowsCreation: true;
		allowsUpdate: true.
	(self simpleRoles at: 1) addPermission: permission.
	permission := RBACPermission target: target.
	permission allowsDeletion: true.
	(self simpleRoles at: 3) addPermission: permission.
	permission := RBACPermission target: target.
	permission allowsRead: true.
	(self simpleRoles at: 4) addPermission: permission.
	self assert: (profile canCreate: target).
	self assert: (profile canRead: target).
	self assert: (profile canUpdate: target).
	self assert: (profile canDelete: target)