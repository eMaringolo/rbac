uncategorized
setupProfile
	| profile permA permB permC targetA targetB |
	targetA := self operations at: 1.
	targetB := self operations at: 2.
	profile := self users at: 1.
	profile addRole: (self simpleRoles at: 1).
	permA := RBACPermission target: targetA.
	permA
		allowsCreation: true;
		allowsUpdate: true;
		allowsExecution: true.
	permB := RBACPermission target: targetB.
	permB
		allowsDeletion: true;
		allowsRead: true.
	permC := RBACPermission target: (self operations at: 1).
	permC allowsExecution: true.
	(self simpleRoles at: 1)
		addPermission: permA;
		addPermission: permB;
		addPermission: permC