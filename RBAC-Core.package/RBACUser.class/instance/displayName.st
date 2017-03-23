accessing
displayName
	"Answer the value of the receiver's ''displayName'' instance variable."

	displayName isNil ifTrue: [^self name].
	^displayName