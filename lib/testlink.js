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
 * @author Luis Zurro de Cos <luiszurrodecos@gmail.com
 */

const xmlrpc = require("xmlrpc");

/**
 * TestLink class to perform requests to XML-RPC API
 */
class TestLink {
    /**
     * Class constructor
     *
     * @param {object}  params Configuration parameters
     * @param {string}  params.host Hostname or IP where TestLink is hosted.
     * @param {int}     params.port Hostname or IP where TestLink is hosted.
     * @param {string}  params.rpcPath path to testlink rpc client.
     * @param {string}  params.secure Use or not secure connection. If set to true, use http and port 443 if a port was not defined else uses http and port 80.
     * @param {string}  params.apiKey The api key to interact with TestLink.
     * @param {boolean} [autoConnect=true] If set to true, the connection is established on constructor, else a call to connect() method is required.
     */
    constructor(params, autoConnect = true) {
        let defaultParams = {
            host: "localhost",
            port: undefined,
            rpcPath: '/lib/api/xmlrpc/v1/xmlrpc.php',
            secure: true,
            apiKey: undefined
        };

        let p = Object.assign({}, defaultParams, params);

        checkMandatoryFields(p, ["host", "rpcPath", "apiKey"]);

        this.host = p.host;
        this.secure = p.secure;
        this.port = p.port || (this.secure ? 443 : 80);
        this.rpcPath = p.rpcPath;
        this.apiKey = p.apiKey;

        if (autoConnect)
            this.connect()
    }

    /**
     * Establish connection
     */
    connect() {
        this.rpcClient = xmlrpc.createClient({host: this.host, port: this.port, path: this.rpcPath})
    }

    /**
     * Report a Test Case result
     *
     * @param {object}  options Options.
     * @param {string}  [options.testcaseid] Test Case id. If not present, testcaseexternalid must be present.
     * @param {string}  [options.testcaseexternalid] Test Case external id. If not present, testcaseid must be present.
     * @param {char}    options.status Execution status (@see constants.ExecutionStatus).
     * @param {array}   options.steps Array of steps.
     * @param {int}     options.steps[].step_number Step number.
     * @param {char}    options.steps[].result Step execution result (@see constants.ExecutionStatus).
     * @param {string}  options.steps[].notes Step execution notes.
     * @param {int}     [options.buildid] Build id number. If this and buildname are not specified, the latest build will be used.
     * @param {string}  [options.buildname] Build name. If this and buildid are not specified, the latest build will be used.
     * @param {string}  [options.notes] Execution notes.
     * @param {number}  [options.execduration] Execution duration in minutes.
     * @param {boolean} [options.guess=true] Defining whether to guess optinal params or require them explicitly, default is true (guess by default).
     * @param {string}  [options.bugid] Bug id in the configured tracker system.
     * @param {string}  [options.platformid] Platform id, if not present platformname must be.
     * @param {string}  [options.platformname] Platform id, if not present platformid must be.
     * @param {object}  [options.customfields] Map containing a key-value object with custom fields.
     * @param {boolean} [options.overwrite] Overwrite, or not, the last execution if exists.
     * @param {string}  [options.user] TestLink user name who executed the test.
     * @param {string}  [options.timestamp] If not present, current time will be used. (Format: YYYY-MM-DD HH:MM:SS).
     *
     * @returns {object}  result Result object.
     * @returns {boolean} result.status Status of request.
     * @returns {int}     result.id Result id if success or error code.
     * @returns {string}  result.message If an error ocurred, the error message.
     */
    reportTCResult(options) {
        checkMandatoryFields(options, [
            ["testcaseid", "testcaseexternalid"],
            "status",
            {"steps": ["step_number", "result", "notes"]},
        ]);

        return this._performRequest('reportTCResult', options);
    }

    /**
     * @see {@see reportTCResult}
     * @param {object}  options @see {@see reportTCResult#options}
     */
    setTestCaseExecutionResult(options) {
        checkMandatoryFields(options, [
            ["testcaseid", "testcaseexternalid"],
            "status",
            {"steps": ["step_number", "result", "notes"]},
        ]);

        return this._performRequest('setTestCaseExecutionResult', options)
    }

    /**
     * Creates a new build for a specific test plan
     *
     * @param {object}  options Options
     * @param {int}     options.testplanid TestPlan id to associate with.
     * @param {string}  options.buildname Build name.
     * @param {string}  options.buildnotes Build description
     * @param {boolean} options.active Set if is active
     * @param {boolean} options.open Set if is open
     * @param {string}  options.releasedate : Release date in format YYYY-MM-DD
     * @param {int}     [options.copytestersfrombuild] Build id to copy from
     *
     * @returns {object}  result Result object.
     */
    createBuild(options) {
        checkMandatoryFields(options, [
            "testplanid",
            "buildname",
            "buildnotes",
            "active",
            "open",
            "releasedate"
        ]);

        return this._performRequest('createBuild', options)
    }

    /**
     * Close a build
     *
     * @param {object}  options Options
     * @param {string}  options.buildid Build id.
     *
     * @returns {object}  result Result object.
     */
    closeBuild(options) {
        checkMandatoryFields(options, ["buildid"]);

        return this._performRequest('closeBuild', options)
    }

    /**
     * Creates a platform
     *
     * @param {object}  options Options
     * @param {string}  options.testprojectname Test project name
     * @param {string}  options.platformname New platform name
     * @param {string}  options.notes New platform description
     *
     * @returns {object}  result Result object.
     */
    createPlatform(options) {
        checkMandatoryFields(options, ["options", "platformname", "notes"]);

        return this._performRequest('createPlatform', options)
    }

    /**
     * Creates a TestCase
     *
     * @param {object}  options Options
     * @param {string}  options.testcasename New TestCase name
     * @param {int}     options.testsuiteid Parent TestSuite id
     * @param {int}     options.testprojectid Project id
     * @param {string}  options.authorlogin User name to associate TestCase
     * @param {string}  options.summary TestCase description
     * @param {array}   options.steps Array of steps.
     * @param {int}     options.steps[].step_number Step's index number
     * @param {string}  options.steps[].actions The step text action (aka description)
     * @param {string}  [options.steps[].expected_results] The expectes result when the step is executed
     * @param {string}  options.steps[].execution_type Execution type (@see constants.ExecutionType).
     * @param {int}     [options.importance] Importance of TestCase (@see ImportanceLevel)
     * @param {int}     [options.executiontype]
     * @param {int}     [options.order]
     * @param {int}     [options.internalid] Do not use
     * @param {string}  [options.checkduplicatedname] Check if the given name belongs to another TestCase
     * @param {string}  [options.actiononduplicatedname] Action on duplicated name (@see constants.ActionOnDuplicate)
     * @param {int}     [options.status] (@see constants.ExecutionStatus).
     * @param {number}  [options.estimatedexecduration] Estimated execution time, in minutes.
     *
     * @returns {object}  result Result object.
     * @returns {string}  result.operation - verbose operation
     * @returns {boolean} result.status - verbose operation
     * @returns {int}     result.id - test case internal ID (Database ID)
     * @returns {mixed}   result.additionalInfo
     * @returns {int}     result.additionalInfo.id'] same as $resultInfo['id
     * @returns {int}     result.additionalInfo.external_id without prefix
     * @returns {int}     result.additionalInfo.status_ok 1/0
     * @returns {string}  result.additionalInfo.msg - for debug
     * @returns {string}  result.additionalInfo.new_name only present if new name generation was needed
     * @returns {int}     result.additionalInfo.version_number
     * @returns {boolean} result.additionalInfo.has_duplicate - for debug
     * @returns {string}  result.message operation message
     */
    createTestCase(options) {
        checkMandatoryFields(options, [
            "testcasename",
            "testsuiteid",
            "testprojectid",
            "authorlogin",
            "summary",
            {"steps": ["step_number", "actions", "execution_type"]}
        ]);

        return this._performRequest('createTestCase', options);
    }

    /**
     * Create or update steps (@see options.action)
     *
     * @param {object}  options Options
     * @param {string}  [options.testcaseexternalid] Test Case external id. If not present, testcaseid must be present.
     * @param {string}  [options.testcaseid] Test Case id. If not present, testcaseexternalid must be present.
     * @param {string}  [options.version] If not provided, the last ACTIVE version will be used, if all versions are INACTIVE, then latest version will be used.
     * @param {string}  options.action Action to be done (@see constants.StepAction)
     * @param {array}   options.steps Array of steps
     * @param {array}   options.steps[].step_number Step's index number
     * @param {array}   options.steps[].actions The step text action (aka description)
     * @param {array}   [options.steps[].expected_results] The expectes result when the step is executed
     * @param {array}   options.steps[].execution_type Execution type (@see constants.ExecutionType).
     *
     * @returns {object}  result Result object.
     */
    createTestCaseSteps(options) {
        checkMandatoryFields(options, [
            ["testcaseexternalid", "testcaseid"],
            "action",
            {"steps": ["step_number", "actions", "expected_results", "execution_type"]}
        ]);

        return this._performRequest('createTestCaseSteps', options)
    }

    /**
     * Create a Test Plan
     *
     * @param {object}  options Options.
     * @param {int}     options.testplanname Test Plan name.
     * @param {int}     [options.testprojectname] Associated project name. If not specified, prefix must be.
     * @param {int}     [options.prefix] Project prefix. If not specified, testprojectname must be.
     * @param {string}  [options.notes] Test Plan description
     * @param {boolean}  [options.active=true]
     * @param {boolean}  [options.public=true]
     *
     * @returns {object}  result Result object.
     */
    createTestPlan(options) {
        checkMandatoryFields(options, [
            "testplanname",
            ["testprojectname", "prefix"]
        ]);

        return this._performRequest('createTestPlan', options)
    }

    /**
     * Create Test Project
     *
     * @param {object}  options Options
     * @param {string}  options.testprojectname New Project name
     * @param {string}  options.testprojectprefix New Project prefix
     * @param {string}  [options.notes] New Project description
     * @param {object}  [options.options] The new Project options
     * @param {boolean} [options.options.requirementsEnabled] Enable, or not requirements
     * @param {boolean} [options.options.testPriorityEnabled] Enable, or not requirements
     * @param {boolean} [options.options.automationEnabled] Enable, or not requirements
     * @param {boolean} [options.options.inventoryEnabled] Enable, or not requirements
     * @param {boolean} [options.active] Set Project as active or not
     * @param {boolean} [options.public] Set Project as public or not
     * @param {string}  [options.itsname] Issue Tracker name
     * @param {boolean} [options.itsEnabled] Issue Tracker enabled or not
     *
     * @returns {object}  result Result object.
     */
    createTestProject(options) {
        checkMandatoryFields(options, ["testprojectname", "testcaseprefix"]);

        return this._performRequest('createTestProject', options)
    }

    /**
     * Create a TestSuite
     *
     * @param {object}  options Options
     * @param {int}     [options.testprojectid] Project to contains TestSuite
     * @param {string}  [options.prefix] Project prefix to contains TestSuite
     * @param {string}  options.testsuitename New Test Suite name
     * @param {string}  [options.details] New Test Suite description
     * @param {int}     [options.parentid] The parent TestSuite id, if not provided, will be created as top level.
     * @param {int}     [options.order] Order inside parent container
     * @param {int}     [options.checkduplicatedname] Check if a Test Suite with the same name exists
     * @param {int}     [options.actiononduplicatedname] Action if the TestSuite name exists, and checkduplicatedname is set to true (@see constants.ActionOnDuplicate)
     *
     * @returns {object}  result Result object.
     */
    createTestSuite(options) {
        checkMandatoryFields(options, [["testprojectid", "prefix"], "testsuitename"]);

        return this._performRequest('createTestSuite', options)
    }

    /**
     * Delete Test Case steps
     *
     * @param {object}  options Options
     * @param {string}  options.testcaseexternalid The Test Case external id
     * @param {string}  [options.version] The Test Case version. If not provided last ACTIVE version will be used
     * @param {array}   options.steps: An array containing the step's step_number to delete
     *
     * @returns {object}  result Result object.
     */
    deleteTestCaseSteps(options) {
        checkMandatoryFields(options, ["testcaseexternalid", "steps"]);

        return this._performRequest('deleteTestCaseSteps', options)
    }

    /**
     * Delete a test plan and all related link to other items
     *
     * @param {object}  options Options
     * @param {int}     options.tplanID Test Plan id
     *
     * @returns {object}  result Result object.
     * @returns {boolean} result.status Delete operation result
     * @returns {object}  result.id Result id or error code
     * @returns {object}  result.message If an error has ocurred, a message about it.
     */
    deleteTestPlan(options) {
        checkMandatoryFields(options, ["tplanID"]);

        return this._performRequest('deleteTestPlan', options)
    }

    /**
     * Delete a test project and all related link to other items
     *
     * @param {object}  options Options
     * @param {int}     options.prefix The Project prefix
     *
     * @returns {object}  result Result object.
     * @returns {object}  result.status The delete project request result
     * @returns {object}  result.message If an error has ocurred, a message about it.
     */
    deleteTestProject(options) {
        checkMandatoryFields(options, ["prefix"]);

        return this._performRequest('deleteTestProject', options)
    }

    /**
     * Uploads an attachment for an execution.
     *
     * @param {object}  options Options
     * @param {int}     options.executionid The Test Case execution id
     * @param {string}  [options.title] Attachment's title
     * @param {string}  [options.description] Attachment's description
     * @param {string}  options.filename Attachment's file name (E.g. screenshot.png)
     * @param {string}  options.filetype Attachment's mime type (E.g.: image/png)
     * @param {string}  options.content Attachment's content in BASE64
     *
     * @returns {object} result Result object.
     * @returns {object} result.fk_id
     * @returns {object} result.fk_table
     * @returns {object} result.title
     * @returns {object} result.description
     * @returns {object} result.file_name
     * @returns {object} result.file_size
     * @returns {object} result.file_type
     */
    uploadExecutionAttachment(options) {
        checkMandatoryFields(options, ["executionid", "filename", "filetype", "content"]);

        return this._performRequest('uploadExecutionAttachment', options)
    }

    /**
     * Uploads an attachment for a Requirement Specification.
     *
     * @param {object}  options Options
     * @param {int}     options.reqspecid The Requirement Specification ID
     * @param {string}  [options.title] Attachment's title
     * @param {string}  [options.description] Attachment's description
     * @param {string}  options.filename Attachment's file name (E.g. screenshot.png)
     * @param {string}  options.filetype Attachment's mime type (E.g.: image/png)
     * @param {string}  options.content Attachment's content in BASE64
     *
     * @returns {object} result Result object.
     * @returns {object} result.fk_id
     * @returns {object} result.fk_table
     * @returns {object} result.title
     * @returns {object} result.description
     * @returns {object} result.file_name
     * @returns {object} result.file_size
     * @returns {object} result.file_type
     */
    uploadRequirementSpecificationAttachment(options) {
        checkMandatoryFields(options, ["reqspecid", "filename", "filetype", "content"]);

        return this._performRequest('uploadRequirementSpecificationAttachment', options)
    }

    /**
     * Uploads an attachment for a Requirement.
     *
     * @param {object}  options Options
     * @param {int}     options.requirementid The Requirement ID
     * @param {string}  [options.title] Attachment's title
     * @param {string}  [options.description] Attachment's description
     * @param {string}  options.filename Attachment's file name (E.g. screenshot.png)
     * @param {string}  options.filetype Attachment's mime type (E.g.: image/png)
     * @param {string}  options.content Attachment's content in BASE64
     *
     * @returns {object} result Result object.
     * @returns {object} result.fk_id
     * @returns {object} result.fk_table
     * @returns {object} result.title
     * @returns {object} result.description
     * @returns {object} result.file_name
     * @returns {object} result.file_size
     * @returns {object} result.file_type
     */
    uploadRequirementAttachment(options) {
        checkMandatoryFields(options, ["requirementid", "filename", "filetype", "content"]);

        return this._performRequest('uploadRequirementAttachment', options)
    }

    /**
     * Uploads an attachment for a Test Project.
     *
     * @param {object}  options Options
     * @param {int}     options.testprojectid The Test Project ID
     * @param {string}  [options.title] Attachment's title
     * @param {string}  [options.description] Attachment's description
     * @param {string}  options.filename Attachment's file name (E.g. screenshot.png)
     * @param {string}  options.filetype Attachment's mime type (E.g.: image/png)
     * @param {string}  options.content Attachment's content in BASE64
     *
     * @returns {object} result Result object.
     * @returns {object} result.fk_id
     * @returns {object} result.fk_table
     * @returns {object} result.title
     * @returns {object} result.description
     * @returns {object} result.file_name
     * @returns {object} result.file_size
     * @returns {object} result.file_type
     */
    uploadTestProjectAttachment(options) {
        checkMandatoryFields(options, ["testprojectid", "filename", "filetype", "content"]);

        return this._performRequest('uploadTestProjectAttachment', options)
    }

    /**
     * Uploads an attachment for a Test Suite.
     *
     * @param {object}  options Options
     * @param {int}     options.testsuiteid The Test Suite ID
     * @param {string}  [options.title] Attachment's title
     * @param {string}  [options.description] Attachment's description
     * @param {string}  options.filename Attachment's file name (E.g. screenshot.png)
     * @param {string}  options.filetype Attachment's mime type (E.g.: image/png)
     * @param {string}  options.content Attachment's content in BASE64
     *
     * @returns {object} result Result object.
     * @returns {object} result.fk_id
     * @returns {object} result.fk_table
     * @returns {object} result.title
     * @returns {object} result.description
     * @returns {object} result.file_name
     * @returns {object} result.file_size
     * @returns {object} result.file_type
     */
    uploadTestSuiteAttachment(options) {
        checkMandatoryFields(options, ["testsuiteid", "filename", "filetype", "content"]);

        return this._performRequest('uploadTestSuiteAttachment', options)
    }

    /**
     * Uploads an attachment for a Test Case.
     *
     * @param {object}  options Options
     * @param {int}     options.testcaseid The Test Case ID
     * @param {string}  [options.title] Attachment's title
     * @param {string}  [options.description] Attachment's description
     * @param {string}  options.filename Attachment's file name (E.g. screenshot.png)
     * @param {string}  options.filetype Attachment's mime type (E.g.: image/png)
     * @param {string}  options.content Attachment's content in BASE64
     *
     * @returns {object} result Result object.
     * @returns {object} result.fk_id
     * @returns {object} result.fk_table
     * @returns {object} result.title
     * @returns {object} result.description
     * @returns {object} result.file_name
     * @returns {object} result.file_size
     * @returns {object} result.file_type
     */
    uploadTestCaseAttachment(options) {
        checkMandatoryFields(options, ["testcaseid", "filename", "filetype", "content"]);

        return this._performRequest('uploadTestCaseAttachment', options)
    }

    /**
     * Uploads an attachment for specified table. You must specify the table that
     * the attachment is connected (nodes_hierarchy, builds, etc) and the foreign
     * key id in this table.
     *
     * @param {object}  options Options
     * @param {int}     options.fkid Attachment's Foreign Key ID
     * @param {string}  options.fktable Attachment's Foreign Key Table
     * @param {string}  [options.title] Attachment's title
     * @param {string}  [options.description] Attachment's description
     * @param {string}  options.filename Attachment's file name (E.g. screenshot.png)
     * @param {string}  options.filetype Attachment's mime type (E.g.: image/png)
     * @param {string}  options.content Attachment's content in BASE64
     *
     * @returns {object} result Result object.
     * @returns {object} result.fk_id
     * @returns {object} result.fk_table
     * @returns {object} result.title
     * @returns {object} result.description
     * @returns {object} result.file_name
     * @returns {object} result.file_size
     * @returns {object} result.file_type
     */
    uploadAttachment(options) {
        checkMandatoryFields(options, ["fkid", "fktable", "filename", "filetype", "content"]);

        return this._performRequest('uploadAttachment', options)
    }

    /**
     * Assign Requirements to a test case
     * Requirements can belong to different Requirement Spec
     *
     * @param {object}  options
     * @param {string}  options.testcaseexternalid Test Case external id.
     * @param {int}     options.testprojectid Project ID
     * @param {string}  options.requirements Requirements array
     * @param {string}  options.requirements[].req_spec
     * @param {string}  options.requirements[].requirements
     *
     * @returns {object} result Result object.
     */
    assignRequirements(options) {
        checkMandatoryFields(options, ["testcaseexternalid", "testprojectid", {"requirements": ["req_spec", "requirements"]}]);

        return this._performRequest('assignRequirements', options)
    }

    /**
     * Add a test case version to a test plan
     *
     * @param {object}  options Options
     * @param {string}  options.testprojectid Project id
     * @param {string}  options.testplanid Test Plan id
     * @param {string}  options.testcaseexternalid Test Case external id
     * @param {string}  options.version Test case version
     * @param {string}  [options.platformid] Only if  test plan has no platforms
     * @param {string}  [options.executionorder]
     * @param {string}  [options.urgency] Importance of TestCase (@see ImportanceLevel)
     * @param {boolean} [options.overwrite]
     *
     * @returns {object} result Result object.
     */
    addTestCaseToTestPlan(options) {
        checkMandatoryFields(options, ["testprojectid", "testplanid", "testcaseexternalid", "version"]);

        return this._performRequest('addTestCaseToTestPlan', options)
    }

    /**
     * Add Platform to Test Plan
     *
     * @param {object}  options Options
     * @param {int}     options.testplanid
     * @param {map}     options.platformname
     *
     * @returns {object} result Result object.
     */
    addPlatformToTestPlan(options) {
        checkMandatoryFields(options, ["testplanid", "platformname"]);

        return this._performRequest('addPlatformToTestPlan', options)
    }

    /**
     * Remove Platform from Test Plan
     *
     * @param {object}  options Options
     * @param {int}     options.testplanid
     * @param {map}     options.platformname
     *
     * @returns {object} result Result object.
     */
    removePlatformFromTestPlan(options) {
        checkMandatoryFields(options, ["testplanid", "platformname"]);

        return this._performRequest('removePlatformFromTestPlan', options)
    }

    /**
     * @param {object}  options Options
     *
     * @returns {object} result Result object.
     */
    getExecCountersByBuild(options) {
        checkMandatoryFields(options, []);

        return this._performRequest('getExecCountersByBuild', options)
    }

    /**
     * Get Issue Tracker System by name
     *
     * @param {object}  options Options
     * @param {string}  options.itsname Issue Tracker System name
     * @return mixed $itsObject
     */
    getIssueTrackerSystem(options) {
        checkMandatoryFields(options, ["itsname"]);

        return this._performRequest('getIssueTrackerSystem', options)
    }

    /**
     * Gets a list of all projects
     *
     * @returns {object}  result Result object.
     */
    getProjects() {
        return this._performRequest('getProjects', {})
    }

    /**
     * Gets a list of keywords within a project
     *
     * @param {object}  options Options
     *
     * @returns {object}  result Result object.
     */
    getProjectKeywords(options) {
        checkMandatoryFields(options, ["testprojectid"]);

        return this._performRequest('getProjectKeywords', options);
    }

    /**
     * Gets a list of platforms within a project
     *
     * @param {object}  options Options
     * @param {int}     options.testprojectid Project ID
     *
     * @returns {object}  result Result object.
     */
    getProjectPlatforms(options) {
        checkMandatoryFields(options, ["testprojectid"]);

        return this._performRequest('getProjectPlatforms', options)
    }

    /**
     * Gets a list of test plans within a project
     *
     * @param {object}  options Options
     * @param {int}     options.testprojectid Project ID
     *
     * @returns {object}  result Result object.
     */
    getProjectTestPlans(options) {
        checkMandatoryFields(options, ["testprojectid"]);

        return this._performRequest('getProjectTestPlans', options)
    }

    /**
     * Gets the result of LAST EXECUTION for a particular testcase on a test plan.
     * If there are no filter criteria regarding platform and build,
     * result will be get WITHOUT checking for a particular platform and build.
     *
     * @param {object}  options Options
     * @param {int}     options.tplanid Test Plan id.
     * @param {string}  options.testcaseexternalid Test Case external id.
     * @param {int}     [options.buildid] Build id number. If this and buildname are not specified, the latest build will be used.
     * @param {string}  [options.buildname] Build name. If this and buildid are not specified, the latest build will be used.
     * @param {int}     [options.platformid] Platform id number. If not specified, plaformname must be
     * @param {string}  [options.platformname] Platform name. If not specified, platformid must be
     *
     * @returns {object}  result Result object.
     */
    getTestCaseAssignedTester(options) {
        checkMandatoryFields(options, ["tplanid", "testcaseexternalid", ["buildid", "buildname"], ["platformid", "platformname"]]);

        return this._performRequest('getTestCaseAssignedTester', options)
    }


    /**
     * Returns all bugs linked to a particular testcase on a test plan.
     * If there are no filter criteria regarding platform and build,
     * result will be get WITHOUT checking for a particular platform and build.
     *
     * @param {object}  options Options
     * @param {int}     options.tplanid
     * @param {string}  [options.testcaseid] Test Case id. If not present, testcaseexternalid must be present.
     * @param {string}  [options.testcaseexternalid] Test Case external id. If not present, testcaseid must be present.
     * @param {string}  [options.platformid] Platform id. If not present, platformname must be present.
     * @param {string}  [options.platformname] Platform name. If not present, platformid must be present.
     * @param {string}  [options.buildid] Buid id. If not present, buildname must be present.
     * @param {string}  [options.buildname] Build name. If not present, buildid must be present.
     *
     * @returns {object}  result Result object.
     */
    getTestCaseBugs(options) {
        checkMandatoryFields(options, [
            "tplanid",
            ["testcaseid", "testcaseexternalid"],
            ["platformid", "platformname"],
            ["buildid", "buildname"]
        ]);

        return this._performRequest('getTestCaseBugs', options)
    }

    /**
     * Gets list of keywords for a given Test case
     *
     * @param {object}  options Options
     * @param {int|array} [options.testcaseid] Test Case id (or array of Test Case ids). If not present, testcaseexternalid must be present.
     * @param {string|array} [options.testcaseexternalid] Test Case external id (or array of Test Case external ids). If not present, testcaseid must be present.
     *
     * @return map indexed by test case internal (DB) ID
     */
    getTestCaseKeywords(options) {
        checkMandatoryFields(options, [["testcaseid", "testcaseexternalid"]]);

        return this._performRequest('getTestCaseKeywords', options)
    }

    /**
     * Gets info about target test project
     *
     * @param {object}  options Options
     * @param {string}  options.testprojectname Project name
     *
     * @returns {object}  result Result object.
     */
    getTestProjectByName(options) {
        checkMandatoryFields(options, ["testprojectname"]);

        return this._performRequest('getTestProjectByName', options);
    }

    /**
     * Gets info about target test project
     *
     * @param {object}  options Options
     * @param {string}  options.testprojectname Project name
     * @param {string}  options.testplanname Test Plan name
     *
     * @returns {object}  result Result object.
     */
    getTestPlanByName(options) {
        checkMandatoryFields(options, ["testprojectname", "testplanname"]);

        return this._performRequest('getTestPlanByName', options)
    }


    /**
     * Returns the list of platforms associated to a given test plan
     *
     * @param {object}  options Options
     * @param {int}     options.testplanid
     *
     * @returns {object}  result Result object.
     */
    getTestPlanPlatforms(options) {
        checkMandatoryFields(options, ["testplanid"]);

        return this._performRequest('getTestPlanPlatforms', options)
    }

    /**
     * Gets the summarized results grouped by platform.
     *
     * @param {object}  options Options
     * @param {int}     options.testplanid Test Plan id
     *
     * @returns {object}  result Result object.
     * @returns {object}  result[].type
     * @returns {object}  result[].total_tc
     * @returns {object}  result[].details
     * @returns {object}  result[].details[].passed
     * @returns {object}  result[].details[].passed.qty
     * @returns {object}  result[].details[].failed
     * @returns {object}  result[].details[].failed.qty
     * @returns {object}  result[].details[].blocked
     * @returns {object}  result[].details[].blocked.qty
     *
     */
    getTotalsForTestPlan(options) {
        checkMandatoryFields(options, ["testplanid"]);

        return this._performRequest('getTotalsForTestPlan', options)
    }

    /**
     * Gets a list of builds within a test plan
     *
     * @param {object}  options Options
     * @param {int}     options.testplanid Test Plan id
     *
     * @returns {object}  result Result object.
     */
    getBuildsForTestPlan(options) {
        checkMandatoryFields(options, ["testplanid"]);

        return this._performRequest('getBuildsForTestPlan', options)
    }

    /**
     * Gets the latest build by choosing the maximum build id for a specific test plan
     *
     * @param {object}  options Options
     * @param {int}     options.testplanid Test Plan id
     *
     * @returns {object}  result Result object.
     */
    getLatestBuildForTestPlan(options) {
        checkMandatoryFields(options, ["testplanid"]);

        return this._performRequest('getLatestBuildForTestPlan', options)
    }

    /**
     * Gets the result of LAST EXECUTION for a particular testcase on a test plan.
     * If there are no filter criteria regarding platform and build,
     * result will be get WITHOUT checking for a particular platform and build.
     *
     * @param {object}  options Options
     * @param {int}     options.tplanid Test Plan id.
     * @param {string}  [options.testcaseid] Test Case id. If not present, testcaseexternalid must be present.
     * @param {string}  [options.testcaseexternalid] Test Case external id. If not present, testcaseid must be present.
     * @param {int}     [options.platformid] Platform id number. If not specified, plaformname must be
     * @param {string}  [options.platformname] Platform name. If not specified, platformid must be
     * @param {int}     [options.buildid] Build id number. If this and buildname are not specified, the latest build will be used.
     * @param {string}  [options.buildname] Build name. If this and buildid are not specified, the latest build will be used.
     * @param {object}  [options.options]
     * @param {boolean} [options.options.getBugs]
     *
     * @returns {object}  result Result object.
     */
    getLastExecutionResult(options) {
        checkMandatoryFields(options, [
            "tplanid",
            ["testcaseid", "testcaseexternalid"],
            ["platformid", "platformname"],
            ["buildid", "buildname"]
        ]);

        return this._performRequest('getLastExecutionResult', options)
    }

    /**
     * List test suites within a test plan alphabetically
     *
     * @param {object}  options Options
     * @param {int}     options.testplanid Test Plan id
     *
     * @returns {object}  result Result object.
     */
    getTestSuitesForTestPlan(options) {
        checkMandatoryFields(options, ["testplanid"]);

        return this._performRequest('getTestSuitesForTestPlan', options)
    }

    /**
     * Get list of TestSuites which are DIRECT children of a given TestSuite
     *
     * @param {object}  options Options
     * @param {int}     options.testsuiteid Test Suite id.
     *
     * @returns {object}  result Result object.
     */
    getTestSuitesForTestSuite(options) {
        checkMandatoryFields(options, ["testsuiteid"]);

        return this._performRequest('getTestSuitesForTestSuite', options)
    }

    /**
     * List test cases within a test suite
     *
     * @param {object}  options Options
     * @param {int}     options.testsuiteid
     * @param {boolean} [options.deep=true] If set to false, fetch only from top level Test Suite
     * @param {string}  [options.details="simple"] Valid values are "simple and "full". On "full" summary,steps & expected_results are also represented. (@see constants.Details)
     * @param {boolean} [options.getkeywords=false] Get, or not, keywords
     *
     * @returns {object}  result Result object.
     */
    getTestCasesForTestSuite(options) {
        checkMandatoryFields(options, ["testsuiteid"]);

        return this._performRequest('getTestCasesForTestSuite', options)
    }

    /**
     * List test cases linked to a test plan
     *
     * @param {object}  options Options
     * @param {int}     options.testplanid Test Plan id.
     * @param {int}     [options.buildid] Build id.
     * @param {int}     [options.platformid] Platform id.
     * @param {int}     [options.testcaseid] Test Case id.
     * @param {string}  [options.keywordid] Keyword id. If not present, keywords will be queried.
     * @param {string}  [options.keywords] Keyword name. If not present, keywordid will be queried
     * @param {boolean} [options.executed]
     * @param {int}     [options.assignedto]
     * @param {string}  [options.executestatus] (@see constants.ExecutionStatus)
     * @param {array}   [options.executiontype] (@see constants.ExecutionType)
     * @param {array}   [options.getstepinfo] - default false
     * @param {string}  [options.details="full"] Valid values are "simple and "full". On "full" summary,steps & expected_results are also represented. (@see constants.Details)
     *
     * @returns {object}  result Result object.
     */
    getTestCasesForTestPlan(options) {
        checkMandatoryFields(options, ["testplanid"]);

        return this._performRequest('getTestCasesForTestPlan', options)
    }

    /**
     * Find a test case by its name (Note. Case sensitive)
     *
     * No results will be returned if there are test cases with the same name that match the criteria provided.
     *
     * @param {object}  options
     * @param {string}  options.testcasename Test Case name
     * @param {string}  [options.testsuitename] Test Suite name
     * @param {string}  [options.testprojectname] Project name
     * @param {string}  [options.testcasepathname] Test Case path
     *                                             (Full test case path name, starts with test project name,
     *                                             use pieces separator -> :: -> default value of getByPathName())
     *
     * @returns {object}  result Result object.
     */
    getTestCaseIDByName(options) {
        checkMandatoryFields(options, ["testcasename"]);

        return this._performRequest('getTestCaseIDByName', options)
    }

    /**
     * Gets value of a Custom Field with scope='design' for a given Test case
     *
     * @param {object}  options Options
     *
     * @param {object}  options Options
     * @param {string}  options.testcaseexternalid: Test Case external id
     * @param {string}  options.version: Version number
     * @param {string}  options.testprojectid: Project id
     * @param {string}  options.customfieldname: Custom field name
     * @param {string}  [options.details=value] Details format (@see constants.Details)
     *                                          "value": Returns just the value
     *                                          "simple": value plus custom field name, label, and type (as code)
     *                                          "full": Returns a map with all custom field definition plus value and internal test case id
     *
     * @returns {object}  result Result object.
     */
    getTestCaseCustomFieldDesignValue(options) {
        checkMandatoryFields(options, ["testcaseexternalid", "version", "testprojectid", "customfieldname"]);

        return this._performRequest('getTestCaseCustomFieldDesignValue', options)
    }

    /**
     * Gets a Custom Field of a Test Case in Execution Scope.
     *
     * @param {object}  options Options
     * @param {string}  options.customfieldname: Custom field name
     * @param {int}     options.testprojectid: Project id
     * @param {int}     options.executionid: Execution id
     * @param {int}     options.version: Test Case version NUMBER
     * @param {int}     options.testplanid: Test Plan id
     *
     * @returns {object}  result Result object.
     */
    getTestCaseCustomFieldExecutionValue(options) {
        checkMandatoryFields(options, ["customfieldname", "testprojectid", "executionid", "version", "testplanid"]);

        return this._performRequest('getTestCaseCustomFieldExecutionValue', options)
    }

    /**
     * Gets a Custom Field of a Test Case in Test Plan Design Scope.
     *
     * @param {object}  options Options
     * @param {string}  options.customfieldname: Custom field name
     * @param {int}     options.testcaseid: Project id
     * @param {int}     options.version: Test Case version id
     * @param {int}     options.testplanid: Test Plan id
     * @param {int}     options.linkid: Link id (important!)
     *
     * @returns {object}  result Result object.
     */
    getTestCaseCustomFieldTestPlanDesignValue(options) {
        checkMandatoryFields(options, ["customfieldname", "testcaseid", "version", "testplanid", "linkid"]);

        return this._performRequest('getTestCaseCustomFieldTestPlanDesignValue', options)
    }

    /**
     * Gets a Custom Field of a Test Suite in Design Scope.
     *
     * @param {object}  options Options
     * @param {string}  options.customfieldname: Custom field name
     * @param {int}     options.testprojectid: Project id
     * @param {int}     options.testsuiteid: Test Suite id
     *
     * @returns {object}  result Result object.
     */
    getTestSuiteCustomFieldDesignValue(options) {
        checkMandatoryFields(options, ["customfieldname", "testprojectid", "testsuiteid"]);

        return this._performRequest('getTestSuiteCustomFieldDesignValue', options)
    }

    /**
     * Gets a Custom Field of a Test Plan in Design Scope.
     *
     * @param {object}  options Options
     * @param {string}  options.customfieldname: Custom field name
     * @param {int}     options.testprojectid: Project id
     * @param {int}     options.testplanid: Test Plan id
     *
     * @returns {object}  result Result object.
     *
     */
    getTestPlanCustomFieldDesignValue(options) {
        checkMandatoryFields(options, ["customfieldname", "testprojectid", "testplanid"]);

        return this._performRequest('getTestPlanCustomFieldDesignValue', options)
    }

    /**
     * Gets a Custom Field of a Requirement Specification in Design Scope.
     *
     * @param {object}  options Options
     * @param {string}  options.customfieldname: Custom field name
     * @param {int}     options.testprojectid: Project id
     * @param {int}     options.reqspecid: Requirement Specification id
     *
     * @returns {object}  result Result object.
     */
    getReqSpecCustomFieldDesignValue(options) {
        checkMandatoryFields(options, ["customfieldname", "testprojectid", "reqspecid"]);

        return this._performRequest('getReqSpecCustomFieldDesignValue', options)
    }

    /**
     * Gets a Custom Field of a Requirement in Design Scope.
     *
     * @param {object}  options Options
     * @param {string}  options.customfieldname: Custom field name
     * @param {int}     options.testprojectid: Project id
     * @param {int}     options.requirementid: Requirement id
     *
     * @returns {object}  result Result object.
     */
    getRequirementCustomFieldDesignValue(options) {
        checkMandatoryFields(options, ["customfieldname", "testprojectid", "requirementid"]);

        return this._performRequest('getRequirementCustomFieldDesignValue', options)
    }

    /**
     * Get set of test suites AT TOP LEVEL of tree on a Test Project
     *
     * @param options Options
     * @param options.testprojectid Project id
     *
     * @returns {object}  result Result object.
     */
    getFirstLevelTestSuitesForTestProject(options) {
        checkMandatoryFields(options, ["testprojectid"]);

        return this._performRequest('getFirstLevelTestSuitesForTestProject', options)
    }

    /**
     * Gets attachments for specified test case.
     *
     * @param {object}  options Options
     * @param {string}  [options.testcaseid] Test Case id. If not present, testcaseexternalid must be present.
     * @param {string}  [options.testcaseexternalid] Test Case external id. If not present, testcaseid must be present.
     *
     * @returns {object}  result Result object.
     */
    getTestCaseAttachments(options) {
        checkMandatoryFields(options, [["testcaseid", "testcaseexternalid"]]);

        return this._performRequest('getTestCaseAttachments', options)
    }

    /**
     * Gets attachments for specified test suite.
     *
     * @param {object}  options Options
     * @param {int}     options.testsuiteid: Test Suite id.
     *
     * @returns {object}  result Result object.
     */
    getTestSuiteAttachments(options) {
        checkMandatoryFields(options, ["testsuiteid"]);

        return this._performRequest('getTestSuiteAttachments', options)
    }

    /**
     * Gets Test Case
     *
     * @param {object}  options Options
     * @param {string}  [options.testcaseid] Test Case id. If not present, testcaseexternalid must be present.
     * @param {string}  [options.testcaseexternalid] Test Case external id. If not present, testcaseid must be present.
     * @param {string}  [options.version] Test Case version.
     *
     * @returns {object}  result Result object.
     */
    getTestCase(options) {
        checkMandatoryFields(options, [["testcaseid", "testcaseexternalid"]]);

        return this._performRequest('getTestCase', options)
    }

    /**
     * Gets attachments for specified test case.
     *
     * @param {object}  options Options
     * @param {string}  [options.testcaseid] Test Case id. If not present, testcaseexternalid must be present.
     * @param {string}  [options.testcaseexternalid] Test Case external id. If not present, testcaseid must be present.
     *
     * @returns {object}  result Result object.
     */
    getFullPath(options) {
        checkMandatoryFields(options, [["testcaseid", "testcaseexternalid"]]);

        return this._performRequest('getFullPath', options)
    }

    /**
     * Return a TestSuite by ID
     *
     * @param {object}  options Options
     * @param {int}     options.testsuiteid
     *
     * @returns {object}  result Result object.
     */
    getTestSuiteByID(options) {
        checkMandatoryFields(options, ["testsuiteid"]);

        return this._performRequest('getTestSuiteByID', options)
    }


    /**
     * Gets user data
     *
     * @param {object}  options Options
     * @param {string}  options.user Login Name
     *
     * @returns {object}  result Result object.
     * @returns {string}  result.firstName
     * @returns {string}  result.lastName
     * @returns {string}  result.emailAddress
     * @returns {string}  result.locale
     * @returns {boolean} result.isActive
     * @returns {string}  result.defaultTestprojectID
     * @returns {string}  result.globalRoleID
     * @returns {string}  result.globalRole
     * @returns {string}  result.tprojectRoles
     * @returns {string}  result.tplanRoles
     * @returns {string}  result.login
     * @returns {string}  result.dbID
     * @returns {string}  result.loginRegExp
     */
    getUserByLogin(options) {
        checkMandatoryFields(options, ["user"]);

        return this._performRequest('getUserByLogin', options)
    }

    /**
     * Gets user data
     *
     * @param {object}  options Options
     * @param {string}  options.userid User id
     *
     * @returns {object}  result Result object.
     * @returns {string}  result.firstName
     * @returns {string}  result.lastName
     * @returns {string}  result.emailAddress
     * @returns {string}  result.locale
     * @returns {boolean} result.isActive
     * @returns {string}  result.defaultTestprojectID
     * @returns {string}  result.globalRoleID
     * @returns {string}  result.globalRole
     * @returns {string}  result.tprojectRoles
     * @returns {string}  result.tplanRoles
     * @returns {string}  result.login
     * @returns {string}  result.dbID
     * @returns {string}  result.loginRegExp
     */
    getUserByID(options) {
        checkMandatoryFields(options, ["userid"]);

        return this._performRequest('getUserByID', options)
    }

    /**
     * Delete an execution
     *
     * @param {object}  options
     * @param {int}     options.executionid
     *
     * @returns {object}  result Result object.
     * @returns {boolean} result.status Status of request.
     * @returns {int}     result.id Result id if success or error code.
     * @returns {string}  result.message If an error ocurred, the error message.
     */
    deleteExecution(options) {
        checkMandatoryFields(options, ["executionid"]);

        return this._performRequest('deleteExecution', options)
    }


    /**
     * Check if an user exists
     *
     * @param {int}     options.user user name
     *
     * @return true if everything OK, otherwise error structure
     */
    doesUserExist(options) {
        checkMandatoryFields(options, ["user"]);

        return this._performRequest('doesUserExist', options)
    }

    /**
     * Update value of Custom Field with scope='design' for a given Test case
     *
     * @param {object}  options Options
     *
     * @param {object}  options Options
     * @param {string}  options.testcaseexternalid:  Test Case external id
     * @param {string}  options.version: Version number
     * @param {string}  options.testprojectid: Project id
     * @param {object}  [options.customfields] Map containing a key-value object with custom fields.
     *
     * @return {object} } null if everything ok, else array of IXR_Error objects

     */
    updateTestCaseCustomFieldDesignValue(options) {
        checkMandatoryFields(options, ["testcaseexternalid", "version", "testprojectid"]);

        return this._performRequest('updateTestCaseCustomFieldDesignValue', options)
    }

    /**
     * Update an existing test case
     * Not all test case attributes will be able to be updated using this method
     * See details below
     *
     * @param {object}  options Options
     * @param {string}  options.testcaseexternalid format PREFIX-NUMBER
     * @param {int}     [options.version] version NUMBER (human readable)
     * @param {string}  [options.testcasename]
     * @param {string}  [options.summary]
     * @param {string}  [options.preconditions]
     * @param {array}   [options.steps]
     * @param {array}   options.steps[].step_number Step's index number
     * @param {array}   options.steps[].actions The step text action (aka description)
     * @param {array}   [options.steps[].expected_results] The expectes result when the step is executed
     * @param {array}   options.steps[].execution_type Execution type (@see constants.ExecutionType).
     * @param {int}     [options.importance] Importance of TestCase (@see ImportanceLevel)
     * @param {int}     [options.executiontype] (@see constants.ExecutionType)
     * @param {int}     [options.status] Current Test Case status (final, future, obsolete, draft, ...) (@see constants.TestCaseStatus)
     * @param {int}     [options.estimatedexecduration]
     * @param {string}  [options.user] - login name used as updater
     */
    updateTestCase(options) {
        let fieldsToCheck = ["testcaseexternalid"];

        // Also check steps structure if "steps" is present
        if (options.hasOwnProperty("steps"))
            fieldsToCheck.push({"steps": ["step_number", "actions", "execution_type"]});

        checkMandatoryFields(options, fieldsToCheck);

        return this._performRequest('updateTestCase', options);
    }

    /**
     * Update execution type for a test case version
     *
     * @param {object}  options Options
     * @param {string}  options.testcaseexternalid Test Case external id
     * @param {string}  options.version Version number
     * @param {string}  options.testprojectid Project ID
     * @param {string}  options.executiontype (@see constants.ExecutionType)
     *
     * @return {object}  null if everything ok, else array of IXR_Error objects
     */
    setTestCaseExecutionType(options) {
        checkMandatoryFields(options, ["testcaseexternalid", "version", "testprojectid", "executiontype"]);

        return this._performRequest('setTestCaseExecutionType', options)
    }

    /**
     * Unassign a Test Case execution
     *
     * @param {object}  options Options
     * @param {int}     options.testplanid Test Plan id
     * @param {string}  options.testcaseexternalid Test Case external id
     * @param {string}  [options.buildid] Buid id. If not present, buildname must be present.
     * @param {string}  [options.buildname] Build name. If not present, buildid must be present.
     * @param {string}  [options.platformid] Platform id. If not present and Test Case has platforms, platformname must be present.
     * @param {string}  [options.platformname] Platform name. If not present and Test Case has platforms, platformid must be present.
     * @param {string}  options.user User name
     *
     * @returns {object}  result Result object.
     */
    assignTestCaseExecutionTask(options) {
        checkMandatoryFields(options, ["testplanid", "testcaseexternalid", ["buildid", "buildname"], "user"]);

        return this._performRequest('assignTestCaseExecutionTask', options)
    }

    /**
     * Unassign a Test Case execution
     *
     * @param {object}  options Options
     * @param {int}     options.testplanid Test Plan id
     * @param {string}  options.testcaseexternalid Test Case external id
     * @param {string}  [options.buildid] Buid id. If not present, buildname must be present.
     * @param {string}  [options.buildname] Build name. If not present, buildid must be present.
     * @param {string}  [options.platformid] Platform id. If not present and Test Case has platforms, platformname must be present.
     * @param {string}  [options.platformname] Platform name. If not present and Test Case has platforms, platformid must be present.
     * @param {string}  options.user User name
     *
     * @returns {object}  result Result object.
     */
    unassignTestCaseExecutionTask(options) {
        checkMandatoryFields(options, ["testplanid", "testcaseexternalid", ["buildid", "buildname"], "user"]);

        return this._performRequest('unassignTestCaseExecutionTask', options)
    }

    /**
     * Add keywords to TestCase
     *
     * @param {object}  options Options
     * @param {array}   options.keywords: Array with TestCase external id as key E.g: {keywords: ["MF-123": ["keywordA", "keywordB"]]}
     *
     * @returns {object}  result Result object.
     */
    addTestCaseKeywords(options) {
        checkMandatoryFields(options, ["keywords"]);

        return this._performRequest('addTestCaseKeywords', options)
    }

    /**
     * Remove keywords to TestCase
     *
     * @param {object}  options Options
     * @param {array}   options.keywords: Array with TestCase external id as key E.g: {keywords: ["MF-123": ["keywordA", "keywordB"]]}
     *
     * @returns {object}  result Result object.
     */
    removeTestCaseKeywords(options) {
        checkMandatoryFields(options, ["keywords"]);

        return this._performRequest('removeTestCaseKeywords', options)
    }

    /**
     * Update value of Custom Field with scope='design' for a given Test Suite
     *
     * @param {object}  options Options
     *
     * @param {string}  options.testsuiteid Test Suite id
     * @param {string}  options.testprojectid Project id
     * @param {object}  options.customfields Map containing a key-value object with custom fields.
     *
     * @returns {object}  result Result object.
     */
    updateTestSuiteCustomFieldDesignValue(options) {
        checkMandatoryFields(options, ["testsuiteid", "testprojectid", "customfields"]);

        return this._performRequest('updateTestSuiteCustomFieldDesignValue', options)
    }

    /**
     * Update value of Custom Field with scope='design' for a given Build
     *
     * @param {object}  options Options
     * @param {string}  options.buildid Build id
     * @param {string}  options.testprojectid Project id
     * @param {object}  options.customfields Map containing a key-value object with custom fields.
     *
     * @returns {object}  result Result object.
     *
     */
    updateBuildCustomFieldsValues(options) {
        checkMandatoryFields(options, ["buildid", "testprojectid", "customfields"]);

        return this._performRequest('updateBuildCustomFieldsValues', options)
    }

    /**
     * Returns all test suites inside target test project with target name
     *
     * @param {object}  options Options
     * @param {int}     options.testsuitename
     * @param {string}  options.prefix
     *
     * @returns {object}  result Result object.
     */
    getTestSuite(options) {
        checkMandatoryFields(options, ["testsuitename", "prefix"]);

        return this._performRequest('getTestSuite', options)
    }

    /**
     * update a test suite
     *
     * @param {object}  options Options
     * @param {int}     [options.testprojectid] Project id. Madatory if prefix is not present
     * @param {int}     [options.prefix] Project prefix. Madatory if testprojectid is not present
     * @param {string}  [options.testsuitename] New Test Suite name
     * @param {string}  [options.details] New Test Suite description
     * @param {int}     [options.parentid] If not provided, the Test Suite will be top-level
     * @param {int}     [options.order] Order inside parent container
     *
     * @returns {object}  result Result object.
     */
    updateTestSuite(options) {
        checkMandatoryFields(options, [["testprojectid", "prefix"],]);

        return this._performRequest('updateTestSuite', options)
    }

    /**
     * Get requirements
     *
     * @param {object}  options Options
     * @param {string}  options.testprojectid Project id
     * @param {string}  [options.testplanid] Test Plan id
     * @param {string}  [options.platformid] Platform id. Mandatory if project has platforms
     *
     * @return mixed error if someting's wrong, else array of test cases
     */
    getRequirements(options) {
        checkMandatoryFields(options, ["testprojectid"]);

        return this._performRequest('getRequirements', options)
    }

    /**
     * Get requirement coverage. Retrieve the test cases associated to a requirement
     *
     * @param {object}  options Options
     * @param {string}  options.testprojectid Project id
     * @param {string}  options.requirementdocid Requirement doc id
     *
     * @return mixed error if someting's wrong, else array of test cases
     */
    getReqCoverage(options) {
        checkMandatoryFields(options, ["testprojectid", "requirementdocid"]);

        return this._performRequest('getReqCoverage', options)
    }

    /**
     * Set a Test Suite for a Test Case
     *
     * @param {object}  options Options
     * @param {string}  options.testcaseexternalid Test Case external id
     * @param {int}     options.testsuiteid Test Suite id
     *
     * @returns {object}  result Result object.
     */
    setTestCaseTestSuite(options) {
        checkMandatoryFields(options, ["testcaseexternalid", "testsuiteid"]);

        return this._performRequest('setTestCaseTestSuite', options)
    }

    /**
     * Gets a set of EXECUTIONS for a particular testcase on a test plan.
     *
     * @param {object}  options Options
     * @param {int}     options.tplanid Test Plan id
     * @param {string}  [options.testcaseid] Test Case id. If not present, testcaseexternalid must be present.
     * @param {string}  [options.testcaseexternalid] Test Case external id. If not present, testcaseid must be present.
     * @param {string}  [options.platformid] Platform id. If not present and Test Case has platforms, platformname must be present.
     * @param {string}  [options.platformname] Platform name. If not present and Test Case has platforms, platformid must be present.
     * @param {string}  [options.buildname] Build name. If not present, buildid must be present.
     * @param {int}     [options.options] options['getOrderDescending'] false(=ascending,default)
     *
     * @returns {object}  result Result object
     * @returns {object}  result.id Execution id. If value is -1, means that there is no execution that matches the given criteria.
     * @returns {object}  result.build_id
     * @returns {object}  result.tester_id
     * @returns {object}  result.execution_ts
     * @returns {object}  result.status
     * @returns {object}  result.testplan_id
     * @returns {object}  result.tcversion_id
     * @returns {object}  result.tcversion_number
     * @returns {object}  result.execution_type
     * @returns {object}  result.notes
     */
    getExecutionSet(options) {
        checkMandatoryFields(options, ["tplanid", ["testcaseid", "testcaseexternalid"]]);

        return this._performRequest('getExecutionSet', options)
    }


    /**
     * Check if Developer Key exists.
     *
     * @param {object}  options Options
     * @param {string}  [options.devKey] TestLink API key. If not specified, the devKey used in constructor will be used.
     *
     * @return true if everything OK, otherwise error structure
     */
    checkDevKey(options = {}) {
        return this._performRequest('checkDevKey', options)
    }

    /**
     * Gives basic information about the API
     *
     * @returns {boolean}  result Result of check
     */
    about() {
        return this._performRequest('about', {})
    }

    /**
     * Returns the current TestLink version
     *
     * @returns {string}  result TestLink version
     */
    testLinkVersion() {
        return this._performRequest('testLinkVersion', {});
    }

    /**
     * Turn on/off testMode. This method is meant primarily for testing and debugging during development
     *
     * @param {object}  options Options
     *
     * @return boolean
     */
    setTestMode(options) {
        checkMandatoryFields(options, []);

        return this._performRequest('setTestMode', options)
    }

    /**
     * @see {@see sayHello}
     * @param {object}  options @see {@see sayHello#options}
     */
    ping() {
        return this._performRequest('ping', {})
    }

    /**
     * Lets you see if the server is up and running
     *
     * @return string "Hello!"
     */
    sayHello() {
        return this._performRequest('sayHello', {})
    }

    /**
     * Repeats a message back
     *
     * @param {object}  options
     * @param {object}  options.str
     *
     * @return string
     */
    repeat(options) {
        checkMandatoryFields(options, ["str"]);

        return this._performRequest('repeat', options)
    }

    /**
     * Gets ALL EXECUTIONS for a particular testcase on a test plan.
     * If there are no filter criteria regarding platform and build,
     * result will be get WITHOUT checking for a particular platform and build.
     *
     * @param {object}  options Options
     * @param {int}     options.tplanid
     * @param {string}  [options.testcaseid] Test Case id. If not present, testcaseexternalid must be present.
     * @param {string}  [options.testcaseexternalid] Test Case external id. If not present, testcaseid must be present.
     * @param {string}  [options.platform_id] Platform id.
     * @param {int}     [options.build_id] Platform id
     * @param {int}     [options.options] options['getBugs'] = true / false
     * @param {int}     [options.options.getBugs] Get, or not, an array of bugs
     *
     * @returns {object}  result Result object.
     * @returns {object}  result.id Execution id. If value is -1, means that there is no execution that matches the given criteria.
     * @returns {object}  result.build_id
     * @returns {object}  result.tester_id
     * @returns {object}  result.execution_ts
     * @returns {object}  result.status
     * @returns {object}  result.testplan_id
     * @returns {object}  result.tcversion_id
     * @returns {object}  result.tcversion_number
     * @returns {object}  result.execution_type
     * @returns {object}  result.notes
     */
    getAllExecutionsResults(options) {
        checkMandatoryFields(options, ["testcaseid", "testcaseexternalid"]);

        return this._performRequest('getAllExecutionsResults', options)
    }

    /**
     * Perform a request to XML-RPC TestLink API.
     *
     * @param {string}  method Method name to be invoked in TestLink.
     * @param {object}  options Options needed by the method to perform an action.
     * @returns {Promise} Promise object represents the request response.
     */
    _performRequest(method, options = {}) {
        if (options.hasOwnProperty('apiKey'))
            options.devKey = options.apiKey;
        else if (!options.hasOwnProperty('devKey'))
            options.devKey = this.apiKey;

        return new Promise((resolve, reject) => {
            this.rpcClient.methodCall('tl.' + method, [options], (error, value) => {
                if (error)
                    return reject(error);
                else if (value.status_ok === 0)
                    return reject(value.msg);
                else if (Array.isArray(value)) {
                    for (let v of value) {
                        if (v.hasOwnProperty("code"))
                            return reject("[" + v.code + "] " + v.message);
                    }
                }
                return resolve(value);
            });
        });
    }
}

/**
 * Check mandatory fields in various ways
 *
 * @param {Object|Array} options Options to be checked
 * @param {array}   mandatoryFields Array with fields to check
 *     - If a String is given, check if it exists inside options
 *     - If an Array is given, check if at least one of the elements exists
 *     - If an Object is given, check if the field exists in options and also it inner options.
 *
 * @throws Error if field not found.
 */
function checkMandatoryFields(options, mandatoryFields) {
    if (Array.isArray(options)) {
        for (let suboptions of options) {
            checkMandatoryFields(suboptions, mandatoryFields);
        }
    } else {
        for (let field of mandatoryFields) {
            if (Array.isArray(field)) {
                if (!_checkMandatoryFieldsArray(options, field))
                    throw Error("Expected one of this fields: [" + field + "].");
            } else if (typeof field === 'object')
                _checkMandatoryFieldsObject(options, field);
            else if (!(field in options))
                throw Error("Field '" + field + "' not present.");
        }
    }
}

function _checkMandatoryFieldsArray(options, field) {
    for (let subfield of field) {
        if (subfield in options)
            return true;
    }

    return false;
}

function _checkMandatoryFieldsObject(options, field) {
    for (let fieldKey in field) {
        if (fieldKey in options)
            checkMandatoryFields(options[fieldKey], field[fieldKey]);
        else
            throw Error("Field '" + fieldKey + "' not present.")
    }
}

module.exports = TestLink;
