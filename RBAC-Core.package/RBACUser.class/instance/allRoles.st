groups
allRoles
	^ self groups
		inject: Set new
		into: [ :coll :each | 
			coll
				addAll: each roles;
				yourself ]