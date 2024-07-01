import {expect, use} from 'chai';
import chaiAsPromised from 'chai-as-promised';

import {TestLink} from '../src/index.js';
import TL_CONFIG_TEST from './_tests.config.js';

use(chaiAsPromised);

describe('Miscellaneous', () => {
	let testlink: TestLink;

	before(function() {
		testlink = new TestLink({
			path: TL_CONFIG_TEST.path,
			rpcPath: TL_CONFIG_TEST.rpcPath,
			port: TL_CONFIG_TEST.port,
			apiKey: TL_CONFIG_TEST.users.admin.apiKey,
		});
	});

	it('ping', async () => {
		expect(await testlink.ping()).to.be.equal('Hello!');
	});

	it('sayHello', async () => {
		expect(await testlink.sayHello()).to.be.equal('Hello!');
	});

	it('repeat', async () => {
		const message = 'Hello from testlink-xmlrpc';
		expect(await testlink.repeat({str: message})).to.be.equal(`You said: ${message}`);
	});

	it('testLinkVersion', async () => {
		expect(await testlink.testLinkVersion()).to.match(/^\d+\.\d+\.\d+$/);
	});

	it('about', async () => {
		expect(await testlink.about()).to.match(/^ Testlink API Version: \d+\.\d+/);
	});

	it('checkDevKey - default', async () => {
		expect(await testlink.checkDevKey()).to.be.true;
	});

	it('checkDevKey - specify', async () => {
		expect(await testlink.checkDevKey({devKey: TL_CONFIG_TEST.users.Leader.apiKey})).to.be.true;
	});

	it('checkDevKey - invalid', async () => {
		await expect(testlink.checkDevKey({devKey: 'invalid key'})).to.eventually.be.rejectedWith(Error, /invalid developer key$/);
	});

	it('setTestMode', async () => {
		expect(await testlink.setTestMode({testmode: true})).to.be.true;
		expect(await testlink.setTestMode({testmode: false})).to.be.true;
	});

	it('getFullPath', async () => {
		const response = await testlink.getFullPath({
			nodeid: 8,
		});
		expect(response).to.have.property('8').that.deep.equals([
			'TestableProject',
			'Test Suite Minefield',
		]);
	});
});
