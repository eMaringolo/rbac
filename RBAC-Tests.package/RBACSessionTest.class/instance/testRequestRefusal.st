unit tests
testRequestRefusal
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