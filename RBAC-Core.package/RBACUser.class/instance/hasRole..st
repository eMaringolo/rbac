roles
hasRole: aRole
	^ (super hasRole: aRole)
		ifTrue: [ true ]
		ifFalse: [ self groups
				do: [ :each | 
					(each hasRole: aRole)
						ifTrue: [ ^ true ] ].
			false ]