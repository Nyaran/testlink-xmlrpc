import {expect} from 'chai';

import {TestLink} from '../src';
import TL_CONFIG_TEST from './_tests.config';

describe('Requirements', () => {
    let testlink: TestLink;
    before(function () {
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

    it('getReqCoverage', async () => {
        const response = await testlink.getReqCoverage({
            testprojectid: 4,
            requirementdocid: 'ReqUC1'
        });
        expect(response[0]).to.deep.include({
            id: '10',
            login: 'admin',
            name: 'Editable TC1',
            tc_external_id: '1',
        });
    });
});