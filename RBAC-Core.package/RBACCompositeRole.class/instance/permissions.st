permissions
permissions
	"Answer the CRUD permissions of the receiver."
	
	| crudPermissions |
	crudPermissions := Set new.
	self allSubrolesDo: [:each | crudPermissions addAll: each permissions ].
	^crudPermissions asOrderedCollection