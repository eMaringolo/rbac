uncategorized
withAllSubroles
	"Answer a <collection> with the receiver and its subroles in 
	breadth-first order, with the immediate children first. 
	Breadth-first traversal is slightly less efficient, but results 
	in a more useful ordering (the standard does not specify the order)."

	^self allSubroles
		addFirst: self;
		yourself