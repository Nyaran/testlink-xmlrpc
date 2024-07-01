import {expect} from 'chai';

import {TestLink} from '../src/index.js';
import TL_CONFIG_TEST from './_tests.config.js';

describe('Projects', () => {
	let testlink: TestLink;
	before(function() {
		testlink = new TestLink({
			apiKey: TL_CONFIG_TEST.users.admin.apiKey,
			path: TL_CONFIG_TEST.path,
			rpcPath: TL_CONFIG_TEST.rpcPath,
			port: TL_CONFIG_TEST.port
		});
	});

	describe('Retrieve project info', () => {
		it('getProjects', async () => {
			const projects = await testlink.getProjects();
			expect(projects.length).to.be.greaterThan(0);
		});

		it('getProjectKeywords', async () => {
			expect(await testlink.getProjectKeywords({testprojectid: '3'})).to.deep.equal({1: 'Test Keyword'});
			expect(await testlink.getProjectKeywords({testprojectid: 3})).to.deep.equal({1: 'Test Keyword'});
		});

		it('getTestProjectByName', async () => {
			expect(await testlink.getTestProjectByName({
				testprojectname: 'InitialProject'
			})).to.deep.includes({
				id: '1',
				name: 'InitialProject',
				prefix: 'IP',
			});
		});
	});

	describe('Manage projects', () => {
		// Needs: https://github.com/TestLinkOpenSourceTRMS/testlink-code/pull/348
		it('createTestProject - Success', async () => {
			const project = await testlink.createTestProject({
				testprojectname: 'Minefield',
				testcaseprefix: 'MF',
			});

			project.forEach(p => expect(p).to.deep.include({
				additionalInfo: '',
				message: 'Success!',
				operation: 'createTestProject',
				status: true,
			}));
		});

		it('createTestProject - Success - All data', async () => {
			const newProject = await testlink.createTestProject({
				testprojectname: 'MinefieldFull',
				testcaseprefix: 'MFF',
				notes: 'This is a minefield, be careful!',
				options: {
					requirementsEnabled: true,
					testPriorityEnabled: false,
					automationEnabled: false,
					inventoryEnabled: true
				},
				active: false,
				public: false,
				itsenabled: true,
				itsname: 'LocalBugzilla',
			});

			expect(await testlink.getTestProjectByName({
				testprojectname: 'MinefieldFull',
			})).to.deep.includes({
				id: newProject[0].id.toString(),
				name: 'MinefieldFull',
				prefix: 'MFF',
				notes: 'This is a minefield, be careful!',
				opt: {
					automationEnabled: 0,
					inventoryEnabled: 1,
					requirementsEnabled: 1,
					testPriorityEnabled: 0,
				},
				active: '0',
				is_public: '0',
				issue_tracker_enabled: '1',
			});
		});

		it('deleteTestProject - Success', async () => {
			expect(await testlink.deleteTestProject({
				prefix: 'RP'
			})).to.be.deep.equal([{'status': true}]);
		});
	});
});
