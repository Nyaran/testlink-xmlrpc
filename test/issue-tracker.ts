import {expect} from 'chai';

import {TestLink} from '../src/index.js';
import TL_CONFIG_TEST from './_tests.config.js';

describe('Issue tracker', () => {
	let testlink: TestLink;
	before(function() {
		testlink = new TestLink({
			apiKey: TL_CONFIG_TEST.users.admin.apiKey,
			path: TL_CONFIG_TEST.path,
			rpcPath: TL_CONFIG_TEST.rpcPath,
			port: TL_CONFIG_TEST.port
		});
	});

	it('getIssueTrackerSystem', async () => {
		const issueTracker = await testlink.getIssueTrackerSystem({
			itsname: 'LocalBugzilla'
		});

		expect(issueTracker).to.deep.include({
			id: '1',
			name: 'LocalBugzilla',
			type: '1',
			cfg: '',
			implementation: 'bugzillaxmlrpcInterface'
		});
	});
});
