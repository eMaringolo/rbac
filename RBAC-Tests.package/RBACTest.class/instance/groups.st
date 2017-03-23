accessing
groups
	groups ifNil: [ self initializeRBACGroups ].
	^ groups 