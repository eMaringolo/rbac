uncategorized
testvalidateRoleAddition

	"Test the validateRoleAddition: method."



	self addRoles.

	self should: [(self compositeRoles at: 1) validateRoleAddition: (self compositeRoles at: 2)]

		raise: RBACRoleAlreadyAssigned.

	self should: [(self compositeRoles at: 1) validateRoleAddition: (self compositeRoles at: 4)]

		raise: RBACRoleAlreadyAssigned.

	self should: [(self compositeRoles at: 2) validateRoleAddition: (self simpleRoles at: 3)]

		raise: RBACRoleAlreadyAssigned.

	self should: [(self compositeRoles at: 1) validateRoleAddition: (self simpleRoles at: 4)]

		raise: RBACRoleAlreadyAssigned.

	self should: [(self compositeRoles at: 4) validateRoleAddition: (self compositeRoles at: 1)]

		raise: RBACRoleRecursion.

	self should: [(self compositeRoles at: 4) validateRoleAddition: (self compositeRoles at: 2)]

		raise: RBACRoleRecursion.

	self should: [(self compositeRoles at: 2) validateRoleAddition: (self compositeRoles at: 1)]

		raise: RBACRoleRecursion.

	self should: [(self compositeRoles at: 1) validateRoleAddition: (self compositeRoles at: 1)]

		raise: RBACSameRole.

	self should: [(self compositeRoles at: 2) validateRoleAddition: (self compositeRoles at: 2)]

		raise: RBACSameRole.

	self shouldnt: [(self compositeRoles at: 1) validateRoleAddition: (self compositeRoles at: 3)]

		raise: RBACRoleError.

	self shouldnt: [(self compositeRoles at: 2) validateRoleAddition: (self compositeRoles at: 5)]

		raise: RBACRoleError.

	self shouldnt: [(self compositeRoles at: 4) validateRoleAddition: (self simpleRoles at: 5)]

		raise: RBACRoleError.

	self shouldnt: [(self compositeRoles at: 5) validateRoleAddition: (self simpleRoles at: 2)]

		raise: RBACRoleError