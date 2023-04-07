import {expect} from 'chai';

import {TestLink} from '../src';
import TL_CONFIG_TEST from './_tests.config';
import {Details, ExecutionStatus, ExecutionType, StepAction} from '../src/constants';

describe('Test Cases', () => {
    let testlink: TestLink;
    before(function () {
        testlink = new TestLink({
            apiKey: TL_CONFIG_TEST.users.admin.apiKey,
            path: TL_CONFIG_TEST.path,
            rpcPath: TL_CONFIG_TEST.rpcPath,
            port: TL_CONFIG_TEST.port
        });
    });

    describe('Retrieve Test Cases info', () => {
        it('getTestCasesForTestSuite', async () => {
            const testCases = await testlink.getTestCasesForTestSuite({
                testsuiteid: 6
            });
            expect(testCases[0]).to.deep.include({
                id: '8',
                parent_id: '6',
                node_type_id: '3',
                node_order: '1000',
                node_table: 'testcases',
                name: 'TestCase 1',
                external_id: 'TP-1'
            });
        });

        it('getTestCasesForTestPlan', async () => {
            const testCases = await testlink.getTestCasesForTestPlan({
                testplanid: 12,
            });

            expect(testCases).to.have.property('8').that.have.property('0').that.deep.include({
                tcase_name: 'TestCase 1',
                tcase_id: '8',
                tc_id: '8',
                tcversion_id: '9',
                version: '1',
                external_id: '1',
                execution_type: '1',
                status: '1',
                feature_id: '1',
                platform_id: '0',
                platform_name: '',
                execution_order: '1',
                exec_status: 'p',
                execution_duration: '61.00',
                full_external_id: 'TP-1',
                exec_id: '1',
                tcversion_number: '1',
                exec_on_build: '3',
                exec_on_tplan: '12'
            });
        });

        it('getTestCaseIDByName', async () => {
            const response = await testlink.getTestCaseIDByName({
                testcasename: 'TestCase 1'
            });

            expect(response[0]).to.deep.include({
                id: '8',
                name: 'TestCase 1',
                parent_id: '6',
                tsuite_name: 'Test Suite Minefield',
                tc_external_id: '1'
            });
        });

        it('getTestCaseCustomFieldDesignValue - Detail.VALUE', async () => {
            const response = await testlink.getTestCaseCustomFieldDesignValue({
                testcaseexternalid: 'TP-1',
                version: 1,
                testprojectid: 3,
                customfieldname: 'CF_TestCase_TSD',
                details: Details.VALUE
            });
            expect(response).to.be.equals('Value for CF TC');
        });

        it('getTestCaseCustomFieldDesignValue - Detail.SIMPLE', async () => {
            const response = await testlink.getTestCaseCustomFieldDesignValue({
                testcaseexternalid: 'TP-1',
                version: 1,
                testprojectid: 3,
                customfieldname: 'CF_TestCase_TSD',
                details: Details.SIMPLE
            });
            expect(response).to.deep.include({
                name: 'CF_TestCase_TSD',
                label: 'CF TestCase Test Spec Design',
                type: '0',
                value: 'Value for CF TC'
            });
        });

        it('getTestCaseCustomFieldDesignValue - Detail.FULL', async () => {
            const response = await testlink.getTestCaseCustomFieldDesignValue({
                testcaseexternalid: 'TP-1',
                version: 1,
                testprojectid: 3,
                customfieldname: 'CF_TestCase_TSD',
                details: Details.FULL
            });
            expect(response).to.deep.include({
                id: '4',
                name: 'CF_TestCase_TSD',
                label: 'CF TestCase Test Spec Design',
                type: '0',
                possible_values: '',
                default_value: '',
                valid_regexp: '',
                length_min: '0',
                length_max: '0',
                show_on_design: '1',
                enable_on_design: '1',
                show_on_execution: '1',
                enable_on_execution: '0',
                show_on_testplan_design: '0',
                enable_on_testplan_design: '0',
                display_order: '1',
                location: '1',
                required: '0',
                value: 'Value for CF TC',
                node_id: '9'
            });
        });

        it('getTestCaseCustomFieldExecutionValue', async () => {
            const response = await testlink.getTestCaseCustomFieldExecutionValue({
                customfieldname: 'CF_TestCase_TE',
                testprojectid: 3,
                executionid: 1,
                version: 1,
                testplanid: 12,
            });
            expect(response).to.deep.equals({
                id: '7',
                name: 'CF_TestCase_TE',
                label: 'CF TestCase Test Execution',
                type: '0',
                possible_values: '',
                default_value: '',
                valid_regexp: '',
                length_min: '0',
                length_max: '0',
                show_on_design: '0',
                enable_on_design: '0',
                show_on_execution: '1',
                enable_on_execution: '1',
                show_on_testplan_design: '0',
                enable_on_testplan_design: '0',
                display_order: '1',
                location: '1',
                required: '0',
                value: 'CF Value execution',
                node_id: '9'
            });
        });

        it('getTestCaseCustomFieldTestPlanDesignValue', async () => {
            const response = await testlink.getTestCaseCustomFieldTestPlanDesignValue({
                customfieldname: 'CF_TestCase_TPD',
                testprojectid: 3,
                version: 1,
                testplanid: 12,
                linkid: 0
            });
            expect(response).to.deep.include({
                id: '8',
                name: 'CF_TestCase_TPD',
                label: 'CF TestCase Test Plan Design',
                type: '0',
                possible_values: '',
                default_value: '',
                valid_regexp: '',
                length_min: '0',
                length_max: '0',
                show_on_design: '0',
                enable_on_design: '0',
                show_on_execution: '1',
                enable_on_execution: '0',
                show_on_testplan_design: '1',
                enable_on_testplan_design: '1',
                display_order: '1',
                required: '0',
                value: '',
                node_id: ''
            });
        });

        it('getTestCaseRequirements', async () => {
            const response = await testlink.getTestCaseRequirements({
                testcaseversionid: 11,
            });
            expect(response).to.deep.include({
                id: '43',
                req_id: '43',
                req_doc_id: 'ReqUC1',
                title: 'Requirement 1',
                is_active: '1',
                testcase_id: '10',
                tcversion_id: '11',
                req_spec_title: 'Editable Requirement Section',
                req_version_id: '44',
                version: '1',
            });
        });

        it('getTestCase', async () => {
            const testCase = await testlink.getTestCase({
                testcaseexternalid: 'TP-1'
            });
            expect(testCase[0]).to.be.deep.include(
                {
                    updater_login: 'admin',
                    author_login: 'admin',
                    name: 'TestCase 1',
                    node_order: '1000',
                    testsuite_id: '6',
                    testcase_id: '8',
                    id: '9',
                    tc_external_id: '1',
                    version: '1',
                    layout: '1',
                    status: '1',
                    summary: '',
                    preconditions: '',
                    importance: '2',
                    author_id: '1',
                    active: '1',
                    is_open: '1',
                    execution_type: '1',
                    estimated_exec_duration: '',
                    author_first_name: 'Testlink',
                    author_last_name: 'Administrator',
                    full_tc_external_id: 'TP-1'
                });
        });
    });

    describe('Manage Test Cases', () => {
        it('createTestCase', async () => {
            const response = await testlink.createTestCase({
                testcasename: 'Auto TC',
                testsuiteid: 5,
                testprojectid: 4,
                authorlogin: 'admin',
                summary: '',
                steps: []
            });

            response.forEach(r => expect(r).to.deep.include({
                operation: 'createTestCase',
                status: true,
                message: 'Success!'
            }));
        });

        it('updateTestCaseCustomFieldDesignValue', async () => {
            const response = await testlink.updateTestCaseCustomFieldDesignValue({
                testcaseexternalid: 'EP-1',
                testprojectid: 4,
                version: 1,
                customfields: {4: 'New value'},
            });
            expect(response).to.be.equals('');
        });

        it('updateTestCase', async () => {
            const response = await testlink.updateTestCase({
                testcaseexternalid: 'EP-1',
                testcasename: 'New name'
            });
            expect(response).to.be.deep.equal({
                status_ok: true,
                msg: 'ok',
                operation: 'updateTestCase'
            });
        });

        it('setTestCaseExecutionType', async () => {
            const response = await testlink.setTestCaseExecutionType({
                testcaseexternalid: 'EP-1',
                testprojectid: 4,
                version: 1,
                executiontype: ExecutionType.AUTOMATED
            });
            expect(response).to.deep.include({
                testcaseexternalid: 'EP-1',
                testprojectid: 4,
                version: 1,
                executiontype: 2,
                testcaseid: 10
            });
        });

        it('assignTestCaseExecutionTask', async () => {
            const response = await testlink.assignTestCaseExecutionTask({
                testplanid: 13,
                testcaseexternalid: 'EP-1',
                buildid: 1,
                platformid: 4,
                user: 'admin'
            });
            expect(response).to.deep.include({
                status: true,
                args: {
                    testplanid: 13,
                    testcaseexternalid: 'EP-1',
                    buildid: 1,
                    platformid: 4,
                    user: 'admin',
                    action: 'assignOne',
                    testcaseid: 10
                }
            });
        });

        it('unassignTestCaseExecutionTask', async () => {
            const response = await testlink.unassignTestCaseExecutionTask({
                testplanid: 13,
                testcaseexternalid: 'EP-2',
                buildname: 'Editable Build',
                platformid: 4,
                user: 'admin'
            });
            expect(response).to.deep.include({
                status: true,
                args: {
                    testplanid: 13,
                    testcaseexternalid: 'EP-2',
                    buildid: '1',
                    buildname: 'Editable Build',
                    platformid: 4,
                    user: 'admin',
                    action: 'unassignOne',
                    testcaseid: 20
                }
            });
        });

        it('addTestCaseKeywords', async () => {
            const response = await testlink.addTestCaseKeywords({
                keywords: {
                    'EP-1': ['Assignable keyword'],
                }
            });
            expect(response).to.deep.include({
                validKeywords: {
                    'EP-1': {
                        '2': 'Assignable keyword',
                    }
                },
                status_ok: true
            });
        });

        it('removeTestCaseKeywords', async () => {
            const response = await testlink.removeTestCaseKeywords({
                keywords: {
                    'EP-1': ['Assigned keyword'],
                }
            });
            expect(response).to.deep.include({
                validKeywords: {
                    'EP-1': {
                        '3': 'Assigned keyword',
                    }
                },
                status_ok: true
            });
        });

        it('setTestCaseTestSuite', async () => {
            const response = await testlink.setTestCaseTestSuite({
                testcaseexternalid: 'EP-1',
                testsuiteid: 5
            });
            expect(response[0]).to.deep.include({
                operation: 'setTestCaseTestSuite',
                status: true,
                message: 'Success!'
            });
        });
    });

    describe('Steps', () => {
        it('createTestCaseSteps', async () => {
            const response = await testlink.createTestCaseSteps({
                testcaseexternalid: 'EP-2',
                version: 1,
                action: StepAction.PUSH,
                steps: [{
                    step_number: 3,
                    actions: 'Auto created step',
                    expected_results: 'Step added by tests',
                    execution_type: ExecutionType.AUTOMATED,
                }],
            });
            expect(response).to.deep.include({
                testcaseid: 20,
                item: '',
                version: 'exists',
                tcversion_id: '21',
                feedback: [
                    {
                        operation: 'push',
                        step_number: 3
                    }
                ]
            });
        });

        it('deleteTestCaseSteps', async () => {
            const response = await testlink.deleteTestCaseSteps({
                testcaseexternalid: 'EP-2',
                version: 1,
                steps: [2],
            });
            expect(response).to.deep.include({
                testcaseid: 20,
                item: '',
                version: 'exists',
            });
        });
    });

    describe('Report', () => {
        it('reportTCResult', async () => {
            const response = await testlink.reportTCResult({
                testcaseexternalid: 'EP-4',
                testplanid: 39,
                status: ExecutionStatus.PASSED,
                steps: [{
                    step_number: 1,
                    result: ExecutionStatus.PASSED,
                    notes: 'Auto run'
                }, {
                    step_number: 2,
                    result: ExecutionStatus.PASSED,
                    notes: 'Auto run'
                }, {
                    step_number: 3,
                    result: ExecutionStatus.PASSED,
                    notes: 'Auto run'
                }],
                buildname: 'Reportable Build',
                execduration: 61,
                platformname: 'Reportable Platform',
                overwrite: true,
                user: 'admin',
            });
            expect(response[0]).to.deep.include({
                status: true,
                operation: 'reportTCResult',
                overwrite: true,
                message: 'Success!',
            });
        });

        it('setTestCaseExecutionResult', async () => {
            const response = await testlink.setTestCaseExecutionResult({
                testcaseexternalid: 'EP-5',
                testplanid: 39,
                status: ExecutionStatus.PASSED,
                steps: [{
                    step_number: 1,
                    result: ExecutionStatus.PASSED,
                    notes: 'Auto run'
                }, {
                    step_number: 2,
                    result: ExecutionStatus.PASSED,
                    notes: 'Auto run'
                }, {
                    step_number: 3,
                    result: ExecutionStatus.PASSED,
                    notes: 'Auto run'
                }],
                buildname: 'Reportable Build',
                execduration: 61,
                platformname: 'Reportable Platform',
                overwrite: true,
                user: 'admin',
            });
            expect(response[0]).to.deep.include({
                status: true,
                operation: 'reportTCResult',
                overwrite: true,
                message: 'Success!',
            });
        });
    });
});
