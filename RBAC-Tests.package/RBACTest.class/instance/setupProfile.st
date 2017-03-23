initializing
setupProfile
	"Private - Test the addition of roles to the user."

	| profile crudForCreateAndUpdate crudForDeleteAndRead sysop objectForCreate objectForUpdate objectForDelete objectForRead |
	objectForCreate := RBACNamedModel new.
	objectForUpdate := RBACNamedModel new.
	objectForDelete := RBACNamedModel new.
	objectForRead := RBACNamedModel new.
	profile := self users at: 1.
	profile addRole: (self simpleRoles at: 1).
	crudForCreateAndUpdate := RBACPermission target: objectForCreate.
	crudForCreateAndUpdate
		allowsCreation: true;
		allowsUpdate: true.
	crudForDeleteAndRead := RBACPermission target: objectForDelete.
	crudForDeleteAndRead
		allowsDeletion: true;
		allowsRead: true.
	sysop := RBACPermission
		role: (self simpleRoles at: 1)
		target: (self operations at: 1).
	(self simpleRoles at: 1)
		addPermission: crudForCreateAndUpdate;
		addPermission: crudForDeleteAndRead;
		addPermission: sysop