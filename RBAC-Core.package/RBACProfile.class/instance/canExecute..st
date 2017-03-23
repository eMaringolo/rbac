permissions
canExecute: target
	^ self roles anySatisfy: [ :one | one canExecute: target ]