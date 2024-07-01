export enum ActionOnDuplicate {
	BLOCK = 'block',
	GENERATE_NEW = 'generate_new',
	CREATE_NEW_VERSION = 'create_new_version'
}

export enum ExecutionStatus {
	NOT_RUN = 'n',
	PASSED = 'p',
	FAILED = 'f',
	BLOCKED = 'b'
}

export enum ExecutionType {
	MANUAL = 1,
	AUTOMATED = 2
}

export enum Details {
	FULL = 'full',
	SIMPLE = 'simple',
	VALUE = 'value'
}

export enum TestCaseStatus {
	FINAL = 7,
	FUTURE = 6,
	OBSOLETE = 5,
	REWORK = 4,
	REVIEW_IN_PROGRESS = 3,
	READY_FOR_REVIEW = 2,
	DRAFT = 1,
}

export enum StepAction {
	CREATE = 'create', // If step exist, do nothing
	UPDATE = 'update', // If steps does not exist, create it, else update
	PUSH = 'push'    // Shift down all steps with step number >= step number provided (NOT IMPLEMENTED YET ON TESTLINK)
}

export enum ImportanceLevel {
	HIGH = 3,
	MEDIUM = 2, // Default importance
	LOW = 1
}
