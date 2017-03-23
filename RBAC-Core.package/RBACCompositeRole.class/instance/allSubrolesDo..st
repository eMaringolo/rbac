roles
allSubrolesDo: aBlock
	self subroles
		do: [ :each | 
			aBlock value: each.
			each allSubrolesDo: aBlock ]