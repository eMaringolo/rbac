Trait {
	#name : #TRBACDescriptionSystem,
	#traits : 'TDescriptorSystemUtilities',
	#classTraits : 'TDescriptorSystemUtilities classTrait',
	#category : #'RBAC-Glorp-Core'
}

{ #category : #'models-convenience' }
TRBACDescriptionSystem >> addUserAttributeTo: aClassModel [

	aClassModel newAttributeNamed: #user type: RBACUser
]

{ #category : #'tables-convenience' }
TRBACDescriptionSystem >> addUserFieldTo: aTable [

	| userId |
	userId := aTable createFieldNamed: 'user_id' type: self foreignKeyFieldType.
	aTable addForeignKeyFrom: userId to: ((self tableNamed: 'RBACUSER') fieldNamed: 'id')
]

{ #category : #models }
TRBACDescriptionSystem >> classModelForRBACGroup: aClassModel [

	self addNamedModelAttributesTo: aClassModel.
	aClassModel newAttributeNamed: #roles collectionOf: RBACRole.
	aClassModel newAttributeNamed: #members collectionOf: RBACProfile.
	self addVersioningAttributesTo: aClassModel
]

{ #category : #models }
TRBACDescriptionSystem >> classModelForRBACMenu: aClassModel [
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

{ #category : #models }
TRBACDescriptionSystem >> classModelForRBACOperation: aClassModel [
	self addNamedModelAttributesTo: aClassModel.
	aClassModel newAttributeNamed: #subjectType.
	aClassModel newAttributeNamed: #tag.
	aClassModel newAttributeNamed: #description.
]

{ #category : #models }
TRBACDescriptionSystem >> classModelForRBACPermission: aClassModel [

	aClassModel newAttributeNamed: #id.
	aClassModel newAttributeNamed: #role type: RBACRole.
	aClassModel newAttributeNamed: #bits.	
	aClassModel newAttributeNamed: #target type: RBACPermissionSubject.
]

{ #category : #models }
TRBACDescriptionSystem >> classModelForRBACProfilePreference: aClassModel [

	aClassModel newAttributeNamed: #owner type: RBACProfile.
	aClassModel newAttributeNamed: #section .
	aClassModel newAttributeNamed: #name.	
	aClassModel newAttributeNamed: #value.
]

{ #category : #models }
TRBACDescriptionSystem >> classModelForRBACRole: aClassModel [
	self addNamedModelAttributesTo: aClassModel.
	aClassModel newAttributeNamed: #tag.
	aClassModel newAttributeNamed: #users collectionOf: RBACUser.
	aClassModel
		newAttributeNamed: #permissions
		collectionOf: RBACPermission
]

{ #category : #models }
TRBACDescriptionSystem >> classModelForRBACUser: aClassModel [

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

{ #category : #'mappings-convenience' }
TRBACDescriptionSystem >> configureRBACPermissionSubjectDescriptor: aDescriptor [

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

{ #category : #'mappings-convenience' }
TRBACDescriptionSystem >> configureRBACProfileDescriptor: aDescriptor [

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

{ #category : #mappings }
TRBACDescriptionSystem >> descriptorForRBACGroup: aDescriptor [

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

{ #category : #mappings }
TRBACDescriptionSystem >> descriptorForRBACMenu: aDescriptor [

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

{ #category : #mappings }
TRBACDescriptionSystem >> descriptorForRBACOperation: aDescriptor [

	| table |
	table := self tableNamed: 'RBACPERMISSIONSUBJECT'.
	aDescriptor table: table.
	(self typeResolverFor: RBACPermissionSubject)
		register: aDescriptor
		keyedBy: 'checkpoint'
		field: (table fieldNamed: 'subjectType').
	self configureRBACPermissionSubjectDescriptor: aDescriptor
]

{ #category : #mappings }
TRBACDescriptionSystem >> descriptorForRBACPermission: aDescriptor [
	| table |
	table := self tableNamed: 'RBACPERMISSION'.
	aDescriptor table: table.
	self addModelPartMappingsTo: aDescriptor table:  table ownerClass: RBACRole.
	(aDescriptor newMapping: DirectMapping) from: #bits to: (table fieldNamed: 'bits').	
	(aDescriptor newMapping: OneToOneMapping)
		attributeName: #target;
		referenceClass: RBACPermissionSubject.
]

{ #category : #mappings }
TRBACDescriptionSystem >> descriptorForRBACPermissionSubject: aDescriptor [

	| table |
	table := self tableNamed: 'RBACPERMISSIONSUBJECT'.
	aDescriptor table: table.
	(self typeResolverFor: RBACPermissionSubject) register: aDescriptor abstract: true.
	self configureRBACPermissionSubjectDescriptor: aDescriptor
]

{ #category : #mappings }
TRBACDescriptionSystem >> descriptorForRBACProfile: aDescriptor [

	| table |
	table := self tableNamed: 'RBACPROFILE'.
	aDescriptor table: table.
	(self typeResolverFor: RBACProfile) register: aDescriptor abstract: true.
	self configureRBACProfileDescriptor: aDescriptor
]

{ #category : #mappings }
TRBACDescriptionSystem >> descriptorForRBACProfilePreference: aDescriptor [
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

{ #category : #mappings }
TRBACDescriptionSystem >> descriptorForRBACRole: aDescriptor [
	| table |
	table := self tableNamed: 'RBACROLE'.
	aDescriptor table: table.
	self addNamedModelMappingsTo: aDescriptor table: table.
	(aDescriptor newMapping: DirectMapping)
		from: #tag
		to: (table fieldNamed: 'tag').
	(aDescriptor newMapping: ToManyMapping)
		attributeName: #permissions;
		referenceClass: RBACPermission;
		beExclusive
]

{ #category : #mappings }
TRBACDescriptionSystem >> descriptorForRBACUser: aDescriptor [
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

{ #category : #configuration }
TRBACDescriptionSystem >> schemaScriptFor: classes [

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

{ #category : #configuration }
TRBACDescriptionSystem >> schemaStatementsFor: classes [

	| system statements constraints relationTables tables |
	system := self.
	statements := OrderedCollection new.
	tables := Set new.
	relationTables := Set new.
	constraints := Set new.
	classes do: 
			[:class |
			tables addAll: (system descriptorFor: class) tables.
			((system descriptorFor: class) mappings contents
				select: [:each | (each isKindOf: RelationshipMapping) and: [each usesLinkTable]])
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
	^statements reject: [:each | each trimBoth isEmpty]
]

{ #category : #'tables-relations' }
TRBACDescriptionSystem >> tableForRBACGROUP_ON_RBACUSER: aTable [
	| userKey groupKey |
	groupKey := aTable
		createFieldNamed: 'group_id'
		type: self foreignKeyFieldType.
	groupKey bePrimaryKey.
	aTable
		addForeignKeyFrom: groupKey
		to: ((self tableNamed: 'RBACPROFILE') fieldNamed: 'id').
	userKey := aTable
		createFieldNamed: 'user_id'
		type: self foreignKeyFieldType.
	userKey bePrimaryKey.
	aTable
		addForeignKeyFrom: userKey
		to: ((self tableNamed: 'RBACPROFILE') fieldNamed: 'id')
]

{ #category : #tables }
TRBACDescriptionSystem >> tableForRBACPERMISSION: aTable [
	| target_id |
	self addIdFieldTo: aTable.
	self
		addModelPartFieldsTo: aTable
		ownerTable: (self tableNamed: 'RBACROLE').
	target_id := aTable
		createFieldNamed: 'target_id'
		type: self primaryKeyFieldType.
	aTable
		addForeignKeyFrom: target_id
		to: ((self tableNamed: 'RBACPERMISSIONSUBJECT') fieldNamed: 'id').
	aTable createFieldNamed: 'bits' type: self platform int8.
	self addVersioningFieldsTo: aTable
]

{ #category : #tables }
TRBACDescriptionSystem >> tableForRBACPERMISSIONSUBJECT: aTable [
	| parentId |
	self addTableFieldsForNamedModel: aTable.
	parentId := aTable
		createFieldNamed: 'parent_id'
		type: self primaryKeyFieldType.
	aTable
		createFieldNamed: 'subjectType'
		type: (self platform varChar: 100).
	aTable
		addForeignKeyFrom: parentId
		to: ((self tableNamed: 'RBACPERMISSIONSUBJECT') fieldNamed: 'id').
	aTable createFieldNamed: 'tag' type: (self platform varchar: 50).
	aTable
		createFieldNamed: 'description'
		type: (self platform varChar: 100).
	aTable createFieldNamed: 'icon' type: (self platform varchar: 50).
	aTable createFieldNamed: 'priority' type: self platform integer.
	self addVersioningFieldsTo: aTable
]

{ #category : #tables }
TRBACDescriptionSystem >> tableForRBACPROFILE: aTable [
	self addTableFieldsForNamedModel: aTable.
	aTable
		createFieldNamed: 'profileType'
		type: (self platform varChar: 100).
	aTable
		createFieldNamed: 'password'
		type: (self platform varChar: 2048).
	aTable createFieldNamed: 'salt' type: (self platform varChar: 2048).
	aTable
		createFieldNamed: 'description'
		type: (self platform varChar: 100).
	aTable
		createFieldNamed: 'emailAddress'
		type: (self platform varChar: 200).
	aTable
		createFieldNamed: 'phoneNumber'
		type: (self platform varChar: 20).
	aTable
		createFieldNamed: 'displayName'
		type: (self platform varChar: 40).
	self addVersioningFieldsTo: aTable
]

{ #category : #tables }
TRBACDescriptionSystem >> tableForRBACPROFILEPREFERENCE: aTable [
	| ownerId ownerTable |
	ownerTable := self tableNamed: 'RBACPROFILE'.
	ownerId := (aTable
		createFieldNamed: 'owner_id'
		type: self primaryKeyFieldType) bePrimaryKey.
	aTable addForeignKeyFrom: ownerId to: (ownerTable fieldNamed: 'id').
	(aTable
		createFieldNamed: 'section'
		type: (self platform varchar: 100)) bePrimaryKey.
	(aTable createFieldNamed: 'name' type: (self platform varchar: 100))
		bePrimaryKey.
	aTable createFieldNamed: 'value' type: (self platform varchar: 1000).
	self addVersioningFieldsTo: aTable
]

{ #category : #'tables-relations' }
TRBACDescriptionSystem >> tableForRBACPROFILE_ON_RBACROLE: aTable [

	| profileKey roleKey |
	profileKey := aTable createFieldNamed: 'profile_id' type: self foreignKeyFieldType.
	profileKey bePrimaryKey.
	aTable addForeignKeyFrom: profileKey to: ((self tableNamed: 'RBACPROFILE') fieldNamed: 'id').
	roleKey := aTable createFieldNamed: 'role_id' type: self foreignKeyFieldType.
	roleKey bePrimaryKey.
	aTable addForeignKeyFrom: roleKey  to: ((self tableNamed: 'RBACROLE') fieldNamed: 'id').
]

{ #category : #tables }
TRBACDescriptionSystem >> tableForRBACROLE: aTable [
	self addTableFieldsForNamedModel: aTable.
	aTable createFieldNamed: 'tag' type: (self platform varChar: 100).
	self addVersioningFieldsTo: aTable
]

{ #category : #'tables-relations' }
TRBACDescriptionSystem >> tableForRBACROLE_ON_RBACPERMISSION: aTable [

	| userKey permissionKey |
	userKey := aTable createFieldNamed: 'role_id' type: self foreignKeyFieldType.
	userKey bePrimaryKey.
	aTable addForeignKeyFrom: userKey to: ((self tableNamed: 'RBACROLE') fieldNamed: 'id').
	permissionKey := aTable createFieldNamed: 'permission_id' type: self foreignKeyFieldType.
	permissionKey bePrimaryKey.
	aTable addForeignKeyFrom: permissionKey  to: ((self tableNamed: 'RBACPERMISSION') fieldNamed: 'id').
]

{ #category : #resolvers }
TRBACDescriptionSystem >> typeResolverForRBACPermissionSubject [

	^FilteredTypeResolver forRootClass: RBACPermissionSubject
]

{ #category : #resolvers }
TRBACDescriptionSystem >> typeResolverForRBACProfile [

	^FilteredTypeResolver forRootClass: RBACProfile
]

{ #category : #configuration }
TRBACDescriptionSystem >> useDirectAccessForMapping [


	^false
]
