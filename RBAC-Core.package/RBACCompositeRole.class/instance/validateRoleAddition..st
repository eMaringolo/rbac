roles
validateRoleAddition: role 
	"Adds role to the receiver list of subroles."

	(role equals: self) ifTrue: [RBACSameRole signalWith: role].
	(role containsRole: self) ifTrue: [RBACRoleRecursion signalWith: role].
	(self containsRole: role) ifTrue: [RBACRoleAlreadyAssigned signalWith: role]