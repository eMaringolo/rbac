uncategorized
equalityBetween: aCollection and: anotherCollection
	aCollection size = anotherCollection size
		ifFalse: [ ^ false ].
	aCollection
		do: [ :each | 
			(anotherCollection includes: each)
				ifFalse: [ ^ false ] ].
	^ true