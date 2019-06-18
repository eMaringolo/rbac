"

"
Class {
	#name : 'RBACGlorpPersistenceTest',
	#superclass : 'TestCase',
	#instVars : [
		'login',
		'session',
		'databaseFilename'
	],
	#originalCategory : 'RBAC-Glorp',
	#vw_namespace : 'Root',
	#category : 'RBAC-Tests'
}

{ #category : 'initialize-release' }
RBACGlorpPersistenceTest >> createDatabaseSchema [

	| classes |
	classes := (OrderedCollection new)
				add: RBACProfile;
				add: RBACUser;
				add: RBACGroup;
				add: RBACRole;
				add: RBACPermission;
				add: RBACMenu;
				yourself.
	(session system schemaStatementsFor: classes)
		do: [:each | session accessor executeSQLStringNoResult: each]
]

{ #category : 'initialize-release' }
RBACGlorpPersistenceTest >> databaseFilename [

	^databaseFilename ifNil: [databaseFilename := 'RBACTest', Timestamp now compressedDateTimeString, '.sqlite']
]

{ #category : 'initialize-release' }
RBACGlorpPersistenceTest >> ensureDatabaseDeletion [

	(Filename named: self databaseFilename) deleteIfPossible
]

{ #category : 'initialize-release' }
RBACGlorpPersistenceTest >> setUp [

	self ensureDatabaseDeletion.
	login := (Login new)
				database: SQLite3Platform new;
				username: 'svx';
				connectString: self databaseFilename.
	session := RBACDescriptorSystem sessionForLogin: login.
	session accessor login.
	self createDatabaseSchema.
]

{ #category : 'initialize-release' }
RBACGlorpPersistenceTest >> tearDown [

	session logout.
	self ensureDatabaseDeletion
]

{ #category : 'tests' }
RBACGlorpPersistenceTest >> testAuthenticationProvider [

	| provider |
	provider := RBACGlorpAuthenticationProvider session: session.
	session inUnitOfWorkDo: [
		| user |
		user := RBACUser newNamed: 'JohnDoe'.
		session register: user.
		provider setNewPassword: 'foobar' for: user.
	].

	self assert: (provider authenticateUsername: 'JohnDoe' password: 'foobar').
]

{ #category : 'tests' }
RBACGlorpPersistenceTest >> testBasicGraphPersistence [


	session inUnitOfWorkDo: [
		| role menu subMenu user group |
		menu := RBACMenu newNamed: 'Root Menu'.
		subMenu := RBACMenu newNamed: 'Sub Menu'.
		role := RBACRole newNamed: 'Operator'.
		role addPermissionFor: menu.
		role addPermission: ((RBACPermission target: subMenu) allowsExecution: true).
		group := RBACGroup newNamed: 'Operators'.
		session register: group.
		user := RBACUser newNamed: 'Joe the operator'.
		group addRole: role.
		group addMember: user.

	].

	session inUnitOfWorkDo: [
		| role menu subMenu user group |
		group := session readOneOf: RBACGroup. 
		user 	:= session readOneOf: RBACUser.
		menu := session readOneOf: RBACMenu where: [:each | each name = 'Root Menu'].
		subMenu := session readOneOf: RBACMenu where: [:each | each name = 'Sub Menu'].

		self assert: (group members includes: user).
		self assert: group roles size equals: 1.
		
		role := group roles anyOne.
		self assert: role name equals: 'Operator'.
		self assert: (role permissionFor: menu) allowsRead.
		self assert: (role permissionFor: subMenu) allowsExecution.
		
	]
]
