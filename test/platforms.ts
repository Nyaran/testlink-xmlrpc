import {expect} from 'chai';

import {TestLink} from '../src/index.js';
import TL_CONFIG_TEST from './_tests.config.js';

describe('Platforms', () => {
	let testlink: TestLink;
	before(function() {
		testlink = new TestLink({
			apiKey: TL_CONFIG_TEST.users.admin.apiKey,
			path: TL_CONFIG_TEST.path,
			rpcPath: TL_CONFIG_TEST.rpcPath,
			port: TL_CONFIG_TEST.port
		});
	});

	describe('Manage Platforms', () => {
		// Doesn't work currently on TestLink as there is a bug on the current API (Tested on 1.9.20)
		it('createPlatform', async () => {
			const response = await testlink.createPlatform({
				testprojectname: 'EditableProject',
				platformname: 'New Platform',
				notes: 'Lorem Ipsum dolor sit amet',
				platformonexecution: true,
			});
			expect(response).to.deep.include({
				status: 1,
			});
		});
	});

	describe('Retrieve Platforms info', () => {
		it('getProjectPlatforms', async () => {
			const platform = await testlink.getProjectPlatforms({
				testprojectid: 3
			});
			expect(platform).to.deep.include({
				'Platform minefield': {
					id: '1',
					name: 'Platform minefield',
					notes: '<p>Platform to be used on tests</p>',
					testproject_id: '3',
					enable_on_design: '1',
					enable_on_execution: '1',
					is_open: '1',
				}
			});
		});

		it('getTestPlanPlatforms', async () => {
			const platform = await testlink.getTestPlanPlatforms({
				testplanid: 12
			});
			expect(platform).to.deep.include({
				id: '1',
				name: 'Platform minefield',
				notes: '<p>Platform to be used on tests</p>',
				enable_on_design: '1',
				enable_on_execution: '1',
				is_open: '1',
			});
		});
	});
});
