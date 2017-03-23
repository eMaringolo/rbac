permissions
canExecute: target
	^ (super canExecute: target)
		ifTrue: [ true ]
		ifFalse: [ self groups anySatisfy: [ :one | one canExecute: target ] ]