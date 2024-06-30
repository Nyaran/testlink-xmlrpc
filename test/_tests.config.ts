export default {
	host: 'localhost',
	port: 80,
	path: '/testlink',
	rpcPath: 'lib/api/xmlrpc/v1/xmlrpc.php',
	users: {
		admin: {
			id: '1',
			name: 'admin',
			apiKey: 'a4795ab4fe140089c65e82985d20f663',
		},
		Leader: {
			id: '2',
			name: 'Leader',
			apiKey: '8623eb015b5d5f90291a45ce83274cdc',
			firstName: 'Leader',
			lastName: 'Testlink',
			emailAddress: 'leader@testlink-xmlrpc.com',
			login: 'Leader',
		},
		TestDesigner: {
			id: '3',
			name: 'TestDesigner',
		},
		SeniorTester: {
			id: '4',
			name: 'SeniorTester',
		},
		Tester: {
			id: '5',
			name: 'Tester',
		},
		Guest: {
			id: '6',
			name: 'Guest',
		},
		EditableUser: {
			id: '7',
			name: 'EditableUser',
		},
	}
};
