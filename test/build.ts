import {expect} from 'chai';

import {TestLink} from '../src';
import TL_CONFIG_TEST from './_tests.config';

describe('Build', () => {
    let testlink: TestLink;
    before(function () {
        testlink = new TestLink({
            apiKey: TL_CONFIG_TEST.users.admin.apiKey,
            path: TL_CONFIG_TEST.path,
            rpcPath: TL_CONFIG_TEST.rpcPath,
            port: TL_CONFIG_TEST.port
        });
    });

    describe('Retrieve Builds info', () => {
        it('getExecCountersByBuild', async () => {
            const build = await testlink.getExecCountersByBuild({testplanid: 12});

            expect(build.raw.active_builds['3']).to.deep.includes({
                active: '1',
                closed_on_date: '',
                id: '3',
                is_open: '1',
                name: 'Build Minefield',
                notes: '<p>Build to be used on tests</p>\r\n',
                release_date: '',
                testplan_id: '12',
            });
        });

        it('getBuildsForTestPlan', async () => {
            const response = await testlink.getBuildsForTestPlan({
                testplanid: 12,
            });
            expect(response[0]).to.deep.include({
                active: '1',
                closed_on_date: '',
                id: '3',
                is_open: '1',
                name: 'Build Minefield',
                notes: '<p>Build to be used on tests</p>\r\n',
                release_date: '',
                testplan_id: '12',
            });
        });

        it('getLatestBuildForTestPlan', async () => {
            const response = await testlink.getLatestBuildForTestPlan({
                testplanid: 12,
            });
            expect(response).to.deep.include({
                active: '1',
                closed_on_date: '',
                id: '3',
                is_open: '1',
                name: 'Build Minefield',
                notes: '<p>Build to be used on tests</p>\r\n',
                release_date: '',
                testplan_id: '12',
            });
        });
    });

    describe('Manage Builds', () => {
        it('createBuild', async () => {
            const build = await testlink.createBuild({
                testplanid: 13,
                buildname: 'New Build',
                buildnotes: 'Lorem Ipsum',
                active: true,
                open: true,
                releasedate: '2050/04/01',
            });

            build.forEach(b => expect(b).to.deep.include({
                status: true,
                operation: 'createBuild',
                message: 'Success!',
            }));
        });

        it('closeBuild', async () => {
            const build = await testlink.closeBuild({
                buildid: 2,
            });

            build.forEach(b => expect(b).to.deep.include({
                status: true,
                operation: 'closeBuild',
                message: 'Success!',
            }));
        });

        it('updateBuildCustomFieldsValues', async () => {
            const response = await testlink.updateBuildCustomFieldsValues({
                buildid: 1,
                testprojectid: 4,
                testplanid: 13,
                customfields: {
                    'CF_Build': 'Updated CF',
                },
            });
            expect(response[0]).to.deep.include({
                status: 'ok',
                msg: 'Custom Field:CF_Build processed ',
            });
        });
    });
});
