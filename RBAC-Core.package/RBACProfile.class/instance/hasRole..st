roles
hasRole: aRole
	self roles
		do: [ :each | 
			(each containsRole: aRole)
				ifTrue: [ ^ true ] ].
	^ false