private
canExecute: anObject
	^ self permissions anySatisfy: [ :one | one target = anObject and: [ one allowsExecution ] ]