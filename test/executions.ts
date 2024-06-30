import {expect} from 'chai';

import {TestLink} from '../src/index.js';
import TL_CONFIG_TEST from './_tests.config.js';

describe('Executions', () => {
	let testlink: TestLink;
	before(function() {
		testlink = new TestLink({
			apiKey: TL_CONFIG_TEST.users.admin.apiKey,
			path: TL_CONFIG_TEST.path,
			rpcPath: TL_CONFIG_TEST.rpcPath,
			port: TL_CONFIG_TEST.port
		});
	});

	it('getLastExecutionResult', async () => {
		const response = await testlink.getLastExecutionResult({
			testplanid: '12',
			testcaseexternalid: 'TP-1',
		});
		expect(response[0]).to.deep.include({
			build_id: '3',
			execution_duration: '61.00',
			execution_type: '1',
			id: '1',
			notes: '',
			platform_id: '0',
			status: 'p',
			tcversion_id: '9',
			tcversion_number: '1',
			tester_id: '1',
			testplan_id: '12',
		});
	});

	it('deleteExecution', async () => {
		const response = await testlink.deleteExecution({
			executionid: 3
		});
		expect(response[0]).to.deep.equal({
			status: true,
			id: 3,
			message: 'Success!',
			operation: 'deleteExecution'
		});
	});

	it('getExecutionSet', async () => {
		const response = await testlink.getExecutionSet({
			testplanid: 12,
			testcaseexternalid: 'TP-1',
		});

		expect(response).to.have.property('1').that.deep.include({
			build_id: '3',
			execution_duration: '61.00',
			execution_type: '1',
			id: '1',
			notes: '',
			platform_id: '0',
			status: 'p',
			tcversion_id: '9',
			tcversion_number: '1',
			tester_id: '1',
			testplan_id: '12',
		});
	});

	it('getAllExecutionsResults', async () => {
		const response = await testlink.getAllExecutionsResults({
			testplanid: 12,
			testcaseexternalid: 'TP-1',
		});
		expect(response).to.have.property('1').that.deep.include({
			build_id: '3',
			execution_duration: '61.00',
			execution_type: '1',
			id: '1',
			notes: '',
			platform_id: '0',
			status: 'p',
			tcversion_id: '9',
			tcversion_number: '1',
			tester_id: '1',
			testplan_id: '12',
		});
	});
});
