import {expect} from 'chai';

import {TestLink} from '../src/index.js';
import TL_CONFIG_TEST from './_tests.config.js';

describe('Users', () => {
	let testlink: TestLink;
	before(function() {
		testlink = new TestLink({
			apiKey: TL_CONFIG_TEST.users.admin.apiKey,
			path: TL_CONFIG_TEST.path,
			rpcPath: TL_CONFIG_TEST.rpcPath,
			port: TL_CONFIG_TEST.port
		});
	});

	it('getUserByLogin', async () => {
		const userData = TL_CONFIG_TEST.users.Leader;
		const user = await testlink.getUserByLogin({
			user: userData.name,
		});

		user.forEach(u => expect(u).to.deep.include({
			firstName: userData.firstName,
			lastName: userData.lastName,
			emailAddress: userData.emailAddress,
			login: userData.login,
		}));
	});

	it('getUserByID', async () => {
		const userData = TL_CONFIG_TEST.users.Leader;

		const user = await testlink.getUserByID({
			userid: userData.id,
		});

		user.forEach(u => expect(u).to.deep.include({
			firstName: userData.firstName,
			lastName: userData.lastName,
			emailAddress: userData.emailAddress,
			login: userData.login,
		}));
	});

	it('doesUserExist', async () => {
		expect(await testlink.doesUserExist({
			user: TL_CONFIG_TEST.users.Leader.name,
		})).to.be.true;
	});

	it('createUser', async () => {
		expect(await testlink.createUser({
			login: 'minefield',
			firstname: 'Minefield',
			lastname: 'Foo',
			email: 'minefield@testlink-xmlrpc.com',
			password: 'Min3f¡e|d',
		})).to.be.equal(8);
	});

	it('setUserRoleOnProject', async () => {
		expect(await testlink.setUserRoleOnProject({
			userid: TL_CONFIG_TEST.users.EditableUser.id,
			testprojectid: 4,
			rolename: 'Tester',
		})).to.be.true;
	});
});
