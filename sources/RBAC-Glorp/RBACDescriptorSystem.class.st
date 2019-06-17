"
I'm the GLORP descriptor system for all RBAC classes


"
Class {
	#name : 'RBACDescriptorSystem',
	#superclass : 'DescriptorSystem',
	#vw_namespace : 'Root',
	#category : 'RBAC-Glorp'
}

{ #category : 'models-convenience' }
RBACDescriptorSystem >> addDatedModelAttributesTo: aClassModel entityClass: aClass [
	
	self addDatedModelAttributesTo: aClassModel entityClass: aClass usesTime: aClassModel describedClass usesDateAndTime
]

{ #category : 'models-convenience' }
RBACDescriptorSystem >> addDatedModelAttributesTo: aClassModel entityClass: aClass usesTime: usesTime [
	self addIdAttributeTo: aClassModel.
	aClassModel newAttributeNamed: #businessDate.
	usesTime ifTrue: [ aClassModel newAttributeNamed: #dateAndTime ].
	aClassModel newAttributeNamed: #entity type: aClass.
	aClassModel newAttributeNamed: #comments.
]

{ #category : 'tables-convenience' }
RBACDescriptorSystem >> addDatedModelFieldsTo: aTable entityTable: entityTable [

	self addDatedModelFieldsTo: aTable entityTable: entityTable usesTime: false
]

{ #category : 'tables-convenience' }
RBACDescriptorSystem >> addDatedModelFieldsTo: aTable entityTable: entityTable usesTime: usesTime [

	self addDatedModelFieldsTo: aTable entityTable: entityTable usesTime: usesTime usesComments: false
]

{ #category : 'tables-convenience' }
RBACDescriptorSystem >> addDatedModelFieldsTo: aTable entityTable: entityTable usesTime: usesTime usesComments: usesComments [
	| entityId |
	entityId := aTable createFieldNamed: 'entity_id' type: platform integer.
	aTable addForeignKeyFrom: entityId to: (entityTable fieldNamed: 'id').
	aTable createFieldNamed: 'businessDate' type: platform date.
	usesTime ifTrue: [ 
		aTable createFieldNamed: 'dateAndTime' type: platform dateAndTime
		].
	usesComments ifTrue: [ 
		aTable createFieldNamed: 'comments' type: (platform varchar: 1000)
	]
]

{ #category : 'mappings-convenience' }
RBACDescriptorSystem >> addDatedModelMappingsTo: aDescriptor table: table [
	self
		addDatedModelMappingsTo: aDescriptor
		table: table
		entityTable: nil
		usesTime: false
		usesComments: false
]

{ #category : 'mappings-convenience' }
RBACDescriptorSystem >> addDatedModelMappingsTo: aDescriptor table: table entityTable: entityTable usesTime: usesTime usesComments: usesComments [
	| entityMapping  |
	self addIdMappingTo: aDescriptor table: table.
	(aDescriptor newMapping: DirectMapping) from: #businessDate to: (table fieldNamed: 'businessDate').
	usesTime 
		ifTrue: [(aDescriptor newMapping: DirectMapping) from: #dateAndTime to: (table fieldNamed: 'dateAndTime') ].
	entityMapping := (aDescriptor newMapping: OneToOneMapping) attributeName: #entity.
	entityTable notNil ifTrue: [ entityMapping join: (
								Join	
									from: (table fieldNamed: 'entity_id')
									to: (entityTable fieldNamed: 'id'))].
	usesComments ifTrue: [ 
		(aDescriptor newMapping: DirectMapping) from: #comments to: (table fieldNamed: 'comments') ]
]

{ #category : 'mappings-convenience' }
RBACDescriptorSystem >> addDatedModelMappingsTo: aDescriptor table: table usesTime: aBoolean [
	self
		addDatedModelMappingsTo: aDescriptor
		table: table
		entityTable: nil
		usesTime: aBoolean
		usesComments: false
]

{ #category : 'models-convenience' }
RBACDescriptorSystem >> addIdAttributeTo: aClassModel [
	aClassModel newAttributeNamed: #id
]

{ #category : 'tables-convenience' }
RBACDescriptorSystem >> addIdFieldTo: aTable [
	(aTable createFieldNamed: 'id' type: platform sequence) bePrimaryKey
]

{ #category : 'mappings-convenience' }
RBACDescriptorSystem >> addIdMappingTo: aDescriptor table: table [
	(aDescriptor newMapping: DirectMapping) from: #id to: (table fieldNamed: 'id')
]

{ #category : 'tables-convenience' }
RBACDescriptorSystem >> addModelPartFieldsTo: aTable ownerTable: ownerTable [
	| ownerId |
	ownerId := aTable createFieldNamed: 'owner_id' type: platform integer.
	aTable addForeignKeyFrom: ownerId to: (ownerTable fieldNamed: 'id')
]

{ #category : 'mappings-convenience' }
RBACDescriptorSystem >> addModelPartMappingsTo: aDescriptor table: table ownerClass: aClass [
	self addIdMappingTo: aDescriptor table: table.
	(aDescriptor newMapping: OneToOneMapping )
		attributeName: #owner; 
		referenceClass: aClass
]

{ #category : 'models-convenience' }
RBACDescriptorSystem >> addNameAttributeTo: aClassModel [
	aClassModel newAttributeNamed: #name
]

{ #category : 'tables-convenience' }
RBACDescriptorSystem >> addNameFieldTo: aTable [
	aTable createFieldNamed: 'name' type: (platform varChar: 100)
]

{ #category : 'mappings-convenience' }
RBACDescriptorSystem >> addNameMappingTo: aDescriptor table: table [
	(aDescriptor newMapping: DirectMapping) from: #name to: (table fieldNamed: 'name')
]

{ #category : 'models-convenience' }
RBACDescriptorSystem >> addNamedModelAttributesTo: aClassModel [
	aClassModel newAttributeNamed: #id.
	self addNameAttributeTo: aClassModel
]

{ #category : 'mappings-convenience' }
RBACDescriptorSystem >> addNamedModelMappingsTo: aDescriptor table: table [
	self addIdMappingTo: aDescriptor table: table.
	self addNameMappingTo: aDescriptor table: table
]

{ #category : 'tables-convenience' }
RBACDescriptorSystem >> addTableFieldsForNamedModel: aTable [
	self addIdFieldTo: aTable.
	self addNameFieldTo: aTable
]

{ #category : 'models-convenience' }
RBACDescriptorSystem >> addUserAttributeTo: aClassModel [

	aClassModel newAttributeNamed: #user type: RBACUser
]

{ #category : 'tables-convenience' }
RBACDescriptorSystem >> addUserFieldTo: aTable [

	| userId |
	userId := aTable createFieldNamed: 'user_id' type: platform integer.
	aTable addForeignKeyFrom: userId to: ((self tableNamed: 'RBSUSER') fieldNamed: 'id')
]

{ #category : 'mappings-convenience' }
RBACDescriptorSystem >> addUserMappingTo: aDescriptor [

	(aDescriptor newMapping: OneToOneMapping ) attributeName: #user; referenceClass: RBACUser
]

{ #category : 'models-convenience' }
RBACDescriptorSystem >> addVersioningAttributesTo: aClassModel [

	aClassModel newAttributeNamed: #creationTs.
	aClassModel newAttributeNamed: #modificationTs
]

{ #category : 'tables-convenience' }
RBACDescriptorSystem >> addVersioningFieldsTo: aTable [

	aTable createFieldNamed: 'created_at' type: ((platform versionFieldFor: platform timestamp) generatesOverExistingValues: false).
	aTable createFieldNamed: 'modified_at' type: (platform versionFieldFor: platform timestamp) generateOverExistingValues.
]

{ #category : 'mappings-convenience' }
RBACDescriptorSystem >> addVersioningMappingsTo: aDescriptor table: table [

	(aDescriptor newMapping: DirectMapping) from: #creationTs
		to: (table fieldNamed: 'created_at').
	(aDescriptor newMapping: DirectMapping) from: #modificationTs
		to: (table fieldNamed: 'modified_at')
]

{ #category : 'models' }
RBACDescriptorSystem >> classModelForRBACGroup: aClassModel [

	self addNamedModelAttributesTo: aClassModel.
	aClassModel newAttributeNamed: #roles collectionOf: RBACRole.
	aClassModel newAttributeNamed: #members collectionOf: RBACProfile.
	self addVersioningAttributesTo: aClassModel
]

{ #category : 'models' }
RBACDescriptorSystem >> classModelForRBACMenu: aClassModel [
	self addNamedModelAttributesTo: aClassModel.
	aClassModel newAttributeNamed: #subjectType.	
	aClassModel newAttributeNamed: #tag.
	aClassModel newAttributeNamed: #description.
	aClassModel newAttributeNamed: #priority.
	aClassModel newAttributeNamed: #icon.
	aClassModel newAttributeNamed: #componentClass.
	aClassModel newAttributeNamed: #modelClass.
	aClassModel newAttributeNamed: #parent type: RBACMenu.
	aClassModel newAttributeNamed: #children collectionOf: RBACMenu.
]

{ #category : 'models' }
RBACDescriptorSystem >> classModelForRBACOperation: aClassModel [
	self addNamedModelAttributesTo: aClassModel.
	aClassModel newAttributeNamed: #subjectType.
	aClassModel newAttributeNamed: #tag.
	aClassModel newAttributeNamed: #description.
]

{ #category : 'models' }
RBACDescriptorSystem >> classModelForRBACPermission: aClassModel [

	aClassModel newAttributeNamed: #id.
	aClassModel newAttributeNamed: #role type: RBACRole.
	aClassModel newAttributeNamed: #bits.	
	aClassModel newAttributeNamed: #target type: RBACPermissionSubject.
]

{ #category : 'models' }
RBACDescriptorSystem >> classModelForRBACProfilePreference: aClassModel [

	aClassModel newAttributeNamed: #owner type: RBACProfile.
	aClassModel newAttributeNamed: #section .
	aClassModel newAttributeNamed: #name.	
	aClassModel newAttributeNamed: #value.
]

{ #category : 'models' }
RBACDescriptorSystem >> classModelForRBACRole: aClassModel [
	self addNamedModelAttributesTo: aClassModel.
	 aClassModel newAttributeNamed: #users collectionOf: RBACUser.
	 aClassModel newAttributeNamed: #permissions collectionOf: RBACPermission.
]

{ #category : 'models' }
RBACDescriptorSystem >> classModelForRBACUser: aClassModel [

	self addNamedModelAttributesTo: aClassModel.
	aClassModel newAttributeNamed: #password.
	aClassModel newAttributeNamed: #passwordSalt.
	aClassModel newAttributeNamed: #displayName.
	aClassModel newAttributeNamed: #description.
	aClassModel newAttributeNamed: #emailAddress.
	aClassModel newAttributeNamed: #roles collectionOf: RBACRole.
	aClassModel newAttributeNamed: #preferences
		collectionOf: RBACProfilePreference.
	self addVersioningAttributesTo: aClassModel
]

{ #category : 'converters' }
RBACDescriptorSystem >> classToStringConverter [

	^PluggableDatabaseConverter new
		dbToStConverter: [:value | value notNil ifTrue: [Smalltalk at: value asSymbol ]];
		stToDbConverter: [:class | class ifNotNil: [:c | c name asString ]];
		yourself
]

{ #category : 'mappings-convenience' }
RBACDescriptorSystem >> configureRBACPermissionSubjectDescriptor: aDescriptor [

	| table|
	table := self tableNamed: 'RBACPERMISSIONSUBJECT'.
	self addNamedModelMappingsTo: aDescriptor table: table.
	(aDescriptor newMapping: DirectMapping)
		from: #subjectType to: (table fieldNamed: 'subjectType');
		beReadOnly.
	(aDescriptor newMapping: DirectMapping) from: #tag
		to: (table fieldNamed: 'tag').	
	(aDescriptor newMapping: DirectMapping) from: #description
		to: (table fieldNamed: 'description').
	self addVersioningMappingsTo: aDescriptor table: aDescriptor table
]

{ #category : 'mappings-convenience' }
RBACDescriptorSystem >> configureRBACProfileDescriptor: aDescriptor [

	| rolesLinkTable table |
	table := self tableNamed: 'RBACPROFILE'.
	self addNamedModelMappingsTo: aDescriptor table: table.
	(aDescriptor newMapping: DirectMapping)
		from: #profileType to: (table fieldNamed: 'profileType');
		beReadOnly.
	(aDescriptor newMapping: DirectMapping) from: #description
		to: (table fieldNamed: 'description').
	rolesLinkTable := self tableNamed: 'RBACPROFILE_ON_RBACROLE'.
	(aDescriptor newMapping: ManyToManyMapping)
		attributeName: #roles;
		referenceClass: RBACRole;
		collectionType: Set;
		join: (Join from: (table fieldNamed: 'id')
					to: (rolesLinkTable fieldNamed: 'profile_id')).
	self addVersioningMappingsTo: aDescriptor table: aDescriptor table
]

{ #category : 'mappings-convenience' }
RBACDescriptorSystem >> configureTsPersonaDescriptor: aDescriptor [
	| table |
	table := self tableNamed: 'PERSONA'.
	aDescriptor table: table.
	self addIdMappingTo: aDescriptor table:  table.
	(aDescriptor newMapping: DirectMapping) from: #name to:  (table fieldNamed: 'name').
	(aDescriptor newMapping: DirectMapping) from: #class to:  (table fieldNamed: 'class'); beReadOnly.	
	(aDescriptor newMapping: OneToOneMapping ) attributeName: #address.
	(aDescriptor newMapping: DirectMapping) from: #category to:  (table fieldNamed: 'category').
	(aDescriptor newMapping: DirectMapping) from: #phone to:  (table fieldNamed: 'phone').	
	(aDescriptor newMapping: DirectMapping) from: #email to:  (table fieldNamed: 'email').			
	(aDescriptor newMapping: DirectMapping) from: #email2 to:  (table fieldNamed: 'email2').
	(aDescriptor newMapping: DirectMapping) from: #comments to:  (table fieldNamed: 'comments').
]

{ #category : 'mappings' }
RBACDescriptorSystem >> descriptorForRBACGroup: aDescriptor [

	| table membersLinkTable |
	table := self tableNamed: 'RBACPROFILE'.
	aDescriptor table: table.
	(self typeResolverFor: RBACProfile)
		register: aDescriptor
		keyedBy: 'group'
		field: (table fieldNamed: 'profileType').
	self configureRBACProfileDescriptor: aDescriptor.
	membersLinkTable := self tableNamed: 'RBACGROUP_ON_RBACUSER'.
	(aDescriptor newMapping: ManyToManyMapping)
		attributeName: #members;
		referenceClass: RBACUser;
		collectionType: Set;
		join: (Join from: (table fieldNamed: 'id')
					to: (membersLinkTable fieldNamed: 'group_id'))
]

{ #category : 'mappings' }
RBACDescriptorSystem >> descriptorForRBACMenu: aDescriptor [

	| table parentTable childrenTable |
	table := self tableNamed: 'RBACPERMISSIONSUBJECT'.
	parentTable := self tableNamed: 'RBACPERMISSIONSUBJECT'.
	childrenTable := self tableNamed: 'RBACPERMISSIONSUBJECT'.
	aDescriptor table: table.
	self configureRBACPermissionSubjectDescriptor: aDescriptor.
	(self typeResolverFor: RBACPermissionSubject)
		register: aDescriptor
		keyedBy: 'menu'
		field: (table fieldNamed: 'subjectType').
	((aDescriptor newMapping: OneToOneMapping) attributeName: #parent)
		referenceClass: RBACMenu;
		join: (Join from: (table fieldNamed: 'parent_id')
					to: (parentTable fieldNamed: 'id')).
	(aDescriptor newMapping: OneToManyMapping)
		attributeName: #children;
		referenceClass: RBACMenu;
		collectionType: SortedCollection;
		join: (Join from: (table fieldNamed: 'id')
					to: (childrenTable fieldNamed: 'parent_id')).
	(aDescriptor newMapping: DirectMapping) from: #priority
		to: (table fieldNamed: 'priority').
	(aDescriptor newMapping: DirectMapping) from: #icon
		to: (table fieldNamed: 'icon').
]

{ #category : 'mappings' }
RBACDescriptorSystem >> descriptorForRBACOperation: aDescriptor [

	| table |
	table := self tableNamed: 'RBACPERMISSIONSUBJECT'.
	aDescriptor table: table.
	(self typeResolverFor: RBACPermissionSubject)
		register: aDescriptor
		keyedBy: 'checkpoint'
		field: (table fieldNamed: 'subjectType').
	self configureRBACPermissionSubjectDescriptor: aDescriptor
]

{ #category : 'mappings' }
RBACDescriptorSystem >> descriptorForRBACPermission: aDescriptor [
	| table |
	table := self tableNamed: 'RBACPERMISSION'.
	aDescriptor table: table.
	self addModelPartMappingsTo: aDescriptor table:  table ownerClass: RBACRole.
	(aDescriptor newMapping: DirectMapping) from: #bits to: (table fieldNamed: 'bits').	
	(aDescriptor newMapping: OneToOneMapping)
		attributeName: #target;
		referenceClass: RBACPermissionSubject.
]

{ #category : 'mappings' }
RBACDescriptorSystem >> descriptorForRBACPermissionSubject: aDescriptor [

	| table |
	table := self tableNamed: 'RBACPERMISSIONSUBJECT'.
	aDescriptor table: table.
	(self typeResolverFor: RBACPermissionSubject) register: aDescriptor abstract: true.
	self configureRBACPermissionSubjectDescriptor: aDescriptor
]

{ #category : 'mappings' }
RBACDescriptorSystem >> descriptorForRBACProfile: aDescriptor [

	| table |
	table := self tableNamed: 'RBACPROFILE'.
	aDescriptor table: table.
	(self typeResolverFor: RBACProfile) register: aDescriptor abstract: true.
	self configureRBACProfileDescriptor: aDescriptor
]

{ #category : 'mappings' }
RBACDescriptorSystem >> descriptorForRBACProfilePreference: aDescriptor [
	| table |
	table := self tableNamed: 'RBACPROFILEPREFERENCE'.
	aDescriptor table: table.
	(aDescriptor newMapping: OneToOneMapping )
		attributeName: #owner; 
		referenceClass: RBACProfile.
	(aDescriptor newMapping: DirectMapping) from: #section to: (table fieldNamed: 'section').	
	(aDescriptor newMapping: DirectMapping) from: #name to: (table fieldNamed: 'name').		
	(aDescriptor newMapping: DirectMapping) from: #value to: (table fieldNamed: 'value').
]

{ #category : 'mappings' }
RBACDescriptorSystem >> descriptorForRBACRole: aDescriptor [
	| table |
	table := self tableNamed: 'RBACROLE'.
	aDescriptor table: table.
	self addNamedModelMappingsTo: aDescriptor table: table.
	(aDescriptor newMapping: ToManyMapping)
		attributeName: #permissions;
		referenceClass: RBACPermission;
		beExclusive
]

{ #category : 'mappings' }
RBACDescriptorSystem >> descriptorForRBACUser: aDescriptor [
	| table |
	table := self tableNamed: 'RBACPROFILE'.
	aDescriptor table: table.
	( self typeResolverFor: RBACProfile )
		register: aDescriptor
		keyedBy: 'user'
		field: ( table fieldNamed: 'profileType' ).
	self configureRBACProfileDescriptor: aDescriptor.
	( aDescriptor newMapping: DirectMapping ) from: #password
		to: ( table fieldNamed: 'password' ).
	( aDescriptor newMapping: DirectMapping ) from: #passwordSalt
		to: ( table fieldNamed: 'salt' ).
	( aDescriptor newMapping: DirectMapping ) from: #displayName
		to: ( table fieldNamed: 'displayName' ).
	(aDescriptor newMapping: ToManyMapping)
		attributeName: #preferences;
		referenceClass: RBACProfilePreference
]

{ #category : 'configuration' }
RBACDescriptorSystem >> schemaScriptFor: classes [

	| system |
	system := self.
	^String streamContents: 
			[:stream |
			classes do: 
					[:class |
					(system descriptorFor: class) tables do: 
							[:table |
							stream
								nextPutAll: '-- TABLE ';
								nextPutAll: table qualifiedName;
								cr.
							system platform areSequencesExplicitlyCreated
								ifTrue: 
									[(system allSequencesFor: (Array with: table)) do: 
											[:sequence |
											stream
												nextPutAll: sequence creationString;
												nextPut: $;;
												cr]].
							stream
								nextPutAll: (system platform createTableStatementStringFor: table);
								nextPut: $;;
								cr.
							table indexes notEmpty
								ifTrue: 
									[stream
										nextPutAll: '-- INDEXES for ' , table printString;
										cr.
									table indexes do: 
											[:index |
											stream
												nextPutAll: (system platform createTableIndexStatementStringFor: table
															index: index);
												cr]].
							stream cr]].
			stream
				nextPutAll: '-- FOREIGN KEYS';
				cr.
			classes do: 
					[:class |
					(system descriptorFor: class) tables do: 
							[:table |
							table foreignKeyConstraintsForCreation do: 
									[:constraint |
									stream
										nextPutAll: (system platform createConstraintAddStatement: constraint);
										nextPut: $;;
										cr]]]]
]

{ #category : 'configuration' }
RBACDescriptorSystem >> schemaStatementsFor: classes [

	| system statements constraints relationTables |
	system := self.
	statements := OrderedCollection new.
	tables := Set new.
	relationTables := Set new.
	constraints := Set new.
	classes do: 
			[:class |
			tables addAll: (system descriptorFor: class) tables.
			((system descriptorFor: class) mappings contents
				select: [:each | (each isKindOf: Glorp.RelationshipMapping) and: [each usesLinkTable]])
					do: [:each | relationTables addAll: each join allTables].
			(system descriptorFor: class) tables do: 
					[:table |
					table foreignKeyConstraintsForCreation
						do: [:constraint | constraints add: constraint]]].
	tables asArray, relationTables asArray do: 
			[:table |
			statements add: (system platform createTableStatementStringFor: table).
			table indexes do: 
					[:index |
					statements
						add: (system platform createTableIndexStatementStringFor: table index: index)].
			system platform areSequencesExplicitlyCreated
				ifTrue: 
					[(system allSequencesFor: (Array with: table))
						do: [:sequence | statements add: sequence creationString]]].
	constraints do: 
			[:constraint |
			statements add: (system platform createConstraintAddStatement: constraint)].
	^statements reject: [:each | each trimBlanks isEmpty]
]

{ #category : 'tables-relations' }
RBACDescriptorSystem >> tableForRBACGROUP_ON_RBACUSER: aTable [

	| userKey groupKey |
	groupKey := aTable createFieldNamed: 'group_id' type: (platform int4).
	groupKey bePrimaryKey.
	aTable addForeignKeyFrom: groupKey  to: ((self tableNamed: 'RBACPROFILE') fieldNamed: 'id').
	userKey := aTable createFieldNamed: 'user_id' type: (platform int4).
	userKey bePrimaryKey.
	aTable addForeignKeyFrom: userKey to: ((self tableNamed: 'RBACPROFILE') fieldNamed: 'id').
]

{ #category : 'tables' }
RBACDescriptorSystem >> tableForRBACPERMISSION: aTable [

	| target_id |
	self addIdFieldTo: aTable.
	self addModelPartFieldsTo: aTable ownerTable: (self tableNamed: 'RBACROLE').
	target_id := aTable createFieldNamed: 'target_id' type: platform integer.
	aTable addForeignKeyFrom: target_id
		to: ((self tableNamed: 'RBACPERMISSIONSUBJECT') fieldNamed: 'id').
	aTable createFieldNamed: 'bits' type: platform int8.
	self addVersioningFieldsTo: aTable
]

{ #category : 'tables' }
RBACDescriptorSystem >> tableForRBACPERMISSIONSUBJECT: aTable [

	| parentId |
	self addTableFieldsForNamedModel: aTable.
	parentId := aTable createFieldNamed: 'parent_id' type: platform integer.
	aTable createFieldNamed: 'subjectType' type: (platform varChar: 100).
	aTable addForeignKeyFrom: parentId
		to: ((self tableNamed: 'RBACPERMISSIONSUBJECT') fieldNamed: 'id').
	aTable createFieldNamed: 'tag' type: (platform varchar: 50).
	aTable createFieldNamed: 'description' type: (platform varChar: 100).
	aTable createFieldNamed: 'icon' type: (platform varchar: 50).
	aTable createFieldNamed: 'priority' type: platform integer.
	self addVersioningFieldsTo: aTable
]

{ #category : 'tables' }
RBACDescriptorSystem >> tableForRBACPROFILE: aTable [
	self addTableFieldsForNamedModel: aTable.
	aTable createFieldNamed: 'profileType' type: ( platform varChar: 100 ).
	aTable createFieldNamed: 'password' type: ( platform varChar: 2048 ).
	aTable createFieldNamed: 'salt' type: ( platform varChar: 2048 ).
	aTable createFieldNamed: 'description' type: ( platform varChar: 100 ).
	aTable createFieldNamed: 'emailAddress' type: ( platform varChar: 200 ).
	aTable createFieldNamed: 'phoneNumber' type: ( platform varChar: 20 ).
	aTable createFieldNamed: 'displayName' type: ( platform varChar: 40 ).
	self addVersioningFieldsTo: aTable
]

{ #category : 'tables' }
RBACDescriptorSystem >> tableForRBACPROFILEPREFERENCE: aTable [

	| ownerId ownerTable |
	ownerTable := self tableNamed: 'RBACPROFILE'.
	ownerId := (aTable createFieldNamed: 'owner_id' type: platform integer)
				bePrimaryKey.
	aTable addForeignKeyFrom: ownerId to: (ownerTable fieldNamed: 'id').
	(aTable createFieldNamed: 'section' type: (platform varchar: 100))
		bePrimaryKey.
	(aTable createFieldNamed: 'name' type: (platform varchar: 100))
		bePrimaryKey.
	aTable createFieldNamed: 'value' type: (platform varchar: 1000).
	self addVersioningFieldsTo: aTable
]

{ #category : 'tables-relations' }
RBACDescriptorSystem >> tableForRBACPROFILE_ON_RBACROLE: aTable [

	| profileKey roleKey |
	profileKey := aTable createFieldNamed: 'profile_id' type: (platform int4).
	profileKey bePrimaryKey.
	aTable addForeignKeyFrom: profileKey to: ((self tableNamed: 'RBACPROFILE') fieldNamed: 'id').
	roleKey := aTable createFieldNamed: 'role_id' type: (platform int4).
	roleKey bePrimaryKey.
	aTable addForeignKeyFrom: roleKey  to: ((self tableNamed: 'RBACROLE') fieldNamed: 'id').
]

{ #category : 'tables' }
RBACDescriptorSystem >> tableForRBACROLE: aTable [

	self addTableFieldsForNamedModel: aTable.
	self addVersioningFieldsTo: aTable
]

{ #category : 'tables-relations' }
RBACDescriptorSystem >> tableForRBACROLE_ON_RBACPERMISSION: aTable [

	| userKey menuKey |
	userKey := aTable createFieldNamed: 'role_id' type: (platform int4).
	userKey bePrimaryKey.
	aTable addForeignKeyFrom: userKey to: ((self tableNamed: 'RBACROLE') fieldNamed: 'id').
	menuKey := aTable createFieldNamed: 'permission_id' type: (platform int4).
	menuKey bePrimaryKey.
	aTable addForeignKeyFrom: menuKey  to: ((self tableNamed: 'RBACPERMISSION') fieldNamed: 'id').
]

{ #category : 'resolvers' }
RBACDescriptorSystem >> typeResolverForRBACPermissionSubject [

	^FilteredTypeResolver forRootClass: RBACPermissionSubject
]

{ #category : 'resolvers' }
RBACDescriptorSystem >> typeResolverForRBACProfile [

	^FilteredTypeResolver forRootClass: RBACProfile
]

{ #category : 'configuration' }
RBACDescriptorSystem >> useDirectAccessForMapping [


	^false
]
