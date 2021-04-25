import {expect} from 'chai';

import {TestLink} from '../src';
import TL_CONFIG_TEST from './_tests.config';

describe('Test Suites', () => {
    let testlink: TestLink;
    before(function () {
        testlink = new TestLink({
            apiKey: TL_CONFIG_TEST.users.admin.apiKey,
            path: TL_CONFIG_TEST.path,
            rpcPath: TL_CONFIG_TEST.rpcPath,
            port: TL_CONFIG_TEST.port
        });
    });

    describe('Manage TestSuite', () => {
        it('createTestSuite', async () => {
            const testSuite = await testlink.createTestSuite({
                testprojectid: 4,
                testsuitename: 'Auto created TS',
            });

            testSuite.forEach(ts => expect(ts).to.deep.include({
                name: '',
                name_changed: false,
                operation: 'createTestSuite',
                additionalInfo: '',
                message: 'ok',
                status: true,
            }));
        });

        it('updateTestSuite', async () => {
            const testSuite = await testlink.updateTestSuite({
                testprojectid: 4,
                testsuiteid: 5,
                testsuitename: 'Test Suite Minefield',
                details: 'Modified details',
                order: 1,
            });
            
            expect(testSuite).to.deep.include({
                additionalInfo: '',
                message: 'ok',
                operation: 'updateTestSuite',
                status: true,
            });
        });

        it('updateTestSuiteCustomFieldDesignValue', async () => {
            const response = await testlink.updateTestSuiteCustomFieldDesignValue({
                testprojectid: 3,
                testsuiteid: 5,
                customfields: {
                    6: 'Updated CF value'
                },
            });

            response.forEach(r => expect(r).to.deep.include({
                msg: 'Custom Field:6 processed ',
                status: 'ok',
            }));
        });
    });

    describe('Retrieve info', () => {
        it('getTestSuite - First level', async () => {
            const testSuite = await testlink.getTestSuite({
                testsuitename: 'Test Suite Minefield',
                prefix: 'IP',
            });
            
            testSuite.forEach(ts => expect(ts).to.deep.include({
                name: 'Test Suite Minefield',
                node_order: '1',
                node_table: 'testsuites',
                node_type_id: '2',
            }));
        });

        it('getTestSuite - Second level', async () => {
            const testSuite = await testlink.getTestSuite({
                testsuitename: 'SubTest Suite',
                prefix: 'IP',
            });

            testSuite.forEach(ts => expect(ts).to.deep.include({
                name: 'SubTest Suite',
                node_order: '1',
                node_table: 'testsuites',
                node_type_id: '2',
                parent_id: '3',
            }));
        });

        it('getTestSuitesForTestPlan', async () => {
            const testSuite = await testlink.getTestSuitesForTestPlan({
                testplanid: 12,
            });

            testSuite.forEach(ts => expect(ts).to.deep.include({
                name: 'Test Suite Minefield',
                parent_id: '3',
            }));
        });

        it('getTestSuitesForTestSuite', async () => {
            const testSuite = await testlink.getTestSuitesForTestSuite({
                testsuiteid: 6,
            });

            expect(testSuite).to.deep.include({
                details: '',
                name: 'SubTest Suite',
                node_order: '1',
                node_type_id: '2',
                parent_id: '6',
            });
        });

        it('getTestSuiteCustomFieldDesignValue', async () => {
            const customField = await testlink.getTestSuiteCustomFieldDesignValue({
                customfieldname: 'CF_TestSuite',
                testprojectid: 3,
                testsuiteid: 6,
            });

            expect(customField).to.deep.include({
                default_value: '',
                display_order: '1',
                enable_on_design: '1',
                enable_on_execution: '0',
                enable_on_testplan_design: '0',
                label: 'CF TestSuite',
                length_max: '0',
                length_min: '0',
                location: '1',
                name: 'CF_TestSuite',
                node_id: '6',
                possible_values: '',
                required: '0',
                show_on_design: '1',
                show_on_execution: '1',
                show_on_testplan_design: '0',
                type: '0',
                valid_regexp: '',
                value: 'Value for CF TS',
            });
        });

        it('getFirstLevelTestSuitesForTestProject', async () => {
            const testSuite = await testlink.getFirstLevelTestSuitesForTestProject({
                testprojectid: 3,
            });

            expect(testSuite[0]).to.deep.include({
                name: 'Test Suite Minefield',
                node_order: '1',
                node_table: 'testsuites',
                node_type_id: '2',
                parent_id: '3',
            });
        });

        it('getTestSuiteByID', async () => {
            const testSuite = await testlink.getTestSuiteByID({
                testsuiteid: 6,
            });
            
            expect(testSuite).to.deep.include({
                details: '',
                name: 'Test Suite Minefield',
                node_order: '1',
                node_type_id: '2',
                parent_id: '3',
            });
        });
    });
});