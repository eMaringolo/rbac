permissions
canExecute: target
	self
		allSubrolesDo: [ :each | 
			(each canExecute: target)
				ifTrue: [ ^ true ] ].
	^false