roles
validateRoleAddition: aRole
	(self canAdd: aRole)
		ifTrue: [ RBACRoleAlreadyAssigned signalWith: aRole ]