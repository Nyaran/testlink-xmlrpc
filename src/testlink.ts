/**
 * @license
 * This file is part of testlink-xmlrpc.
 *
 * testlink-xmlrpc is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * testlink-xmlrpc is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with testlink-xmlrpc. If not, see <https://www.gnu.org/licenses/>.
 *
 * @author Luis Zurro de Cos <luiszurrodecos@gmail.com>
 */
import xmlrpc from 'xmlrpc';
import * as ApiTypes from './types';
import {
    ActionOnDuplicate,
    Details,
    ExecutionStatus,
    ExecutionType,
    ImportanceLevel,
    StepAction,
    TestCaseStatus
} from './constants';
import {MandatoryFields} from './decorators';

export default class TestLink {
    private rpcClient: xmlrpc.Client | undefined
    private readonly secure: boolean
    private readonly host: string
    private readonly port: number
    private readonly rpcPath: string
    private readonly apiKey: string | undefined

    /**
     * Class constructor
     *
     * @param options - Configuration parameters
     * @param options.secure - Use or not secure connection. If set to true, use http and port 443 if a port was not defined else uses http and port 80.
     * @param options.host - Hostname or IP where TestLink is hosted.
     * @param options.port - Hostname or IP where TestLink is hosted.
     * @param options.rpcPath - Path to TestLink rpc client.
     * @param options.apiKey - The api key to interact with TestLink.
     * @param autoConnect - If set to true, the connection is established on constructor, else a call to connect() method is required.
     */
    constructor({
        secure = false,
        host = 'localhost',
        port = secure ? 443 : 80,
        path = '/',
        rpcPath = 'lib/api/xmlrpc/v1/xmlrpc.php',
        apiKey,
        autoConnect = true,
    }: { secure?: boolean, host?: string, port?: number, path?: string, rpcPath?: string, apiKey?: string, autoConnect?: boolean } = {}) {
        this.host = host;
        this.secure = secure;
        this.port = port;
        this.rpcPath = `${path}${path.endsWith('/') ? '' : '/'}${rpcPath}`;
        this.apiKey = apiKey;

        if (autoConnect)
            this.connect();
    }

    /**
     * Establish connection
     */
    connect(): void {
        let options = { host: this.host, port: this.port, path: this.rpcPath };
        this.rpcClient = this.secure ?
            xmlrpc.createSecureClient(options):
            xmlrpc.createClient(options);
    }

    /* Attachments */

    /**
     * Uploads an attachment for an execution.
     *
     * @param options Options
     * @param options.executionid The Test Case execution id
     * @param [options.title] Attachment's title
     * @param [options.description] Attachment's description
     * @param options.filename Attachment's file name (E.g. screenshot.png)
     * @param options.filetype Attachment's mime type (E.g.: image/png)
     * @param options.content Attachment's content in BASE64
     */
    @MandatoryFields(['executionid', 'filename', 'filetype', 'content'])
    uploadExecutionAttachment(options: ApiTypes.RequestOptions & {
        executionid: string | number
        title?: string
        description?: string
        filename: string
        filetype: string
        content: string
    }): Promise<ApiTypes.AttachmentResult> {
        return this._performRequest('uploadExecutionAttachment', options);
    }

    /**
     * Uploads an attachment for a Requirement Specification.
     *
     * @param options Options
     * @param options.reqspecid The Requirement Specification ID
     * @param [options.title] Attachment's title
     * @param [options.description] Attachment's description
     * @param options.filename Attachment's file name (E.g. screenshot.png)
     * @param options.filetype Attachment's mime type (E.g.: image/png)
     * @param options.content Attachment's content in BASE64
     */
    @MandatoryFields(['reqspecid', 'filename', 'filetype', 'content'])
    uploadRequirementSpecificationAttachment(options: ApiTypes.RequestOptions & {
        reqspecid: string | number
        title?: string
        description?: string
        filename: string
        filetype: string
        content: string
    }): Promise<ApiTypes.AttachmentResult> {
        return this._performRequest('uploadRequirementSpecificationAttachment', options);
    }

    /**
     * Uploads an attachment for a Requirement.
     *
     * @param options Options
     * @param options.requirementid The Requirement ID
     * @param [options.title] Attachment's title
     * @param [options.description] Attachment's description
     * @param options.filename Attachment's file name (E.g. screenshot.png)
     * @param options.filetype Attachment's mime type (E.g.: image/png)
     * @param options.content Attachment's content in BASE64
     */
    @MandatoryFields(['requirementid', 'filename', 'filetype', 'content'])
    uploadRequirementAttachment(options: ApiTypes.RequestOptions & {
        requirementid: string | number
        title?: string
        description?: string
        filename: string
        filetype: string
        content: string
    }): Promise<ApiTypes.AttachmentResult> {
        return this._performRequest('uploadRequirementAttachment', options);
    }

    /**
     * Uploads an attachment for a Test Project.
     *
     * @param options Options
     * @param options.testprojectid The Test Project ID
     * @param [options.title] Attachment's title
     * @param [options.description] Attachment's description
     * @param options.filename Attachment's file name (E.g. screenshot.png)
     * @param options.filetype Attachment's mime type (E.g.: image/png)
     * @param options.content Attachment's content in BASE64
     */
    @MandatoryFields(['testprojectid', 'filename', 'filetype', 'content'])
    uploadTestProjectAttachment(options: ApiTypes.RequestOptions & {
        testprojectid: string | number
        title?: string
        description?: string
        filename: string
        filetype: string
        content: string
    }): Promise<ApiTypes.AttachmentResult> {
        return this._performRequest('uploadTestProjectAttachment', options);
    }

    /**
     * Uploads an attachment for a Test Suite.
     *
     * @param options Options
     * @param options.testsuiteid The Test Suite ID
     * @param [options.title] Attachment's title
     * @param [options.description] Attachment's description
     * @param options.filename Attachment's file name (E.g. screenshot.png)
     * @param options.filetype Attachment's mime type (E.g.: image/png)
     * @param options.content Attachment's content in BASE64
     */
    @MandatoryFields(['testsuiteid', 'filename', 'filetype', 'content'])
    uploadTestSuiteAttachment(options: ApiTypes.RequestOptions & {
        testsuiteid: string | number
        title?: string
        description?: string
        filename: string
        filetype: string
        content: string
    }): Promise<ApiTypes.AttachmentResult> {
        return this._performRequest('uploadTestSuiteAttachment', options);
    }

    /**
     * Uploads an attachment for a Test Case.
     *
     * @param options Options
     * @param options.testcaseid The Test Case ID
     * @param [options.version] The Test Case version.
     * @param [options.title] Attachment's title
     * @param [options.description] Attachment's description
     * @param options.filename Attachment's file name (E.g. screenshot.png)
     * @param options.filetype Attachment's mime type (E.g.: image/png)
     * @param options.content Attachment's content in BASE64
     */
    @MandatoryFields(['testcaseid', 'version', 'filename', 'filetype', 'content'])
    uploadTestCaseAttachment(options: ApiTypes.RequestOptions & {
        testcaseid: string | number
        version: string | number
        title?: string
        description?: string
        filename: string
        filetype: string
        content: string
    }): Promise<ApiTypes.AttachmentResult> {
        return this._performRequest('uploadTestCaseAttachment', options);
    }

    /**
     * Uploads an attachment for specified table. You must specify the table that
     * the attachment is connected (nodes_hierarchy, builds, etc) and the foreign
     * key id in this table.
     *
     * @param options Options
     * @param options.fkid Attachment's Foreign Key ID
     * @param options.fktable Attachment's Foreign Key Table
     * @param [options.title] Attachment's title
     * @param [options.description] Attachment's description
     * @param options.filename Attachment's file name (E.g. screenshot.png)
     * @param options.filetype Attachment's mime type (E.g.: image/png)
     * @param options.content Attachment's content in BASE64
     */
    @MandatoryFields(['fkid', 'fktable', 'filename', 'filetype', 'content'])
    uploadAttachment(options: ApiTypes.RequestOptions & {
        fkid: number
        fktable: string
        title?: string
        description?: string
        filename: string
        filetype: string
        content: string
    }): Promise<ApiTypes.AttachmentResult> {
        return this._performRequest('uploadAttachment', options);
    }

    /**
     * Gets attachments for specified test suite.
     *
     * @param options Options
     * @param options.testsuiteid: Test Suite id.
     */
    @MandatoryFields(['testsuiteid'])
    getTestSuiteAttachments(options: ApiTypes.RequestOptions & {
        testsuiteid: string | number
    }): Promise<Record<number | string, ApiTypes.Attachment>> {
        return this._performRequest('getTestSuiteAttachments', options);
    }

    /* Builds */

    /**
     * Creates a new build for a specific test plan
     *
     * @param options Options
     * @param options.testplanid TestPlan id to associate with.
     * @param options.buildname Build name.
     * @param options.buildnotes Build description
     * @param options.active Set if is active
     * @param options.open Set if is open
     * @param options.releasedate Release date in format YYYY-MM-DD
     * @param [options.copytestersfrombuild] Build id to copy from
     */
    @MandatoryFields(['testplanid', 'buildname', 'buildnotes', 'active', 'open', 'releasedate'])
    createBuild(options: ApiTypes.RequestOptions & {
        testplanid: number
        buildname: string
        buildnotes: string
        active: boolean
        open: boolean
        releasedate: string
        copytestersfrombuild?: number
    }): Promise<ApiTypes.BasicResultResponse[]> {
        return this._performRequest('createBuild', options);
    }

    /**
     * Close a build
     *
     * @param options Options
     * @param options.buildid Build id.
     */
    @MandatoryFields(['buildid'])
    closeBuild(options: ApiTypes.RequestOptions & {
        buildid: string | number
    }): Promise<ApiTypes.BasicResultResponse[]> {
        return this._performRequest('closeBuild', options);
    }

    /**
     * @param options Options
     */
    @MandatoryFields(['testplanid'])
    getExecCountersByBuild(options: ApiTypes.RequestOptions & {
        testplanid: string | number
    }): Promise<ApiTypes.BuildExecutionCount> {
        return this._performRequest('getExecCountersByBuild', options);
    }

    /**
     * Gets a list of builds within a test plan
     *
     * @param options Options
     * @param options.testplanid Test Plan id
     */
    @MandatoryFields(['testplanid'])
    getBuildsForTestPlan(options: ApiTypes.RequestOptions & {
        testplanid: number
    }): Promise<ApiTypes.Build[]> {
        return this._performRequest('getBuildsForTestPlan', options);
    }

    /**
     * Gets the latest build by choosing the maximum build id for a specific test plan
     *
     * @param options Options
     * @param options.testplanid Test Plan id
     */
    @MandatoryFields(['testplanid'])
    getLatestBuildForTestPlan(options: ApiTypes.RequestOptions & {
        testplanid: number
    }): Promise<ApiTypes.Build> {
        return this._performRequest('getLatestBuildForTestPlan', options);
    }

    /**
     * Update value of Custom Field with scope='design' for a given Build
     *
     * @param options Options
     * @param options.buildid Build id
     * @param options.testprojectid Project id
     * @param options.testplanid Test plan id
     * @param options.customfields Map containing a key-value object with custom fields.
     */
    @MandatoryFields(['buildid', 'testprojectid', 'customfields', 'testplanid'])
    updateBuildCustomFieldsValues(options: ApiTypes.RequestOptions & {
        buildid: string | number
        testprojectid: string | number
        testplanid: string | number
        customfields: Record<number, string>
    }): Promise<ApiTypes.StatusMsgResponse[]> {
        return this._performRequest('updateBuildCustomFieldsValues', options);
    }

    /* Executions */

    /**
     * Gets the result of LAST EXECUTION for a particular testcase on a test plan.
     * If there are no filter criteria regarding platform and build,
     * result will be get WITHOUT checking for a particular platform and build.
     *
     * @param options Options
     * @param options.testplanid Test Plan id.
     * @param [options.testcaseid] Test Case id. If not present, testcaseexternalid must be present.
     * @param [options.testcaseexternalid] Test Case external id. If not present, testcaseid must be present.
     * @param [options.platformid] Platform id number.
     * @param [options.platformname] Platform name.
     * @param [options.buildid] Build id number.
     * @param [options.buildname] Build name.
     * @param [options.options]
     * @param [options.options.getBugs]
     */
    @MandatoryFields(['testplanid', ['testcaseid', 'testcaseexternalid']])
    getLastExecutionResult(options: ApiTypes.RequestOptions & {
        testplanid: string | number
        testcaseid?: string
        testcaseexternalid?: string
        platformid?: number
        platformname?: string
        buildid?: number
        buildname?: string
        options?: {
            getBugs?: boolean
        }
    }): Promise<ApiTypes.ExecutionResult[]> {
        return this._performRequest('getLastExecutionResult', options);
    }


    /**
     * Delete an execution
     *
     * @param options
     * @param options.executionid
     */
    @MandatoryFields(['executionid'])
    deleteExecution(options: ApiTypes.RequestOptions & {
        executionid: number
    }): Promise<ApiTypes.BasicResultResponse[]> {
        return this._performRequest('deleteExecution', options);
    }

    /**
     * Gets a set of EXECUTIONS for a particular testcase on a test plan.
     *
     * @param options Options
     * @param options.testplanid Test Plan id
     * @param [options.testcaseid] Test Case id. If not present, testcaseexternalid must be present.
     * @param [options.testcaseexternalid] Test Case external id. If not present, testcaseid must be present.
     * @param [options.platformid] Platform id.
     * @param [options.platformname] Platform name.
     * @param [options.buildid] Build id number.
     * @param [options.buildname] Build name.
     * @param [options.options] options['getOrderDescending'] false(=ascending,default)
     */
    @MandatoryFields(['testplanid', ['testcaseid', 'testcaseexternalid']])
    getExecutionSet(options: ApiTypes.RequestOptions & {
        testplanid: number
        testcaseid?: string
        testcaseexternalid?: string
        platformid?: number
        platformname?: string
        buildid?: number
        buildname?: string
        options?: number
    }): Promise<Record<string, ApiTypes.ExecutionResult>> {
        return this._performRequest('getExecutionSet', options);
    }

    /**
     * Gets ALL EXECUTIONS for a particular testcase on a test plan.
     * If there are no filter criteria regarding platform and build,
     * result will be get WITHOUT checking for a particular platform and build.
     *
     * @param options Options
     * @param options.testplanid
     * @param [options.testcaseid] Test Case id. If not present, testcaseexternalid must be present.
     * @param [options.testcaseexternalid] Test Case external id. If not present, testcaseid must be present.
     * @param [options.platformid] Platform id. If not present and Test Case has platforms, platformname must be present.
     * @param [options.platformname] Platform name. If not present and Test Case has platforms, platformid must be present.
     * @param [options.buildid] Build id number. If this and buildname are not specified, the latest build will be used.
     * @param [options.buildname] Build name. If not present, buildid must be present.
     * @param [options.options] options['getBugs'] = true / false
     * @param [options.options.getBugs] Get, or not, an array of bugs
     */
    @MandatoryFields(['testplanid', ['testcaseid', 'testcaseexternalid']])
    getAllExecutionsResults(options: ApiTypes.RequestOptions & {
        testplanid: number
        testcaseid?: string
        testcaseexternalid?: string
        platformid?: number
        platformname?: string
        buildid?: number
        buildname?: string
        options?: number
    }): Promise<Record<number | string, ApiTypes.ExecutionResult>> {
        return this._performRequest('getAllExecutionsResults', options);
    }

    /* Issue Trackers */

    /**
     * Get Issue Tracker System by name
     *
     * @param options Options
     * @param options.itsname Issue Tracker System name
     */
    @MandatoryFields(['itsname'])
    getIssueTrackerSystem(options: ApiTypes.RequestOptions & {
        itsname: string
    }): Promise<ApiTypes.IssueTracker> {
        return this._performRequest('getIssueTrackerSystem', options);
    }

    /* Miscellaneous */

    /**
     * @see {@see sayHello}
     */
    ping(): Promise<string> {
        return this._performRequest('ping');
    }

    /**
     * Lets you see if the server is up and running
     */
    sayHello(): Promise<string> {
        return this._performRequest('sayHello');
    }

    /**
     * Repeats a message back
     *
     * @param options
     * @param options.str String to be said
     */
    @MandatoryFields(['str'])
    repeat(options: ApiTypes.RequestOptions & { str: string }): Promise<string> {
        return this._performRequest('repeat', options);
    }

    /**
     * Returns the current TestLink version
     */
    testLinkVersion(): Promise<string> {
        return this._performRequest('testLinkVersion');
    }

    /**
     * Gives basic information about the API
     */
    about(): Promise<string> {
        return this._performRequest('about');
    }

    /**
     * Check if Developer Key exists.
     *
     * @param options
     * @param [options.devKey] TestLink API key. If not specified, the devKey used in constructor will be used.
     */
    checkDevKey(options?: ApiTypes.RequestOptions & {
        devKey?: string
    }): Promise<boolean> {
        return this._performRequest('checkDevKey', options);
    }

    /**
     * Turn on/off testMode. This method is meant primarily for testing and debugging during development
     *
     * @param options
     * @param options.testmode
     */
    @MandatoryFields(['testmode'])
    setTestMode(options?: ApiTypes.RequestOptions & {
        testmode: boolean
    }): Promise<boolean> {
        return this._performRequest('setTestMode', options);
    }

    /**
     * Gets attachments for specified test case.
     *
     * @param options Options
     * @param options.nodeid can be just a single node or an array of INTERNAL(DB) ID
     */
    @MandatoryFields(['nodeid'])
    getFullPath(options: ApiTypes.RequestOptions & {
        nodeid?: (string | number)[] | string | number
    }): Promise<Record<number, string[]>> {
        return this._performRequest('getFullPath', options);
    }

    /* Platforms */

    /**
     * Creates a platform
     *
     * @param options Options
     * @param options.testprojectname Test project name
     * @param options.platformname New platform name
     * @param options.notes New platform description
     */
    @MandatoryFields(['testprojectname', 'platformname', 'notes'])
    createPlatform(options: ApiTypes.RequestOptions & {
        testprojectname: string
        platformname: string
        notes: string
    }): Promise<ApiTypes.StatusResponse> {
        return this._performRequest('createPlatform', options);
    }

    /**
     * Gets a list of platforms within a project
     *
     * @param options Options
     * @param options.testprojectid Project ID
     */
    @MandatoryFields(['testprojectid'])
    getProjectPlatforms(options: ApiTypes.RequestOptions & {
        testprojectid: string | number
    }): Promise<Record<number, string>> {
        return this._performRequest('getProjectPlatforms', options);
    }

    /**
     * Returns the list of platforms associated to a given test plan
     *
     * @param options Options
     * @param options.testplanid
     */
    @MandatoryFields(['testplanid'])
    getTestPlanPlatforms(options: ApiTypes.RequestOptions & {
        testplanid: number
    }): Promise<ApiTypes.Platform[]> {
        return this._performRequest('getTestPlanPlatforms', options);
    }

    /* Projects */

    /**
     * Gets a list of all projects
     */
    getProjects(): Promise<ApiTypes.Project[]> {
        return this._performRequest('getProjects');
    }

    /**
     * Create Test Project
     *
     * @param options
     * @param options.testprojectname New Project name
     * @param options.testcaseprefix New Project prefix
     * @param [options.notes] New Project description
     * @param [options.options] The new Project options
     * @param [options.options.requirementsEnabled] Enable, or not requirements
     * @param [options.options.testPriorityEnabled] Enable, or not test priority
     * @param [options.options.automationEnabled] Enable, or not automation
     * @param [options.options.inventoryEnabled] Enable, or not inventory
     * @param [options.active] Set Project as active or not
     * @param [options.public] Set Project as public or not
     * @param [options.itsname] Issue Tracker name
     * @param [options.itsenabled] Issue Tracker enabled or not
     */
    @MandatoryFields(['testprojectname', 'testcaseprefix'])
    createTestProject(options: ApiTypes.RequestOptions & {
        testprojectname: string
        testcaseprefix: string
        notes?: string
        options?: {
            requirementsEnabled?: boolean
            testPriorityEnabled?: boolean
            automationEnabled?: boolean
            inventoryEnabled?: boolean
        }
        active?: boolean
        public?: boolean
        itsname?: string
        itsenabled?: boolean
    }): Promise<ApiTypes.ResultResponse[]> {
        return this._performRequest('createTestProject', options);
    }

    /**
     * Delete a test project and all related link to other items
     *
     * @param options
     * @param options.prefix Project prefix
     */
    @MandatoryFields(['prefix'])
    deleteTestProject(options: ApiTypes.RequestOptions & {
        prefix: string
    }): Promise<ApiTypes.StatusResponse[]> {
        return this._performRequest('deleteTestProject', options);
    }

    /**
     * Gets a list of keywords within a project
     *
     * @param options
     * @param options.testprojectid Project id
     */
    @MandatoryFields(['testprojectid'])
    getProjectKeywords(options: ApiTypes.RequestOptions & { testprojectid: string | number }): Promise<Record<number, string>[]> {
        return this._performRequest('getProjectKeywords', options);
    }

    /**
     * Gets info about target test project
     *
     * @param options
     * @param options.testprojectname Project name
     */
    @MandatoryFields(['testprojectname'])
    getTestProjectByName(options: ApiTypes.RequestOptions & {
        testprojectname: string
    }): Promise<ApiTypes.Project> {
        return this._performRequest('getTestProjectByName', options);
    }

    /* Requirements */

    /**
     * Gets a Custom Field of a Requirement Specification in Design Scope.
     *
     * @param options Options
     * @param options.customfieldname: Custom field name
     * @param options.testprojectid: Project id
     * @param options.reqspecid: Requirement Specification id
     */
    @MandatoryFields(['customfieldname', 'testprojectid', 'reqspecid'])
    getReqSpecCustomFieldDesignValue(options: ApiTypes.RequestOptions & {
        customfieldname: string
        testprojectid: string | number
        reqspecid: string | number
    }): Promise<ApiTypes.CustomField> {
        return this._performRequest('getReqSpecCustomFieldDesignValue', options);
    }

    /**
     * Gets a Custom Field of a Requirement in Design Scope.
     *
     * @param options Options
     * @param options.customfieldname: Custom field name
     * @param options.testprojectid: Project id
     * @param options.requirementid: Requirement id
     */
    @MandatoryFields(['customfieldname', 'testprojectid', 'requirementid'])
    getRequirementCustomFieldDesignValue(options: ApiTypes.RequestOptions & {
        customfieldname: string
        testprojectid: string | number
        requirementid: string | number
    }): Promise<ApiTypes.CustomField> {
        return this._performRequest('getRequirementCustomFieldDesignValue', options);
    }

    /**
     * Get requirements
     *
     * @param options Options
     * @param options.testprojectid Project id
     * @param [options.testplanid] Test Plan id
     * @param [options.platformid] Platform id. Mandatory if project has platforms
     *
     */
    @MandatoryFields(['testprojectid'])
    getRequirements(options: ApiTypes.RequestOptions & {
        testprojectid: string | number
        testplanid?: string | number
        platformid?: string | number
    }): Promise<ApiTypes.Requirement[]> {
        return this._performRequest('getRequirements', options);
    }

    /**
     * Get requirement coverage. Retrieve the test cases associated to a requirement
     *
     * @param options Options
     * @param options.testprojectid Project id
     * @param options.requirementdocid Requirement doc id
     *
     */
    @MandatoryFields(['testprojectid', 'requirementdocid'])
    getReqCoverage(options: ApiTypes.RequestOptions & {
        testprojectid: string | number
        requirementdocid: string | number
    }): Promise<ApiTypes.RequirementCoverage[]> {
        return this._performRequest('getReqCoverage', options);
    }

    /* Test Cases */

    /**
     * Report a Test Case result
     *
     * @param options Options.
     * @param [options.testcaseid] Test Case id. If not present, testcaseexternalid must be present.
     * @param [options.testcaseexternalid] Test Case external id. If not present, testcaseid must be present.
     * @param options.testplanid TestPlan id to associate with.
     * @param options.status Execution status
     * @param options.steps Array of steps.
     * @param options.steps[].step_number Step number.
     * @param options.steps[].result Step execution result
     * @param options.steps[].notes Step execution notes.
     * @param [options.buildid] Build id number. If this and buildname are not specified, the latest build will be used.
     * @param [options.buildname] Build name. If this and buildid are not specified, the latest build will be used.
     * @param [options.notes] Execution notes.
     * @param [options.execduration] Execution duration in minutes.
     * @param [options.guess=true] Defining whether to guess optinal params or require them explicitly, default is true (guess by default).
     * @param [options.bugid] Bug id in the configured tracker system.
     * @param [options.platformid] Platform id, if not present platformname must be.
     * @param [options.platformname] Platform id, if not present platformid must be.
     * @param [options.customfields] Map containing a key-value object with custom fields.
     * @param [options.overwrite] Overwrite, or not, the last execution if exists.
     * @param [options.user] TestLink user name who executed the test.
     * @param [options.timestamp] If not present, current time will be used. (Format: YYYY-MM-DD HH:MM:SS).
     */
    @MandatoryFields([['testcaseid', 'testcaseexternalid'], 'testplanid', 'status', 'steps'])
    reportTCResult(options: ApiTypes.RequestOptions & {
        testcaseid?: string
        testcaseexternalid?: string
        testplanid: number
        status: ExecutionStatus
        steps: ApiTypes.StepResult[]
        buildid?: number
        buildname?: string
        notes?: string
        execduration?: number
        guess?: boolean
        bugid?: string
        platformid?: string
        platformname?: string
        customfields?: ApiTypes.CustomField[]
        overwrite?: boolean
        user?: string
        timestamp?: string
    }): Promise<ApiTypes.BasicResultResponse[]> {
        return this._performRequest('reportTCResult', options);
    }

    /**
     * @see {@see reportTCResult}
     * @param options @see {@see reportTCResult#options}
     */
    @MandatoryFields([['testcaseid', 'testcaseexternalid'], 'testplanid', 'status', 'steps'])
    setTestCaseExecutionResult(options: ApiTypes.RequestOptions & {
        testcaseid?: string
        testcaseexternalid?: string
        testplanid: number
        status: ExecutionStatus
        steps: ApiTypes.StepResult[]
        buildid?: number
        buildname?: string
        notes?: string
        execduration?: number
        guess?: boolean
        bugid?: string
        platformid?: string
        platformname?: string
        customfields?: ApiTypes.CustomField[]
        overwrite?: boolean
        user?: string
        timestamp?: string
    }): Promise<ApiTypes.BasicResultResponse[]> {
        return this._performRequest('setTestCaseExecutionResult', options);
    }

    /**
     * Creates a TestCase
     *
     * @param options Options
     * @param options.testcasename New TestCase name
     * @param options.testsuiteid Parent TestSuite id
     * @param options.testprojectid Project id
     * @param options.authorlogin User name to associate TestCase
     * @param options.summary TestCase description
     * @param options.steps Array of steps.
     * @param options.steps[].step_number Step's index number
     * @param options.steps[].actions The step text action (aka description)
     * @param [options.steps[].expected_results] The expected result when the step is executed
     * @param options.steps[].execution_type Execution type
     * @param [options.importance] Importance of TestCase
     * @param [options.executiontype]
     * @param [options.order]
     * @param [options.internalid] Do not use
     * @param [options.checkduplicatedname] Check if the given name belongs to another TestCase
     * @param [options.actiononduplicatedname] Action on duplicated name
     * @param [options.status]
     * @param [options.estimatedexecduration] Estimated execution time, in minutes.
     */
    @MandatoryFields(['testcasename', 'testsuiteid', 'testprojectid', 'authorlogin', 'summary', 'steps'])
    createTestCase(options: ApiTypes.RequestOptions & {
        testcasename: string
        testsuiteid: number
        testprojectid: number
        authorlogin: string
        summary: string
        steps: ApiTypes.Step[]
        importance?: ImportanceLevel
        executiontype?: ExecutionType
        order?: number
        internalid?: number
        checkduplicatedname?: string
        actiononduplicatedname?: ActionOnDuplicate
        status?: TestCaseStatus
        estimatedexecduration?: number
    }): Promise<ApiTypes.ResultResponse[]> {
        return this._performRequest('createTestCase', options);
    }

    /**
     * Create or update steps
     *
     * @param options Options
     * @param [options.testcaseexternalid] Test Case external id. If not present, testcaseid must be present.
     * @param [options.testcaseid] Test Case id. If not present, testcaseexternalid must be present.
     * @param [options.version] If not provided, the last ACTIVE version will be used, if all versions are INACTIVE, then latest version will be used.
     * @param options.action Action to be done
     * @param options.steps Array of steps.
     * @param options.steps[].step_number Step's index number
     * @param options.steps[].actions The step text action (aka description)
     * @param [options.steps[].expected_results] The expected result when the step is executed
     * @param options.steps[].execution_type Execution type
     */
    @MandatoryFields([['testcaseexternalid', 'testcaseid'], 'action', 'steps'])
    createTestCaseSteps(options: ApiTypes.RequestOptions & {
        testcaseexternalid?: string
        testcaseid?: string | number
        version?: string | number
        action: StepAction
        steps: ApiTypes.Step[]
    }): Promise<ApiTypes.TestCaseSteps> {
        return this._performRequest('createTestCaseSteps', options);
    }

    /**
     * Delete Test Case steps
     *
     * @param options Options
     * @param options.testcaseexternalid The Test Case external id
     * @param [options.version] The Test Case version. If not provided last ACTIVE version will be used
     * @param options.steps Array of steps.
     * @param options.steps[].step_number Step's index number
     * @param options.steps[].actions The step text action (aka description)
     * @param [options.steps[].expected_results] The expected result when the step is executed
     * @param options.steps[].execution_type Execution type
     */
    @MandatoryFields(['testcaseexternalid', 'steps'])
    deleteTestCaseSteps(options: ApiTypes.RequestOptions & {
        testcaseexternalid: string
        version?: string | number
        steps: number[]
    }): Promise<ApiTypes.TestCaseStepsSimple> {
        return this._performRequest('deleteTestCaseSteps', options);
    }

    /**
     * List test cases within a test suite
     *
     * @param options Options
     * @param options.testsuiteid
     * @param [options.deep=true] If set to false, fetch only from top level Test Suite
     * @param [options.details="simple"] Valid values are "simple and "full". On "full" summary,steps & expected_results are also represented.
     * @param [options.getkeywords=false] Get, or not, keywords
     */
    @MandatoryFields(['testsuiteid'])
    getTestCasesForTestSuite(options: ApiTypes.RequestOptions & {
        testsuiteid: number
        deep?: boolean
        details?: Details
        getkeywords?: boolean
    }): Promise<ApiTypes.TestCaseTable[]> {
        return this._performRequest('getTestCasesForTestSuite', options);
    }

    /**
     * List test cases linked to a test plan
     *
     * @param options Options
     * @param options.testplanid Test Plan id.
     * @param [options.buildid] Build id.
     * @param [options.platformid] Platform id.
     * @param [options.testcaseid] Test Case id.
     * @param [options.keywordid] Keyword id. If not present, keywords will be queried.
     * @param [options.keywords] Keyword name. If not present, keywordid will be queried
     * @param [options.executed]
     * @param [options.assignedto]
     * @param [options.executestatus]
     * @param [options.executiontype]
     * @param [options.getstepinfo] - default false
     * @param [options.details="full"] Valid values are "simple and "full". On "full" summary,steps & expected_results are also represented.
     */
    @MandatoryFields(['testplanid'])
    getTestCasesForTestPlan(options: ApiTypes.RequestOptions & {
        testplanid: number
        buildid?: number
        platformid?: number
        testcaseid?: number
        keywordid?: string
        keywords?: string
        executed?: boolean
        assignedto?: number
        executestatus?: ExecutionStatus
        executiontype?: ExecutionType
        getstepinfo?: boolean
        details?: Details
    }): Promise<Record<number, Record<number, ApiTypes.TestCaseAlt>>> {
        return this._performRequest('getTestCasesForTestPlan', options);
    }

    /**
     * Find a test case by its name (Note. Case sensitive)
     *
     * No results will be returned if there are test cases with the same name that match the criteria provided.
     *
     * @param options
     * @param options.testcasename Test Case name
     * @param [options.testsuitename] Test Suite name
     * @param [options.testprojectname] Project name
     * @param [options.testcasepathname] Test Case path
     *                                             (Full test case path name, starts with test project name,
     *                                             use pieces separator -> :: -> default value of getByPathName())
     */
    @MandatoryFields(['testcasename'])
    getTestCaseIDByName(options: ApiTypes.RequestOptions & {
        testcasename: string
        testsuitename?: string
        testprojectname?: string
        testcasepathname?: string
    }): Promise<ApiTypes.TestCaseSimple[]> {
        return this._performRequest('getTestCaseIDByName', options);
    }

    /**
     * Gets value of a Custom Field with scope='design' for a given Test case
     *
     * @param options Options
     *
     * @param options Options
     * @param options.testcaseexternalid: Test Case external id
     * @param options.version: Version number
     * @param options.testprojectid: Project id
     * @param options.customfieldname: Custom field name
     * @param [options.details=value] Details format
     *                                          "value": Returns just the value
     *                                          "simple": value plus custom field name, label, and type (as code)
     *                                          "full": Returns a map with all custom field definition plus value and internal test case id
     */
    @MandatoryFields(['testcaseexternalid', 'version', 'testprojectid', 'customfieldname'])
    getTestCaseCustomFieldDesignValue(options: ApiTypes.RequestOptions & {
        testcaseexternalid: string
        version: string | number
        testprojectid: string | number
        customfieldname: string
        details?: Details
    }): Promise<ApiTypes.CustomField | ApiTypes.CustomFieldSimple | string> {
        return this._performRequest('getTestCaseCustomFieldDesignValue', options);
    }

    /**
     * Gets a Custom Field of a Test Case in Execution Scope.
     *
     * @param options Options
     * @param options.customfieldname: Custom field name
     * @param options.testprojectid: Project id
     * @param options.executionid: Execution id
     * @param options.version: Test Case version NUMBER
     * @param options.testplanid: Test Plan id
     */
    @MandatoryFields(['customfieldname', 'testprojectid', 'executionid', 'version', 'testplanid'])
    getTestCaseCustomFieldExecutionValue(options: ApiTypes.RequestOptions & {
        customfieldname: string
        testprojectid: number
        executionid: number
        version: number
        testplanid: number
    }): Promise<ApiTypes.CustomField> {
        return this._performRequest('getTestCaseCustomFieldExecutionValue', options);
    }

    /**
     * Gets a Custom Field of a Test Case in Test Plan Design Scope.
     *
     * @param options Options
     * @param options.customfieldname: Custom field name
     * @param options.testprojectid: Project id
     * @param options.version: Test Case version id
     * @param options.testplanid: Test Plan id
     * @param options.linkid: Link id (important!)
     */
    @MandatoryFields(['customfieldname', 'testprojectid', 'version', 'testplanid', 'linkid'])
    getTestCaseCustomFieldTestPlanDesignValue(options: ApiTypes.RequestOptions & {
        customfieldname: string
        testprojectid: number
        version: number
        testplanid: number
        linkid: number
    }): Promise<ApiTypes.CustomField> {
        return this._performRequest('getTestCaseCustomFieldTestPlanDesignValue', options);
    }

    /**
     * Gets attachments for specified test case.
     *
     * @param options Options
     * @param [options.testcaseid] Test Case id. If not present, testcaseexternalid must be present.
     * @param [options.testcaseexternalid] Test Case external id. If not present, testcaseid must be present.
     */
    @MandatoryFields([['testcaseid', 'testcaseexternalid']])
    getTestCaseAttachments(options: ApiTypes.RequestOptions & {
        testcaseid?: string
        testcaseexternalid?: string
    }): Promise<Record<number | string, ApiTypes.Attachment>> {
        return this._performRequest('getTestCaseAttachments', options);
    }

    /**
     * Gets Test Case
     *
     * @param options Options
     * @param [options.testcaseid] Test Case id. If not present, testcaseexternalid must be present.
     * @param [options.testcaseexternalid] Test Case external id. If not present, testcaseid must be present.
     * @param [options.version] Test Case version.
     */
    @MandatoryFields([['testcaseid', 'testcaseexternalid']])
    getTestCase(options: ApiTypes.RequestOptions & {
        testcaseid?: string
        testcaseexternalid?: string
        version?: string
    }): Promise<ApiTypes.TestCase[]> {
        return this._performRequest('getTestCase', options);
    }

    /**
     * Update value of Custom Field with scope='design' for a given Test case
     *
     * @param options Options
     *
     * @param options Options
     * @param options.testcaseexternalid:  Test Case external id
     * @param options.version: Version number
     * @param options.testprojectid: Project id
     * @param options.customfields Map containing a key-value object with custom fields.
     */
    @MandatoryFields(['testcaseexternalid', 'testprojectid', 'version'])
    updateTestCaseCustomFieldDesignValue(options: ApiTypes.RequestOptions & {
        testcaseexternalid: string
        version: string | number
        testprojectid: string | number
        customfields?: Record<number, string>
    }): Promise<string> {
        return this._performRequest('updateTestCaseCustomFieldDesignValue', options);
    }

    /**
     * Update an existing test case
     * Not all test case attributes will be able to be updated using this method
     * See details below
     *
     * @param options Options
     * @param options.testcaseexternalid format PREFIX-NUMBER
     * @param [options.version] version NUMBER (human readable)
     * @param [options.testcasename]
     * @param [options.summary]
     * @param [options.preconditions]
     * @param [options.steps] Array of steps.
     * @param options.steps[].step_number Step's index number
     * @param options.steps[].actions The step text action (aka description)
     * @param [options.steps[].expected_results] The expected result when the step is executed
     * @param options.steps[].execution_type Execution type
     * @param [options.importance] Importance of TestCase
     * @param [options.executiontype]
     * @param [options.status] Current Test Case status (final, future, obsolete, draft, ...)
     * @param [options.estimatedexecduration]
     * @param [options.user] - login name used as updater
     */
    @MandatoryFields(['testcaseexternalid'])
    updateTestCase(options: ApiTypes.RequestOptions & {
        testcaseexternalid: string
        version?: number
        testcasename?: string
        summary?: string
        preconditions?: string
        steps?: {
            step_number: number
            actions: string
            expected_results?: string
            execution_type: ExecutionType
        }
        importance?: ImportanceLevel
        executiontype?: number
        status?: TestCaseStatus
        estimatedexecduration?: number
        user?: string
    }): Promise<ApiTypes.BasicResultResponse> {
        return this._performRequest('updateTestCase', options);
    }

    /**
     * Update execution type for a test case version
     *
     * @param options Options
     * @param options.testcaseexternalid Test Case external id
     * @param options.version Version number
     * @param options.testprojectid Project ID
     * @param options.executiontype
     *
     */
    @MandatoryFields(['testcaseexternalid', 'version', 'testprojectid', 'executiontype'])
    setTestCaseExecutionType(options: ApiTypes.RequestOptions & {
        testcaseexternalid: string
        version: string | number
        testprojectid: string | number
        executiontype: ExecutionType
    }): Promise<ApiTypes.TestCase> {
        return this._performRequest('setTestCaseExecutionType', options)
            // The response looks wrong on TestLink as the second items is debug data.
            .then(response => response[0]);
    }

    /**
     * Assign a Test Case execution
     *
     * @param options Options
     * @param options.testplanid Test Plan id
     * @param options.testcaseexternalid Test Case external id
     * @param [options.buildid] Buid id. If not present, buildname must be present.
     * @param [options.buildname] Build name. If not present, buildid must be present.
     * @param [options.platformid] Platform id. If not present and Test Case has platforms, platformname must be present.
     * @param [options.platformname] Platform name. If not present and Test Case has platforms, platformid must be present.
     * @param options.user User name
     */
    @MandatoryFields(['testplanid', 'testcaseexternalid', ['buildid', 'buildname'], ['platformid', 'platformname'], 'user'])
    assignTestCaseExecutionTask(options: ApiTypes.RequestOptions & {
        testplanid: string | number
        testcaseexternalid: string
        buildid?: string | number
        buildname?: string
        platformid?: string | number
        platformname?: string
        user: string
    }): Promise<ApiTypes.AssignExecutionResult> {
        return this._performRequest('assignTestCaseExecutionTask', options);
    }

    /**
     * Unassign a Test Case execution
     *
     * @param options Options
     * @param options.testplanid Test Plan id
     * @param options.testcaseexternalid Test Case external id
     * @param [options.buildid] Buid id. If not present, buildname must be present.
     * @param [options.buildname] Build name. If not present, buildid must be present.
     * @param [options.platformid] Platform id. If not present and Test Case has platforms, platformname must be present.
     * @param [options.platformname] Platform name. If not present and Test Case has platforms, platformid must be present.
     * @param options.user User name
     */
    @MandatoryFields(['testplanid', 'testcaseexternalid', ['buildid', 'buildname'], 'user'])
    unassignTestCaseExecutionTask(options: ApiTypes.RequestOptions & {
        testplanid: string | number
        testcaseexternalid: string
        buildid?: string | number
        buildname?: string
        platformid?: string | number
        platformname?: string
        user: string
    }): Promise<ApiTypes.AssignExecutionResult> {
        return this._performRequest('unassignTestCaseExecutionTask', options);
    }

    /**
     * Add keywords to TestCase
     *
     * @param options Options
     * @param options.keywords: Array with TestCase external id as key E.g: {keywords: ["MF-123": ["keywordA", "keywordB"]]}
     */
    @MandatoryFields(['keywords'])
    addTestCaseKeywords(options: ApiTypes.RequestOptions & {
        keywords: Record<string, string[]>
    }): Promise<ApiTypes.ValidKeywords> {
        return this._performRequest('addTestCaseKeywords', options);
    }

    /**
     * Remove keywords to TestCase
     *
     * @param options Options
     * @param options.keywords: Array with TestCase external id as key E.g: {keywords: ["MF-123": ["keywordA", "keywordB"]]}
     */
    @MandatoryFields(['keywords'])
    removeTestCaseKeywords(options: ApiTypes.RequestOptions & {
        keywords: Record<string, string[]>
    }): Promise<ApiTypes.ValidKeywords> {
        return this._performRequest('removeTestCaseKeywords', options);
    }

    /**
     * Set a Test Suite for a Test Case
     *
     * @param options Options
     * @param options.testcaseexternalid Test Case external id
     * @param options.testsuiteid Test Suite id
     */
    @MandatoryFields(['testcaseexternalid', 'testsuiteid'])
    setTestCaseTestSuite(options: ApiTypes.RequestOptions & {
        testcaseexternalid: string
        testsuiteid: number
    }): Promise<ApiTypes.BasicResultResponse[]> {
        return this._performRequest('setTestCaseTestSuite', options);
    }

    /* Test Plans */

    /**
     * Create a Test Plan
     *
     * @param options Options.
     * @param options.testplanname Test Plan name.
     * @param [options.testprojectname] Associated project name. If not specified, prefix must be.
     * @param [options.prefix] Project prefix. If not specified, testprojectname must be.
     * @param [options.notes] Test Plan description
     * @param [options.active=true]
     * @param [options.public=true]
     */
    @MandatoryFields(['testplanname', ['testprojectname', 'prefix']])
    createTestPlan(options: ApiTypes.RequestOptions & {
        testplanname: string
        testprojectname?: string
        prefix?: string
        notes?: string
        active?: boolean
        public?: boolean
    }): Promise<ApiTypes.ResultResponse[]> {
        return this._performRequest('createTestPlan', options);
    }

    /**
     * Delete a test plan and all related link to other items
     *
     * @param options Options
     * @param options.testplanid Test Plan id
     */
    @MandatoryFields(['testplanid'])
    deleteTestPlan(options: ApiTypes.RequestOptions & {
        testplanid: number
    }): Promise<ApiTypes.ResultResponse[]> {
        return this._performRequest('deleteTestPlan', options);
    }

    /**
     * Add a test case version to a test plan
     *
     * @param options Options
     * @param options.testprojectid Project id
     * @param options.testplanid Test Plan id
     * @param options.testcaseexternalid Test Case external id
     * @param options.version Test case version
     * @param [options.platformid] Only if  test plan has no platforms
     * @param [options.executionorder]
     * @param [options.urgency] Importance of TestCase
     * @param [options.overwrite]
     */
    @MandatoryFields(['testprojectid', 'testplanid', 'testcaseexternalid', 'version'])
    addTestCaseToTestPlan(options: ApiTypes.RequestOptions & {
        testprojectid: string | number
        testplanid: string | number
        testcaseexternalid: string
        version: string | number
        platformid?: string | number
        executionorder?: string
        urgency?: ImportanceLevel
        overwrite?: boolean
    }): Promise<ApiTypes.FeatureResponse> {
        return this._performRequest('addTestCaseToTestPlan', options);
    }

    /**
     * Add Platform to Test Plan
     *
     * @param options Options
     * @param options.testplanid
     * @param options.platformname
     */
    @MandatoryFields(['testplanid', 'platformname'])
    addPlatformToTestPlan(options: ApiTypes.RequestOptions & {
        testplanid: number
        platformname: string
    }): Promise<ApiTypes.LinkResponse> {
        return this._performRequest('addPlatformToTestPlan', options);
    }

    /**
     * Remove Platform from Test Plan
     *
     * @param options Options
     * @param options.testplanid
     * @param options.platformname
     */
    @MandatoryFields(['testplanid', 'platformname'])
    removePlatformFromTestPlan(options: ApiTypes.RequestOptions & {
        testplanid: number
        platformname: string
    }): Promise<ApiTypes.LinkResponse> {
        return this._performRequest('removePlatformFromTestPlan', options);
    }

    /**
     * Gets a list of test plans within a project
     *
     * @param options Options
     * @param options.testprojectid Project ID
     */
    @MandatoryFields(['testprojectid'])
    getProjectTestPlans(options: ApiTypes.RequestOptions & {
        testprojectid: number
    }): Promise<ApiTypes.TestPlan[]> {
        return this._performRequest('getProjectTestPlans', options);
    }

    /**
     * Gets info about target test project
     *
     * @param options Options
     * @param options.testprojectname Project name
     * @param options.testplanname Test Plan name
     */
    @MandatoryFields(['testprojectname', 'testplanname'])
    getTestPlanByName(options: ApiTypes.RequestOptions & {
        testprojectname: string
        testplanname: string
    }): Promise<ApiTypes.TestPlan[]> {
        return this._performRequest('getTestPlanByName', options);
    }

    /**
     * Gets the summarized results grouped by platform.
     *
     * @param options Options
     * @param options.testplanid Test Plan id
     */
    @MandatoryFields(['testplanid'])
    getTotalsForTestPlan(options: ApiTypes.RequestOptions & {
        testplanid: number
    }): Promise<ApiTypes.TestPlanTotals> {
        return this._performRequest('getTotalsForTestPlan', options);
    }

    /**
     * Gets a Custom Field of a Test Plan in Design Scope.
     *
     * @param options Options
     * @param options.customfieldname: Custom field name
     * @param options.testprojectid: Project id
     * @param options.testplanid: Test Plan id
     */
    @MandatoryFields(['customfieldname', 'testprojectid', 'testplanid'])
    getTestPlanCustomFieldDesignValue(options: ApiTypes.RequestOptions & {
        customfieldname: string
        testprojectid: number
        testplanid: number
    }): Promise<ApiTypes.CustomField> {
        return this._performRequest('getTestPlanCustomFieldDesignValue', options);
    }

    /* Test Suites */

    /**
     * Create a TestSuite
     *
     * @param options Options
     * @param [options.testprojectid] Project to contains TestSuite
     * @param [options.prefix] Project prefix to contains TestSuite
     * @param options.testsuitename New Test Suite name
     * @param [options.details] New Test Suite description
     * @param [options.parentid] The parent TestSuite id, if not provided, will be created as top level.
     * @param [options.order] Order inside parent container
     * @param [options.checkduplicatedname] Check if a Test Suite with the same name exists
     * @param [options.actiononduplicatedname] Action if the TestSuite name exists, and checkduplicatedname is set to true
     */
    @MandatoryFields([['testprojectid', 'prefix'], 'testsuitename'])
    createTestSuite(options: ApiTypes.RequestOptions & {
        testprojectid?: string | number
        prefix?: string
        testsuitename: string
        details?: string
        parentid?: number
        order?: number
        checkduplicatedname?: number
        actiononduplicatedname?: ActionOnDuplicate;
    }): Promise<ApiTypes.ResultResponse[]> {
        return this._performRequest('createTestSuite', options);
    }

    /**
     * List test suites within a test plan alphabetically
     *
     * @param options Options
     * @param options.testplanid Test Plan id
     */
    @MandatoryFields(['testplanid'])
    getTestSuitesForTestPlan(options: ApiTypes.RequestOptions & {
        testplanid: number
    }): Promise<ApiTypes.TestSuite[]> {
        return this._performRequest('getTestSuitesForTestPlan', options);
    }

    /**
     * Get list of TestSuites which are DIRECT children of a given TestSuite
     *
     * @param options Options
     * @param options.testsuiteid Test Suite id.
     */
    @MandatoryFields(['testsuiteid'])
    getTestSuitesForTestSuite(options: ApiTypes.RequestOptions & {
        testsuiteid: number
    }): Promise<Record<number, ApiTypes.TestSuite> | ApiTypes.TestSuite> {
        return this._performRequest('getTestSuitesForTestSuite', options);
    }

    /**
     * Gets a Custom Field of a Test Suite in Design Scope.
     *
     * @param options Options
     * @param options.customfieldname: Custom field name
     * @param options.testprojectid: Project id
     * @param options.testsuiteid: Test Suite id
     */
    @MandatoryFields(['customfieldname', 'testprojectid', 'testsuiteid'])
    getTestSuiteCustomFieldDesignValue(options: ApiTypes.RequestOptions & {
        customfieldname: string
        testprojectid: number
        testsuiteid: number
    }): Promise<ApiTypes.CustomField> {
        return this._performRequest('getTestSuiteCustomFieldDesignValue', options);
    }

    /**
     * Get set of test suites AT TOP LEVEL of tree on a Test Project
     *
     * @param options Options
     * @param options.testprojectid Project id
     */
    @MandatoryFields(['testprojectid'])
    getFirstLevelTestSuitesForTestProject(options: ApiTypes.RequestOptions & {
        testprojectid: string | number
    }): Promise<ApiTypes.TestSuite[]> {
        return this._performRequest('getFirstLevelTestSuitesForTestProject', options);
    }

    /**
     * Return a TestSuite by ID
     *
     * @param options Options
     * @param options.testsuiteid
     */
    @MandatoryFields(['testsuiteid'])
    getTestSuiteByID(options: ApiTypes.RequestOptions & {
        testsuiteid: number | string
    }): Promise<ApiTypes.TestSuite> {
        return this._performRequest('getTestSuiteByID', options);
    }

    /**
     * Update value of Custom Field with scope='design' for a given Test Suite
     *
     * @param options Options
     *
     * @param options.testsuiteid Test Suite id
     * @param options.testprojectid Project id
     * @param options.customfields Map containing a key-value object with custom fields. (Note the Key should be the CF id, not the name)
     */
    @MandatoryFields(['testsuiteid', 'testprojectid', 'customfields'])
    updateTestSuiteCustomFieldDesignValue(options: ApiTypes.RequestOptions & {
        testsuiteid: string | number
        testprojectid: string | number
        customfields: Record<string | number, string>
    }): Promise<ApiTypes.StatusResponse[]> {
        return this._performRequest('updateTestSuiteCustomFieldDesignValue', options);
    }

    /**
     * Returns all test suites inside target test project with target name
     *
     * @param options Options
     * @param options.testsuitename
     * @param options.prefix
     */
    @MandatoryFields(['testsuitename', 'prefix'])
    getTestSuite(options: ApiTypes.RequestOptions & {
        testsuitename: string
        prefix: string
    }): Promise<ApiTypes.TestSuite[]> {
        return this._performRequest('getTestSuite', options);
    }

    /**
     * Update a test suite
     *
     * @param options Options
     * @param [options.testprojectid] Project id. Madatory if prefix is not present
     * @param [options.prefix] Project prefix. Madatory if testprojectid is not present
     * @param options.testsuiteid The ID of the TS to be updated.
     * @param [options.testsuitename] New Test Suite name.
     * @param [options.details] New Test Suite description.
     * @param [options.order] Order inside parent container.
     */
    @MandatoryFields([['testprojectid', 'prefix'],])
    updateTestSuite(options: ApiTypes.RequestOptions & {
        testprojectid?: string | number
        prefix?: string
        testsuiteid: string | number
        testsuitename?: string
        details?: string
        order?: number
    }): Promise<ApiTypes.ResultResponse[]> {
        return this._performRequest('updateTestSuite', options);
    }

    /* Users */

    /**
     * Gets user data by login name
     *
     * @param options
     * @param options.user User name
     */
    @MandatoryFields(['user'])
    getUserByLogin(options: ApiTypes.RequestOptions & {
        user: string
    }): Promise<ApiTypes.User[]> {
        return this._performRequest('getUserByLogin', options);
    }

    /**
     * Gets user data by ID
     *
     * @param options Options
     * @param options.userid User id
     */
    @MandatoryFields(['userid'])
    getUserByID(options: ApiTypes.RequestOptions & {
        userid: string | number
    }): Promise<ApiTypes.User[]> {
        return this._performRequest('getUserByID', options);
    }

    /**
     * Checks if an user exists
     *
     * @param options.user User name
     */
    @MandatoryFields(['user'])
    doesUserExist(options: ApiTypes.RequestOptions & {
        user: string
    }): Promise<boolean> {
        return this._performRequest('doesUserExist', options);
    }

    /* RPC */

    /**
     * Perform a request to XML-RPC TestLink API.
     *
     * @param method - Method name to be invoked in TestLink.
     * @param options needed by the method to perform an action.
     * @param options.apiKey - API key to be used.
     * @param options.devKey - Same as `options.apiKey`.
     * @returns Promise object represents the request response.
     */
    _performRequest(method: string, {
        apiKey,
        devKey = apiKey || this.apiKey,
        ...options
    }: ApiTypes.RequestOptions = {}): Promise<any> {
        return new Promise((resolve, reject) => {
            if (this.rpcClient) {
                this.rpcClient.methodCall(`tl.${method}`, [{devKey, ...options}], (error: string, value) => {
                    if (error) {
                        return reject(new Error(error));
                    } else if (value.status_ok === 0) {
                        return reject(new Error(value.msg));
                    } else if (Array.isArray(value)) {
                        for (const v of value) {
                            if (Object.prototype.hasOwnProperty.call(v, 'code')) {
                                return reject(new Error(`[${v.code}] ${v.message}`));
                            }
                        }
                    }
                    return resolve(value);
                });
            } else {
                reject('RPC Client not initiated.');
            }
        });
    }
}

export * as Constants from './constants';
