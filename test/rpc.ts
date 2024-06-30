/* eslint promise/prefer-await-to-callbacks: "off" */
import {expect, use} from 'chai';
import chaiAsPromised from 'chai-as-promised';
import xmlrpc from 'xmlrpc';

import {TestLink} from '../src/index.js';

use(chaiAsPromised);

describe('RPC', () => {
	let testlink: TestLink;
	let rpcServer: xmlrpc.Server;
	before(function() {
		rpcServer = xmlrpc.createServer({host: 'localhost', port: 9090});

		rpcServer.on('tl.default_error', function(method, params, callback) {
			callback('XMLRPC Server Error', null);
		});
		rpcServer.on('tl.zero_status', function(method, params, callback) {
			callback(null, {status_ok: 0, message: 'Zero status test'});
		});
		rpcServer.on('tl.error_code', function(method, params, callback) {
			callback(null, [{code: 1234, message: 'Error code test'}]);
		});
		rpcServer.on('tl.hello', function(method, params, callback) {
			callback(null, {message: 'Hey hey!'});
		});
	});

	before(function() {
		testlink = new TestLink({port: 9090, rpcPath: '/'});
	});

	it('xmlrpc default error', async () => {
		await expect(testlink._performRequest('default_error', {})).to.eventually.be.rejectedWith(Error, 'XML-RPC fault');
	});

	it('xmlrpc zero status', async () => {
		await expect(testlink._performRequest('zero_status', {})).to.eventually.be.rejectedWith(Error, 'Zero status test');
	});

	it('xmlrpc error code', async () => {
		await expect(testlink._performRequest('error_code', {})).to.eventually.be.rejectedWith(Error, '[1234] Error code test');
	});

	it('xmlrpc client not initiated', async () => {
		const testlink2 = new TestLink({port: 9090, rpcPath: '/', autoConnect: false});
		await expect(testlink2._performRequest('hello', {})).to.eventually.be.rejectedWith(Error, 'RPC Client not initiated');
	});

	after(function() {
		// Overwrite type bc "close" is missing on @types/xmlrpc
		(rpcServer as xmlrpc.Server & { close: (callback: () => void ) => void }).close(() => {
			// empty
		});
	});
});
