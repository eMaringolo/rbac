members
removeAllMembers
	self members copy
		do: [ :each | self removeMember: each ]