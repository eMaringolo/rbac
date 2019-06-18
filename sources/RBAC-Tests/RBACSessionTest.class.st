"

"
Class {
	#name : 'RBACSessionTest',
	#superclass : 'RBACTest',
	#vw_namespace : 'Root',
	#category : 'RBAC-Tests'
}

{ #category : 'uncategorized' }
RBACSessionTest class >> _comment [



	#InfOilNeedsRefactoring.

	"Se deben cambiar todas las implementaciones de los mÈtodos de esta clase que hacen referencia a clases de Oil Objects

	ya que a nivel de RBAC no se tendrÌa porquÈ tener conocimiento de las clases de Basic Oil Objects-Core.

	Por ahora lo solucionÈ moviendo dichos mÈtodos como loose methods del package Basic Oil Objects-Tests pero est· claro que esa no deberÌa ser

	la soluciÛn definitiva.

	Para saber cuales serÌan los mÈtodos a refactorizar, ver los looseMethods de clases de RBAC en el package Basic Oil Objects-Tests."
]

{ #category : 'unit tests' }
RBACSessionTest >> testRequestGranting [
	| session profile role |
	profile := RBACUser new.
	role := RBACRole new.
	role addPermission: (RBACPermission target: #GrantedModel) allowAll.
	role addPermission: (RBACPermission target: #DeniedModel) denyAll.
	profile addRole: role.
	session := RBACSession for: profile.
	RBACAction
		subclasses do: [ :actionClass | 
			self
				assert:
					(session
						request: (RBACCreation of: #GrantedModel)
						ifGranted: [ true ]
						ifDenied: [ false ]).
			self
				deny:
					(session request: (RBACDeletion of: #DeniedModel) ifGranted: [ true ] ifDenied: [ false ]) ]
]

{ #category : 'unit tests' }
RBACSessionTest >> testRequestRefusal [
	| session menu |
	session := RBACSession for: (self users at: 1).
	menu := RBACNamedModel new.
	self
		should: [ session request: (RBACDeletion of: menu) ifGranted: [  ] ]
		raise: RBACDeletion denialClass.
	self
		should: [ session request: (RBACRead of: menu) ifGranted: [  ] ]
		raise: RBACRead denialClass.
	self
		should: [ session request: (RBACCreation of: menu) ifGranted: [  ] ]
		raise: RBACCreation denialClass.
	self
		should: [ session request: (RBACUpdate of: menu) ifGranted: [  ] ]
		raise: RBACUpdate denialClass.
	self
		should: [ session
				request: (RBACExecution of: (self operations at: 2))
				ifGranted: [  ] ]
		raise: RBACExecution denialClass
]
