import {expect, use} from 'chai';
import chaiAsPromised from 'chai-as-promised';
import * as xmlrpc from 'xmlrpc';

import {TestLink} from '../src';

use(chaiAsPromised);

describe('RPC', () => {
    let testlink: TestLink;
    let rpcServer: xmlrpc.Server;
    before(function () {
        rpcServer = xmlrpc.createServer({host: 'localhost', port: 9090});
        rpcServer.on('tl.default_error', function (method, params, callback) {
            callback('XMLRPC Server Error', null);
        });
        rpcServer.on('tl.zero_status', function (method, params, callback) {
            callback(null, {status_ok: 0, message: 'Zero status test'});
        });
        rpcServer.on('tl.error_code', function (method, params, callback) {
            callback(null, [{code: 1234}]);
        });
        rpcServer.on('tl.hello', function (method, params, callback) {
            callback(null, {message: 'Hey hey!'});
        });
    });
    before(function () {
        testlink = new TestLink({port: 9090, rpcPath: '/'});
    });

    it('xmlrpc default error', async () => {
        expect(testlink._performRequest('default_error', {})).to.eventually.be.rejectedWith(Error, 'XML-RPC fault');
    });

    it('xmlrpc zero status', async () => {
        expect(testlink._performRequest('zero_status', {})).to.eventually.be.rejectedWith(Error, 'Zero status test');
    });

    it('xmlrpc error code', async () => {
        expect(testlink._performRequest('error_code', {})).to.eventually.be.rejectedWith(Error, 'Zero status test');
    });

    it('xmlrpc client not initiated', async () => {
        const testlink2 = new TestLink({port: 9090, rpcPath: '/', autoConnect: false});
        expect(testlink2._performRequest('hello', {})).to.eventually.be.rejectedWith(Error, 'Zero status test');
    });

    after(function () {
        // @ts-ignore
        // eslint-disable-next-line @typescript-eslint/no-empty-function
        rpcServer.close(() => {
        });
    });
});
