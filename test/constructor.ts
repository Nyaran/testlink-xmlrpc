import {expect} from 'chai';

import {TestLink} from '../src/index.js';

describe('RPC', () => {
	it('default args', () => {
		const testlink = new TestLink();

		expect(testlink).to.have.property('secure').that.is.equals(false);
		expect(testlink).to.have.property('host').that.is.equals('localhost');
		expect(testlink).to.have.property('port').that.is.equals(80);
		expect(testlink).to.have.property('rpcPath').that.is.equals('/lib/api/xmlrpc/v1/xmlrpc.php');
		expect(testlink).to.have.property('apiKey').that.is.undefined;
		expect(testlink).to.have.property('rpcClient').that.is.not.undefined;
	});

	it('default port secure', () => {
		const testlink = new TestLink({secure: true});

		expect(testlink).to.have.property('secure').that.is.equals(true);
		expect(testlink).to.have.property('port').that.is.equals(443);
	});

	it('default port no secure', () => {
		const testlink = new TestLink({secure: false});

		expect(testlink).to.have.property('secure').that.is.equals(false);
		expect(testlink).to.have.property('port').that.is.equals(80);
	});

	it('no default args', () => {
		const testlink = new TestLink({
			secure: true,
			host: 'custom.host.localhost',
			port: 8443,
			path: '/apps/testlink',
			rpcPath: 'api/custom/path/xmlrpc.php',
			apiKey: '123456789',
			autoConnect: false,
		});

		expect(testlink).to.have.property('secure').that.is.equals(true);
		expect(testlink).to.have.property('host').that.is.equals('custom.host.localhost');
		expect(testlink).to.have.property('port').that.is.equals(8443);
		expect(testlink).to.have.property('rpcPath').that.is.equals('/apps/testlink/api/custom/path/xmlrpc.php');
		expect(testlink).to.have.property('apiKey').that.is.equals('123456789');
		expect(testlink).to.have.property('rpcClient').that.is.undefined;
	});
});
