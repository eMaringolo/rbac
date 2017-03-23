unit tests
testRequestGranting
	| session profile role |
	profile := RBACUser new.
	role := RBACRole new.
	role addPermission: (RBACPermission target: #GrantedModel) allowAll.
	role addPermission: (RBACPermission target: #DeniedModel) denyAll.
	profile addRole: role.
	session := RBACSession for: profile.
	RBACAction
		subclassesDo: [ :actionClass | 
			self
				assert:
					(session
						request: (RBACCreation of: #GrantedModel)
						ifGranted: [ true ]
						ifDenied: [ false ]).
			self
				deny:
					(session request: (RBACDeletion of: #DeniedModel) ifGranted: [ true ] ifDenied: [ false ]) ]