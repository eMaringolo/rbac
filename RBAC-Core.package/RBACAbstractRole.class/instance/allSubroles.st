uncategorized
allSubroles
	"Answer a collection of the receiver's subroles in 
	breadth-first order, with the immediate children first. 
	Breadth-first traversal is slightly less efficient, but results 
	in a more useful ordering (the standard does not specify the order)."

	| answer |
	answer := OrderedCollection new.
	self allSubrolesDo: [:each | answer add: each ].
	^answer