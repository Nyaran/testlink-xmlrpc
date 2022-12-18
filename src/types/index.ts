/* eslint-disable camelcase */
import {ExecutionStatus, ExecutionType} from '../constants';

export interface StepAction {
    foobar: string
}
export interface TLProjectOptions {
    foobar: string
}

export interface StatusResponse {
    id?: number
    status: boolean
    message?: string
}

export interface RequestOptions {
    apiKey?: string
    devKey?: string
}

export interface StatusMsgResponse {
    status: string
    msg: string
}

export interface LinkResponse {
    operation: string
    msg: string
    linkStatus: boolean
}

export interface User {
    firstName: string
    lastName: string
    emailAddress: string
    locale: string
    isActive: boolean
    defaultTestprojectID: string
    globalRoleID: string
    globalRole: string
    tprojectRoles: string
    tplanRoles: string
    login: string
    dbID: string
    loginRegExp: string
}

export interface Project {
    id: number
    notes: string
    color: string
    active: string
    option_reqs: string
    option_priority: string
    option_automation: string
    options: string
    prefix: string
    tc_counter: string
    is_public: string
    issue_tracker_enabled: string
    code_tracker_enabled: string
    reqmgr_integration_enabled: string
    api_key: string
    name: string
    opt: TLProjectOptions
}

export interface BasicResultResponse {
    id: number
    status: boolean
    operation: string
    message: string
    overwrite?: boolean
}

export interface ResultResponse {
    id: number
    name?: string
    name_changed?: boolean
    status: boolean
    operation: string
    additionalInfo?: string | any
    message: string
}

export interface FeatureResponse {
    feature_id: number
    operation: string
    status: boolean
    message: string
}

export interface IssueTracker {
    id: string | number
    name: number
    type: string
    cfg: string
    implementation: string
}

export interface TestSuite {
    id: string
    name: string
    parent_id: string
    details?: string
    node_order?: string
    node_type_id?: string
}

export interface CustomField {
    default_value: string
    display_order: string
    enable_on_design: string
    enable_on_execution: string
    enable_on_testplan_design: string
    id: string
    label: string
    length_max: string
    length_min: string
    location: string
    name: string
    node_id: string
    possible_values: string
    required: string
    show_on_design: string
    show_on_execution: string
    show_on_testplan_design: string
    type: string
    valid_regexp: string
    value: string
}

export interface CustomFieldSimple {
    name: string
    label: string
    type: string
    value: string
}

export interface TestCaseTable {
    id: string
    parent_id: string
    node_type_id: string
    node_order: string
    node_table: string
    name: string
    external_id: string
}

export interface TestCaseSimple {
    id: string
    name: string
    parent_id: string
    tsuite_name: string
    tc_external_id: string
}

export interface TestCaseAlt {
    tcase_name: string
    tcase_id: string
    tc_id: string
    tcversion_id: string
    version: string
    external_id: string
    execution_type: string
    status: string
    feature_id: string
    platform_id: string
    platform_name: string
    execution_order: string
    exec_status: string
    execution_duration: string
    full_external_id: string
    exec_id: string
    tcversion_number: string
    exec_on_build: string
    exec_on_tplan: string
}

export interface TestCase {
    updater_login: string
    author_login: string
    name: string
    node_order: string
    testsuite_id: string
    testcase_id: string
    id: string
    tc_external_id: string
    version: string
    layout: string
    status: string
    summary: string
    preconditions: string
    importance: string
    author_id: string
    creation_ts: string
    updater_id: string
    modification_ts: string
    active: string
    is_open: string
    execution_type: string
    estimated_exec_duration: string
    author_first_name: string
    author_last_name: string
    updater_first_name: string
    updater_last_name: string
    steps: string
    full_tc_external_id: string
}

export interface TestCaseExecution {
    devKey: string
    testcaseexternalid: string
    testprojectid: number
    version: number
    executiontype: number
    testcaseid: number
}

export interface TestPlan {
    id: string
    name: string
    notes: string
    active: string
    is_public: string
    is_open: string
    testproject_id: string
    api_key: string
}

export interface Platform {
    id: string
    name: string
    notes: string
    enable_on_design: string
    enable_on_execution: string
}

export interface TestPlanExecution {
    exec_qty?: number
    platform_id: number
    status: string
}

export interface TestPlanExecutionTypes {
    b: TestPlanExecution
    f: TestPlanExecution
    n: TestPlanExecution
    p: TestPlanExecution
}

export interface TestPlanTotals {
    with_tester: TestPlanExecutionTypes[]
    total: TestPlanExecutionTypes[]
    platforms: string
}

export interface ValidKeywords {
    validKeywords: Record<string, Record<string, string>>
    status_ok: boolean
}

export interface Step {
    step_number: number
    actions: string
    expected_results: string
    execution_type: ExecutionType
    id?: number
    active?: number
}

export interface StepResult {
    step_number: number
    result: ExecutionStatus
    notes: string
}

export interface TestCaseStepsSimple {
    testcaseid: number
    item: string
    version: string
    stepSet: Record<string, string | Step>
}

export interface TestCaseSteps extends TestCaseStepsSimple {
    tcversion_id: string
    stepNumberIDSet: Record<string, string>
    stepID: (string | number)[][]
    feedback: Feedback[]
}

export interface Feedback {
    operation: StepAction
    step_number: number
}

export interface ExecutionResult {
    id: string
    build_id: string
    execution_duration: string
    execution_ts: string
    execution_type: string
    notes: string
    platform_id: string
    status: string
    tcversion_id: string
    tcversion_number: string
    tester_id: string
    testplan_id: string
}

export interface AttachmentResult {
    fk_id: number
    fk_table: string,
    title: string
    description: string
    file_name: string
    file_size: number
    file_type: string
}

export interface Attachment {
    id: string | number
    name: string
    file_type: string
    title: string
    date_added: string
    content: string
}

export interface AssignExecutionResult {
    status: boolean,
    args: {
        testplanid: number
        testcaseexternalid: string
        buildid: number
        platformid: number
        user: string
        action: string
        testcaseid: number
    }
}

export interface BuildExecutionCount {
    raw: BuildExecutionCountRaw,
    table: Record<number, BuildExecutionCountTable>
}

export interface BuildExecutionCountRaw {
    with_tester: Record<number, BuildExecution>
    total: Record<number, BuildExecutionQuantity>
    active_builds: Record<number | string, any>
}

export interface BuildExecution {
    p: BuildExecutionData
    n: BuildExecutionData
    f: BuildExecutionData
    b: BuildExecutionData
}
export interface BuildExecutionData {
    exec_qty: string | number
    build: string | number
    status: string | number
}

export interface BuildExecutionQuantity {
    qty: string | number
    build_id: string | number
}

export interface BuildExecutionCountTable {
    name: string
    notes: string
    total: string | number
    p: string | number
    n: string | number
    f: string | number
    b: string | number
}

export interface Build {
    id: string | number
    testplan_id: string | number
    name: string
    notes: string
    active: string
    is_open: string
    release_date: string
    closed_on_date: string
    creation_ts: string
}

export interface Requirement {
    id: string | number
    req_doc_id: string
}

export interface RequirementCoverage {
    id: string | number
    name: string
    tc_external_id: string | number
    login: string
    creation_ts: string
}