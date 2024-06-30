import {expect} from 'chai';
import fs from 'fs';
import {fileURLToPath} from 'node:url';
import path from 'path';

import {TestLink} from '../src/index.js';
import TL_CONFIG_TEST from './_tests.config.js';

describe('Attachments', () => {
	const commonAttachmentBase64 = fs.readFileSync(path.join(path.dirname(fileURLToPath(import.meta.url)), 'resources/attachment.png'), {encoding: 'base64'});
	let testlink: TestLink;

	before(function() {
		testlink = new TestLink({
			apiKey: TL_CONFIG_TEST.users.admin.apiKey,
			path: TL_CONFIG_TEST.path,
			rpcPath: TL_CONFIG_TEST.rpcPath,
			port: TL_CONFIG_TEST.port
		});
	});

	describe('Upload attachments', () => {
		it('uploadExecutionAttachment', async () => {
			const response = await testlink.uploadExecutionAttachment({
				executionid: 2,
				filename: 'attach_execution.png',
				filetype: 'image/png',
				content: commonAttachmentBase64,
			});
			expect(response).to.deep.include({
				fk_id: 2,
				fk_table: 'executions',
				title: '',
				description: '',
				file_name: 'attach_execution.png',
				file_size: 13618,
				file_type: 'image/png'
			});
		});

		it('uploadRequirementSpecificationAttachment', async () => {
			const response = await testlink.uploadRequirementSpecificationAttachment({
				reqspecid: 40,
				filename: 'attach_reqSp.png',
				filetype: 'image/png',
				content: commonAttachmentBase64,
			});
			expect(response).to.deep.include({
				fk_id: 40,
				fk_table: 'req_specs',
				title: '',
				description: '',
				file_name: 'attach_reqSp.png',
				file_size: 13618,
				file_type: 'image/png'
			});
		});

		it('uploadRequirementAttachment', async () => {
			const response = await testlink.uploadRequirementAttachment({
				requirementid: 43,
				filename: 'attach_req.png',
				filetype: 'image/png',
				content: commonAttachmentBase64,
			});
			expect(response).to.deep.include({
				fk_id: 43,
				fk_table: 'requirements',
				title: '',
				description: '',
				file_name: 'attach_req.png',
				file_size: 13618,
				file_type: 'image/png'
			});
		});

		it('uploadTestProjectAttachment', async () => {
			const response = await testlink.uploadTestProjectAttachment({
				testprojectid: 4,
				filename: 'attach_project.png',
				filetype: 'image/png',
				content: commonAttachmentBase64,
			});
			expect(response).to.deep.include({
				fk_id: 4,
				fk_table: 'nodes_hierarchy',
				title: '',
				description: '',
				file_name: 'attach_project.png',
				file_size: 13618,
				file_type: 'image/png'
			});
		});

		it('uploadTestSuiteAttachment', async () => {
			const response = await testlink.uploadTestSuiteAttachment({
				testsuiteid: 5,
				filename: 'attach_ts.png',
				filetype: 'image/png',
				content: commonAttachmentBase64,
			});
			expect(response).to.deep.include({
				fk_id: 5,
				fk_table: 'nodes_hierarchy',
				title: '',
				description: '',
				file_name: 'attach_ts.png',
				file_size: 13618,
				file_type: 'image/png'
			});
		});

		it('uploadTestCaseAttachment', async () => {
			const response = await testlink.uploadTestCaseAttachment({
				testcaseid: 10, // EP-1
				version: 1,
				filename: 'attach_tc.png',
				filetype: 'image/png',
				content: commonAttachmentBase64,
			});
			expect(response).to.deep.include({
				fk_id: '11',
				fk_table: 'tcversions',
				title: '',
				description: '',
				file_name: 'attach_tc.png',
				file_size: 13618,
				file_type: 'image/png'
			});
		});

		it('uploadAttachment - To Test Case', async () => {
			const response = await testlink.uploadAttachment({
				fkid: 11,
				fktable: 'tcversions',
				title: 'hello',
				description: 'world',
				filename: 'attach_tc_base.png',
				filetype: 'image/png',
				content: commonAttachmentBase64,
			});
			expect(response).to.deep.include({
				fk_id: 11,
				fk_table: 'tcversions',
				title: 'hello',
				description: 'world',
				file_name: 'attach_tc_base.png',
				file_size: 13618,
				file_type: 'image/png'
			});
		});
	});

	describe('Get attachment', () => {
		it('getTestSuiteAttachments', async () => {
			const attachments = await testlink.getTestSuiteAttachments({
				testsuiteid: 6
			});

			expect(attachments).to.have.property('1').that.deep.include({
				content: commonAttachmentBase64,
				file_type: 'image/png',
				id: '1',
				name: 'attachment.png',
				title: '',
			});
		});

		it('getTestCaseAttachments', async () => {
			const attachments = await testlink.getTestCaseAttachments({
				testcaseexternalid: 'EP-1',
			});

			expect(attachments).to.have.property('2').that.deep.include({
				content: commonAttachmentBase64,
				file_type: 'image/png',
				id: '2',
				name: 'attachment.png',
				title: '',
			});
		});
	});
});
