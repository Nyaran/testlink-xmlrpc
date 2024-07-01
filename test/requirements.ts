import {expect} from 'chai';

import {TestLink} from '../src/index.js';
import TL_CONFIG_TEST from './_tests.config.js';

describe('Requirements', () => {
	let testlink: TestLink;
	before(function() {
		testlink = new TestLink({
			apiKey: TL_CONFIG_TEST.users.admin.apiKey,
			path: TL_CONFIG_TEST.path,
			rpcPath: TL_CONFIG_TEST.rpcPath,
			port: TL_CONFIG_TEST.port
		});
	});

	it('getReqSpecCustomFieldDesignValue', async () => {
		const response = await testlink.getReqSpecCustomFieldDesignValue({
			customfieldname: 'CF_RequirementSD',
			testprojectid: 4,
			reqspecid: 40
		});
		expect(response).to.deep.include({
			default_value: '',
			display_order: '1',
			enable_on_design: '1',
			enable_on_execution: '0',
			enable_on_testplan_design: '0',
			id: '3',
			label: 'CF RequirementSD',
			length_max: '0',
			length_min: '0',
			location: '1',
			name: 'CF_RequirementSD',
			node_id: '',
			possible_values: '',
			required: '0',
			show_on_design: '1',
			show_on_execution: '0',
			show_on_testplan_design: '0',
			type: '0',
			valid_regexp: '',
			value: '',
		});
	});

	it('getRequirementCustomFieldDesignValue', async () => {
		const response = await testlink.getRequirementCustomFieldDesignValue({
			customfieldname: 'CF_Requirement',
			testprojectid: 4,
			requirementid: 'ReqUC1'
		});
		expect(response).to.deep.include({
			default_value: '',
			display_order: '1',
			enable_on_design: '1',
			enable_on_execution: '0',
			enable_on_testplan_design: '0',
			id: '2',
			label: 'CF Requirement',
			length_max: '0',
			length_min: '0',
			location: '1',
			name: 'CF_Requirement',
			node_id: '',
			possible_values: '',
			required: '0',
			show_on_design: '1',
			show_on_execution: '0',
			show_on_testplan_design: '0',
			type: '0',
			valid_regexp: '',
			value: '',
		});
	});

	it('getRequirements', async () => {
		const response = await testlink.getRequirements({
			testprojectid: 4,
		});
		expect(response[0]).to.deep.include({
			id: '43',
			req_doc_id: 'ReqUC1',
		});
	});

	it('getRequirement', async () => {
		const response = await testlink.getRequirement({
			testprojectid: 4,
			requirementdocid: 'ReqUC1',
		});
		expect(response[0]).to.deep.include({
			id: '43',
			srs_id: '40',
			req_doc_id: 'ReqUC1',
			scope: '<pre>\r\nTest Case Requirement</pre>',
			status: 'D',
			type: '3',
			active: '1',
			is_open: '1',
			reqver_is_open: '1',
			author_id: '1',
			version: '1',
			version_id: '44',
			expected_coverage: '1',
			creation_ts: '2021-04-24 21:19:20',
			modifier_id: '',
			modification_ts: '2021-04-24 23:19:20',
			revision: '1',
			revision_id: '-1',
			title: 'Requirement 1',
			testproject_id: '4',
			req_spec_title: 'Editable Requirement Section',
			req_spec_doc_id: 'EditReqS',
			node_order: '1',
			author: 'admin',
			modifier: '',
		});
	});

	it('getReqCoverage', async () => {
		const response = await testlink.getReqCoverage({
			testprojectid: 4,
			requirementversionid: 44
		});
		expect(response[0]).to.deep.include({
			id: '10',
			tcase_id: '10',
			name: 'Editable TC1',
			tcase_name: 'Editable TC1',
			tc_external_id: '1',
			version: '1',
			tcversion_id: '11',
			can_be_deleted: '1',
			is_obsolete: '0',
		});
	});
});
