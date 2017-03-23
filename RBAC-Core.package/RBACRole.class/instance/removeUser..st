members
removeUser: aRBACUser 
	
	(self users includes: aRBACUser) ifTrue: [ self users remove: aRBACUser ]