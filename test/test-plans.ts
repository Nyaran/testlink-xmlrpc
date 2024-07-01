import {expect} from 'chai';

import {TestLink} from '../src/index.js';
import TL_CONFIG_TEST from './_tests.config.js';

describe('Test Plans', () => {
	let testlink: TestLink;
	before(function() {
		testlink = new TestLink({
			apiKey: TL_CONFIG_TEST.users.admin.apiKey,
			path: TL_CONFIG_TEST.path,
			rpcPath: TL_CONFIG_TEST.rpcPath,
			port: TL_CONFIG_TEST.port
		});
	});

	describe('Retrieve Test Plans info', () => {
		it('getProjectTestPlans', async () => {
			const testPlans = await testlink.getProjectTestPlans({
				testprojectid: 3
			});
			expect(testPlans[0]).to.deep.include({
				name: 'Test Plan Minefield',
				notes: '<p>Test plan to be used on library testing</p>',
				active: '1',
				is_public: '1',
			});
		});

		it('getTestPlanByName', async () => {
			const testPlans = await testlink.getTestPlanByName({
				testprojectname: 'TestableProject',
				testplanname: 'Test Plan Minefield',
			});
			expect(testPlans[0]).to.deep.include({
				name: 'Test Plan Minefield',
				notes: '<p>Test plan to be used on library testing</p>',
				active: '1',
				is_public: '1',
				is_open: '1',
			});
		});

		it('getTotalsForTestPlan', async () => {
			const response = await testlink.getTotalsForTestPlan({
				testplanid: 12
			});
			expect(response).to.deep.include({
				with_tester: [
					{
						b: {
							exec_qty: 0,
							platform_id: 0,
							status: 'b',
						},
						f: {
							exec_qty: 0,
							platform_id: 0,
							status: 'f',
						},
						n: {
							exec_qty: 0,
							platform_id: 0,
							status: 'n',
						},
						p: {
							exec_qty: '1',
							platform_id: '0',
							status: 'p',
						}
					}
				],
				total: [
					{
						platform_id: '0',
						qty: '1',
					}
				],
				platforms: ''
			});
		});

		it('getTestPlanCustomFieldDesignValue', async () => {
			const customField = await testlink.getTestPlanCustomFieldDesignValue({
				customfieldname: 'CF_TestPlan',
				testprojectid: 3,
				testplanid: 12,
			});
			expect(customField).to.deep.include({
				id: '5',
				name: 'CF_TestPlan',
				label: 'CF TestPlan',
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
				value: 'Test Plan CF Value',
				node_id: '12'
			});
		});
	});

	describe('Manage Test Plans', () => {
		it('createTestPlan', async () => {
			const response = await testlink.createTestPlan({
				testplanname: 'New TestPlan',
				prefix: 'EP'
			});

			response.forEach(r => expect(r).to.deep.include({
				operation: 'createTestPlan',
				additionalInfo: '',
				status: true,
				message: 'Success!'
			}));
		});

		it('deleteTestPlan', async () => {
			const response = await testlink.deleteTestPlan({
				testplanid: 15
			});
			response.forEach(r => expect(r).to.deep.include({
				operation: 'deleteTestPlan',
				status: true,
				message: 'Success!'
			}));
		});

		it('addTestCaseToTestPlan', async () => {
			const response = await testlink.addTestCaseToTestPlan({
				testprojectid: 4,
				testplanid: 13,
				platformid: 4,
				testcaseexternalid: 'EP-3',
				version: 1,
			});
			expect(response).to.deep.include({
				operation: 'addTestCaseToTestPlan',
				status: true,
				message: ''
			});
		});

		it('addPlatformToTestPlan', async () => {
			const response = await testlink.addPlatformToTestPlan({
				testplanid: 13,
				platformname: 'Platform to Add'
			});
			expect(response).to.deep.include({
				operation: 'link',
				msg: 'link done',
				linkStatus: false
			});
		});

		it('removePlatformFromTestPlan', async () => {
			const response = await testlink.removePlatformFromTestPlan({
				testplanid: 13,
				platformname: 'Platform to Remove'
			});
			expect(response).to.deep.include({
				operation: 'unlink',
				msg: 'unlink done',
				linkStatus: true
			});
		});
	});
});
