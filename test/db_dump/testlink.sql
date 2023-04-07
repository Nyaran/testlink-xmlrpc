-- Adminer 4.8.1 MySQL 10.5.18-MariaDB dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

TRUNCATE `attachments`;
INSERT INTO `attachments` (`id`, `fk_id`, `fk_table`, `title`, `description`, `file_name`, `file_path`, `file_size`, `file_type`, `date_added`, `content`, `compression_type`) VALUES
(1,	6,	'nodes_hierarchy',	'',	'',	'attachment.png',	'nodes_hierarchy/6/2c46dff9581a972995ca0f7194cea408.png',	13618,	'image/png',	'2021-04-18 20:53:06',	NULL,	1),
(2,	11,	'tcversions',	'',	'',	'attachment.png',	'tcversions/11/f3f53e0f28edc4f56d0806c2f2a372c6.png',	13618,	'image/png',	'2021-04-18 21:13:36',	NULL,	1);

TRUNCATE `baseline_l1l2_context`;

TRUNCATE `baseline_l1l2_details`;

TRUNCATE `builds`;
INSERT INTO `builds` (`id`, `testplan_id`, `name`, `notes`, `active`, `is_open`, `author_id`, `creation_ts`, `release_date`, `closed_on_date`, `commit_id`, `tag`, `branch`, `release_candidate`) VALUES
(1,	13,	'Editable Build',	'<p>Build to be edited on tests</p>\r\n',	1,	1,	NULL,	'2021-04-17 23:20:53',	NULL,	NULL,	'',	'',	'',	''),
(2,	13,	'Closeable Build',	'<p>Build to be closed on tests</p>\r\n',	1,	1,	NULL,	'2021-04-17 23:21:13',	NULL,	NULL,	'',	'',	'',	''),
(3,	12,	'Build Minefield',	'<p>Build to be used on tests</p>\r\n',	1,	1,	NULL,	'2021-04-17 23:23:42',	NULL,	NULL,	'',	'',	'',	''),
(4,	39,	'Reportable Build',	'',	1,	1,	NULL,	'2021-04-24 18:17:01',	'2021-04-01',	NULL,	'',	'',	'',	'');

TRUNCATE `cfield_build_design_values`;
INSERT INTO `cfield_build_design_values` (`field_id`, `node_id`, `value`) VALUES
(1,	1,	'CF Build edit Value'),
(1,	3,	'CF Build Value');

TRUNCATE `cfield_design_values`;
INSERT INTO `cfield_design_values` (`field_id`, `node_id`, `value`) VALUES
(2,	44,	'CF Requirement edit Value'),
(3,	41,	'CF Build edit Value'),
(3,	42,	'CF Build edit Value'),
(4,	9,	'Value for CF TC'),
(5,	12,	'Test Plan CF Value'),
(5,	13,	'Editable CF TP'),
(6,	5,	'To edit CF TS'),
(6,	6,	'Value for CF TS');

TRUNCATE `cfield_execution_values`;
INSERT INTO `cfield_execution_values` (`field_id`, `execution_id`, `testplan_id`, `tcversion_id`, `value`) VALUES
(7,	1,	12,	9,	'CF Value execution');

TRUNCATE `cfield_node_types`;
INSERT INTO `cfield_node_types` (`field_id`, `node_type_id`) VALUES
(1,	12),
(2,	7),
(3,	6),
(4,	3),
(5,	5),
(6,	2),
(7,	3),
(8,	3);

TRUNCATE `cfield_testplan_design_values`;

TRUNCATE `cfield_testprojects`;
INSERT INTO `cfield_testprojects` (`field_id`, `testproject_id`, `display_order`, `location`, `active`, `required`, `required_on_design`, `required_on_execution`, `monitorable`) VALUES
(1,	3,	1,	1,	1,	0,	0,	0,	0),
(1,	4,	1,	1,	1,	0,	0,	0,	0),
(2,	3,	1,	1,	1,	0,	0,	0,	0),
(2,	4,	1,	1,	1,	0,	0,	0,	0),
(3,	3,	1,	1,	1,	0,	0,	0,	0),
(3,	4,	1,	1,	1,	0,	0,	0,	0),
(4,	3,	1,	1,	1,	0,	0,	0,	0),
(4,	4,	1,	1,	1,	0,	0,	0,	0),
(5,	3,	1,	1,	1,	0,	0,	0,	0),
(5,	4,	1,	1,	1,	0,	0,	0,	0),
(6,	3,	1,	1,	1,	0,	0,	0,	0),
(6,	4,	1,	1,	1,	0,	0,	0,	0),
(7,	3,	1,	1,	1,	0,	0,	0,	0),
(8,	3,	1,	1,	1,	0,	0,	0,	0);

TRUNCATE `codetrackers`;
INSERT INTO `codetrackers` (`id`, `name`, `type`, `cfg`) VALUES
(1,	'LocalStash',	1,	'');

TRUNCATE `custom_fields`;
INSERT INTO `custom_fields` (`id`, `name`, `label`, `type`, `possible_values`, `default_value`, `valid_regexp`, `length_min`, `length_max`, `show_on_design`, `enable_on_design`, `show_on_execution`, `enable_on_execution`, `show_on_testplan_design`, `enable_on_testplan_design`) VALUES
(1,	'CF_Build',	'CF Build',	0,	'',	'',	'',	0,	0,	1,	1,	1,	0,	0,	0),
(2,	'CF_Requirement',	'CF Requirement',	0,	'',	'',	'',	0,	0,	1,	1,	0,	0,	0,	0),
(3,	'CF_RequirementSD',	'CF RequirementSD',	0,	'',	'',	'',	0,	0,	1,	1,	0,	0,	0,	0),
(4,	'CF_TestCase_TSD',	'CF TestCase Test Spec Design',	0,	'',	'',	'',	0,	0,	1,	1,	1,	0,	0,	0),
(5,	'CF_TestPlan',	'CF TestPlan',	0,	'',	'',	'',	0,	0,	1,	1,	1,	0,	0,	0),
(6,	'CF_TestSuite',	'CF TestSuite',	0,	'',	'',	'',	0,	0,	1,	1,	1,	0,	0,	0),
(7,	'CF_TestCase_TE',	'CF TestCase Test Execution',	0,	'',	'',	'',	0,	0,	0,	0,	1,	1,	0,	0),
(8,	'CF_TestCase_TPD',	'CF TestCase Test Plan Design',	0,	'',	'',	'',	0,	0,	0,	0,	1,	0,	1,	1);

TRUNCATE `executions`;
INSERT INTO `executions` (`id`, `build_id`, `tester_id`, `execution_ts`, `status`, `testplan_id`, `tcversion_id`, `tcversion_number`, `platform_id`, `execution_type`, `execution_duration`, `notes`) VALUES
(1,	3,	1,	'2021-04-18 21:15:16',	'p',	12,	9,	1,	0,	1,	61.00,	''),
(2,	2,	1,	'2021-04-18 21:51:12',	'p',	13,	21,	1,	4,	1,	78.00,	'');

TRUNCATE `execution_bugs`;

TRUNCATE `execution_tcsteps`;
INSERT INTO `execution_tcsteps` (`id`, `execution_id`, `tcstep_id`, `notes`, `status`) VALUES
(1,	1,	25,	'',	'p'),
(2,	1,	26,	'',	'p'),
(3,	2,	22,	'',	'p'),
(4,	2,	23,	'',	'p'),
(5,	2,	24,	'',	'p');

TRUNCATE `execution_tcsteps_wip`;

TRUNCATE `inventory`;

TRUNCATE `issuetrackers`;
INSERT INTO `issuetrackers` (`id`, `name`, `type`, `cfg`) VALUES
(1,	'LocalBugzilla',	1,	'');

TRUNCATE `keywords`;
INSERT INTO `keywords` (`id`, `keyword`, `testproject_id`, `notes`) VALUES
(1,	'Test Keyword',	3,	'Keyword to be used on library tests'),
(2,	'Assignable keyword',	4,	'Keyword to be assigned by test execution'),
(3,	'Assigned keyword',	4,	'Default assigned keyword');

TRUNCATE `milestones`;

TRUNCATE `nodes_hierarchy`;
INSERT INTO `nodes_hierarchy` (`id`, `name`, `parent_id`, `node_type_id`, `node_order`) VALUES
(1,	'InitialProject',	NULL,	1,	1),
(2,	'RemoveProject',	NULL,	1,	1),
(3,	'TestableProject',	NULL,	1,	1),
(4,	'EditableProject',	NULL,	1,	1),
(5,	'Editable TS',	4,	2,	1),
(6,	'Test Suite Minefield',	3,	2,	1),
(7,	'SubTest Suite',	6,	2,	1),
(8,	'TestCase 1',	6,	3,	1000),
(9,	'',	8,	4,	0),
(10,	'Editable TC1',	5,	3,	1000),
(11,	'',	10,	4,	0),
(12,	'Test Plan Minefield',	3,	5,	0),
(13,	'Editable TestPlan',	4,	5,	0),
(14,	'Closeable TP',	4,	5,	0),
(15,	'Remove TP',	4,	5,	0),
(16,	'Second Editable TS',	4,	2,	2),
(20,	'Editable TC2',	5,	3,	1001),
(21,	'',	20,	4,	0),
(22,	'',	21,	9,	0),
(23,	'',	21,	9,	0),
(24,	'',	21,	9,	0),
(25,	'',	9,	9,	0),
(26,	'',	9,	9,	0),
(27,	'Editable TC3 - Unassigned',	5,	3,	1002),
(28,	'',	27,	4,	0),
(29,	'Editable TC4 - ReportableA',	5,	3,	1003),
(30,	'',	29,	4,	0),
(31,	'',	30,	9,	0),
(32,	'',	30,	9,	0),
(33,	'',	30,	9,	0),
(34,	'Editable TC4 - ReportableB',	5,	3,	1004),
(35,	'',	34,	4,	0),
(36,	'',	35,	9,	0),
(37,	'',	35,	9,	0),
(38,	'',	35,	9,	0),
(39,	'Reportable TP',	4,	5,	0),
(40,	'Editable Requirement Section',	4,	6,	1),
(41,	'Editable Requirement 1',	40,	11,	0),
(42,	'Editable Requirement Section',	40,	11,	0),
(43,	'Requirement 1',	40,	7,	1),
(44,	'',	43,	8,	0);

TRUNCATE `node_types`;
INSERT INTO `node_types` (`id`, `description`) VALUES
(1,	'testproject'),
(2,	'testsuite'),
(3,	'testcase'),
(4,	'testcase_version'),
(5,	'testplan'),
(6,	'requirement_spec'),
(7,	'requirement'),
(8,	'requirement_version'),
(9,	'testcase_step'),
(10,	'requirement_revision'),
(11,	'requirement_spec_revision'),
(12,	'build'),
(13,	'platform'),
(14,	'user');

TRUNCATE `object_keywords`;
INSERT INTO `object_keywords` (`id`, `fk_id`, `fk_table`, `keyword_id`) VALUES
(1,	6,	'nodes_hierarchy',	1);

TRUNCATE `platforms`;
INSERT INTO `platforms` (`id`, `name`, `testproject_id`, `notes`, `enable_on_design`, `enable_on_execution`) VALUES
(1,	'Platform minefield',	3,	'<p>Platform to be used on tests</p>',	1,	1),
(2,	'Platform to Add',	4,	'<p>Platform to add on tests</p>',	0,	1),
(3,	'Platform to Remove',	4,	'<p>Platform to remove on tests</p>',	0,	1),
(4,	'Platform editable',	4,	'<p>Platform to be used on edit tests</p>',	0,	1),
(5,	'Reportable Platform',	4,	'',	0,	1);

TRUNCATE `plugins`;

TRUNCATE `plugins_configuration`;

TRUNCATE `reqmgrsystems`;

TRUNCATE `requirements`;
INSERT INTO `requirements` (`id`, `srs_id`, `req_doc_id`) VALUES
(43,	40,	'ReqUC1');

TRUNCATE `req_coverage`;
INSERT INTO `req_coverage` (`id`, `req_id`, `req_version_id`, `testcase_id`, `tcversion_id`, `link_status`, `is_active`, `author_id`, `creation_ts`, `review_requester_id`, `review_request_ts`) VALUES
(1,	43,	44,	10,	11,	1,	1,	1,	'2021-04-24 19:30:17',	NULL,	NULL);

TRUNCATE `req_monitor`;

TRUNCATE `req_relations`;

TRUNCATE `req_revisions`;

TRUNCATE `req_specs`;
INSERT INTO `req_specs` (`id`, `testproject_id`, `doc_id`) VALUES
(40,	4,	'EditReqS');

TRUNCATE `req_specs_revisions`;
INSERT INTO `req_specs_revisions` (`parent_id`, `id`, `revision`, `doc_id`, `name`, `scope`, `total_req`, `status`, `type`, `log_message`, `author_id`, `creation_ts`, `modifier_id`, `modification_ts`) VALUES
(40,	41,	1,	'EditReq1',	'Editable Requirement 1',	'<p>Requirement of editable project</p>',	0,	1,	'1',	'Requirement Specification Created',	1,	'2021-04-24 19:13:13',	NULL,	'2021-04-24 23:13:13'),
(40,	42,	2,	'EditReqS',	'Editable Requirement Section',	'<p>Requirement of editable project</p>',	0,	1,	'1',	'',	1,	'2021-04-24 19:15:05',	NULL,	'2021-04-24 23:15:05');

TRUNCATE `req_versions`;
INSERT INTO `req_versions` (`id`, `version`, `revision`, `scope`, `status`, `type`, `active`, `is_open`, `expected_coverage`, `author_id`, `creation_ts`, `modifier_id`, `modification_ts`, `log_message`) VALUES
(44,	1,	1,	'<pre>\r\nTest Case Requirement</pre>',	'D',	'3',	1,	1,	1,	1,	'2021-04-24 19:19:20',	NULL,	'2021-04-24 23:19:20',	'Requirement Created');

TRUNCATE `risk_assignments`;

TRUNCATE `tcsteps`;
INSERT INTO `tcsteps` (`id`, `step_number`, `actions`, `expected_results`, `active`, `execution_type`) VALUES
(22,	1,	'<p>First step</p>\r\n',	'<p>Do something cool</p>\r\n',	1,	1),
(23,	2,	'<p>Second step</p>\r\n',	'<p>Coolest thing!</p>\r\n',	1,	1),
(24,	3,	'<p>Third step</p>\r\n',	'<p>Meh</p>\r\n',	1,	1),
(25,	1,	'<p>Testable step 1</p>\r\n',	'',	1,	1),
(26,	2,	'<p>Testable step 2</p>\r\n',	'',	1,	1),
(31,	1,	'<p>First step</p>\r\n',	'<p>Do something cool</p>\r\n',	1,	1),
(32,	2,	'<p>Second step</p>\r\n',	'<p>Coolest thing!</p>\r\n',	1,	1),
(33,	3,	'<p>Third step</p>\r\n',	'<p>Meh</p>\r\n',	1,	1),
(36,	1,	'<p>First step</p>\r\n',	'<p>Do something cool</p>\r\n',	1,	1),
(37,	2,	'<p>Second step</p>\r\n',	'<p>Coolest thing!</p>\r\n',	1,	1),
(38,	3,	'<p>Third step</p>\r\n',	'<p>Meh</p>\r\n',	1,	1);

TRUNCATE `tcversions`;
INSERT INTO `tcversions` (`id`, `tc_external_id`, `version`, `layout`, `status`, `summary`, `preconditions`, `importance`, `author_id`, `creation_ts`, `updater_id`, `modification_ts`, `active`, `is_open`, `execution_type`, `estimated_exec_duration`) VALUES
(9,	1,	1,	1,	1,	'',	'',	2,	1,	'2021-04-17 16:18:03',	1,	'2021-04-18 18:16:03',	1,	1,	1,	NULL),
(11,	1,	1,	1,	1,	'',	'',	2,	1,	'2021-04-17 16:18:43',	1,	'2021-04-18 17:37:17',	1,	1,	1,	NULL),
(21,	2,	1,	1,	1,	'<p>Have steps</p>\r\n',	'',	2,	1,	'2021-04-18 15:40:27',	1,	'2021-04-18 17:42:12',	1,	1,	1,	NULL),
(28,	3,	1,	1,	1,	'',	'',	2,	1,	'2021-04-24 09:58:07',	NULL,	'2021-04-24 13:58:07',	1,	1,	1,	NULL),
(30,	4,	1,	1,	1,	'<p>Have steps</p>\r\n',	'',	2,	1,	'2021-04-24 18:08:51',	NULL,	'2021-04-24 22:08:51',	1,	1,	1,	NULL),
(35,	5,	1,	1,	1,	'<p>Have steps</p>\r\n',	'',	2,	1,	'2021-04-24 18:09:04',	NULL,	'2021-04-24 22:09:04',	1,	1,	1,	NULL);

TRUNCATE `testcase_keywords`;
INSERT INTO `testcase_keywords` (`id`, `testcase_id`, `tcversion_id`, `keyword_id`) VALUES
(1,	8,	9,	1),
(10,	10,	11,	3);

TRUNCATE `testcase_platforms`;

TRUNCATE `testcase_relations`;

TRUNCATE `testcase_script_links`;

TRUNCATE `testplans`;
INSERT INTO `testplans` (`id`, `testproject_id`, `notes`, `active`, `is_open`, `is_public`, `api_key`) VALUES
(12,	3,	'<p>Test plan to be used on library testing</p>',	1,	1,	1,	'41d7bccb1f9fe5b5a82a6fe4b161651b35a65ca132c01307be1fbc04e562b35c'),
(13,	4,	'<p>Test plan to be edited on tests</p>',	1,	1,	1,	'19e3e011c2bbe31e8418227cc7d76b4e7cdca82cfad9e1db68915318529e17cd'),
(14,	4,	'<p>Test plan to be closed on tests</p>',	0,	1,	0,	'b6b2a9a023454b388028bcbe8e70a6f4cf1fc9595b76e13d84181f2f93019196'),
(15,	4,	'<p>Test plan to be removed on tests</p>',	0,	1,	0,	'0af71a3597ef04fb1544714a0932fccc949078a925b4a20d47d09b1c86271538'),
(39,	4,	'',	1,	1,	1,	'38d09dde87e9c6fb5c74d789035576e28d767f6e2516a23ae81d980e2da111fa');

TRUNCATE `testplan_platforms`;
INSERT INTO `testplan_platforms` (`id`, `testplan_id`, `platform_id`, `active`) VALUES
(1,	13,	3,	1),
(2,	12,	1,	1),
(3,	13,	4,	1),
(4,	39,	5,	1);

TRUNCATE `testplan_tcversions`;
INSERT INTO `testplan_tcversions` (`id`, `testplan_id`, `tcversion_id`, `node_order`, `urgency`, `platform_id`, `author_id`, `creation_ts`) VALUES
(1,	12,	9,	1,	2,	0,	1,	'2021-04-18 00:39:29'),
(2,	13,	11,	1,	2,	4,	1,	'2021-04-18 19:50:37'),
(3,	13,	21,	1,	2,	4,	1,	'2021-04-18 19:50:50'),
(4,	39,	30,	1,	2,	5,	1,	'2021-04-24 18:10:31'),
(5,	39,	35,	1,	2,	5,	1,	'2021-04-24 18:10:41');

TRUNCATE `testprojects`;
INSERT INTO `testprojects` (`id`, `notes`, `color`, `active`, `option_reqs`, `option_priority`, `option_automation`, `options`, `prefix`, `tc_counter`, `is_public`, `issue_tracker_enabled`, `code_tracker_enabled`, `reqmgr_integration_enabled`, `api_key`) VALUES
(1,	'<p>Initial project to test testlink-xmlrpc Node project.</p>',	'',	1,	0,	0,	0,	'O:8:\"stdClass\":4:{s:19:\"requirementsEnabled\";i:0;s:19:\"testPriorityEnabled\";i:1;s:17:\"automationEnabled\";i:1;s:16:\"inventoryEnabled\";i:0;}',	'IP',	0,	1,	0,	0,	0,	'786ea4cee95e762f4ca7fee067994c5083021b1b23f89f67b1be5ffa8287d44a'),
(2,	'<p>Project to be removed during library tests.</p>',	'',	1,	0,	0,	0,	'O:8:\"stdClass\":4:{s:19:\"requirementsEnabled\";i:0;s:19:\"testPriorityEnabled\";i:1;s:17:\"automationEnabled\";i:1;s:16:\"inventoryEnabled\";i:0;}',	'RP',	0,	1,	0,	0,	0,	'b230b17aba6b9edd4f45f807e825be100f2b0a26e756e54323ab8e71686e3a70'),
(3,	'<p>Project to be used on tests.</p>',	'',	1,	0,	0,	0,	'O:8:\"stdClass\":4:{s:19:\"requirementsEnabled\";i:0;s:19:\"testPriorityEnabled\";i:1;s:17:\"automationEnabled\";i:1;s:16:\"inventoryEnabled\";i:0;}',	'TP',	1,	1,	0,	0,	0,	'9af5e446bce39a1ab554be800c659f57132924c778640dcc2790e4958f0b95db'),
(4,	'<p>Project to be used on tests to add/edit.</p>',	'',	1,	0,	0,	0,	'O:8:\"stdClass\":4:{s:19:\"requirementsEnabled\";i:1;s:19:\"testPriorityEnabled\";i:1;s:17:\"automationEnabled\";i:1;s:16:\"inventoryEnabled\";i:0;}',	'EP',	5,	1,	0,	0,	0,	'52903fbc71482ae09456b3a13de785a50f92dde0da7b589a59a800c6fc9ec8cb');

TRUNCATE `testproject_codetracker`;

TRUNCATE `testproject_issuetracker`;

TRUNCATE `testproject_reqmgrsystem`;

TRUNCATE `testsuites`;
INSERT INTO `testsuites` (`id`, `details`) VALUES
(5,	''),
(6,	''),
(7,	''),
(16,	'');

TRUNCATE `text_templates`;

TRUNCATE `users`;
INSERT INTO `users` (`id`, `login`, `password`, `role_id`, `email`, `first`, `last`, `locale`, `default_testproject_id`, `active`, `script_key`, `cookie_string`, `auth_method`, `creation_ts`, `expiration_date`) VALUES
(1,	'admin',	'$2y$10$jn.Hm2NxE.CsxtvNDxybL.U.15Y/A3/J5CU46R0JE0Tbft1dYVfdm',	8,	'',	'Testlink',	'Administrator',	'en_GB',	NULL,	1,	'a4795ab4fe140089c65e82985d20f663',	'70b5ae2e1f0513dc884132dc611315eba7eab664b08109ff9641ba656babcdef',	'',	'2021-04-17 17:11:08',	NULL),
(2,	'Leader',	'$2y$10$dpSmz5ol9KnE8VdvWkMlDOqI7txXTzZi6MhOCAKKIqiHx0RN/ZWfq',	9,	'leader@testlink-xmlrpc.com',	'Leader',	'Testlink',	'es_ES',	NULL,	1,	'8623eb015b5d5f90291a45ce83274cdc',	'bb054c74dfa2b755488eba53c9811659945a56bf58ea700461162edf8967be11',	'',	'2021-04-17 17:17:09',	NULL),
(3,	'SeniorTester',	'$2y$10$dPXIDchYDgaWVVTjAqrtJeQMbwxVOfxpW.2FERxuTAUXPdk1CQQyq',	6,	'seniortester@testlink-xmlrpc.com',	'Senior Tester',	'Testlink',	'es_ES',	NULL,	1,	NULL,	'1844bf73de5206e108c88f001ad835afcbf5945cb27b4dfe4c680e641b310df0',	'',	'2021-04-17 17:17:28',	NULL),
(4,	'TestDesigner',	'$2y$10$05L8nAzIxR9FaU78YanrRuT1uTCaKPsGvKB5W2xPkDk.k4XW3cM82',	4,	'testdesigner@testlink-xmlrpc.com',	'Test Designer',	'Testlink',	'es_ES',	NULL,	1,	NULL,	'48d96e63df029d96a7467eb3b4de6273d48fe38de3548a770822d6aa40ab27c8',	'',	'2021-04-17 17:18:06',	NULL),
(5,	'Tester',	'$2y$10$Kery8v0uYXmmlsrfmYEDgOcNM9xDwXTcXavkm04V6XxuuyTPd6KhG',	7,	'tester@testlink-xmlrpc.com',	'Tester',	'Testlink',	'es_ES',	NULL,	1,	NULL,	'073112624582e9e1a776ec96285f167e62e27de20b83c22c39dd7eb04bcc3d4f',	'',	'2021-04-17 17:18:30',	NULL),
(6,	'Guest',	'$2y$10$foGhtqGNYl8ozvVyOzCeQ.ZueGfVgB4NEl/WoLobCyqxRrfbUbMJi',	5,	'guest@testlink-xmlrpc.com',	'Guest',	'Testlink',	'es_ES',	NULL,	1,	NULL,	'301a8f27d000c13b40e4a6fb5f30c56059fc1b66a7c8f03ec9acbcb36524e0ba',	'',	'2021-04-17 17:18:53',	NULL);

TRUNCATE `user_assignments`;
INSERT INTO `user_assignments` (`id`, `type`, `feature_id`, `user_id`, `build_id`, `deadline_ts`, `assigner_id`, `creation_ts`, `status`) VALUES
(1,	1,	1,	1,	3,	NULL,	1,	'2021-04-18 19:15:16',	1),
(2,	1,	3,	1,	2,	NULL,	1,	'2021-04-18 19:51:12',	1),
(3,	1,	2,	1,	2,	NULL,	1,	'2021-04-18 19:51:21',	1);

TRUNCATE `user_group`;

TRUNCATE `user_group_assign`;

TRUNCATE `user_testplan_roles`;
INSERT INTO `user_testplan_roles` (`user_id`, `testplan_id`, `role_id`) VALUES
(1,	14,	8),
(1,	15,	8);

TRUNCATE `user_testproject_roles`;

-- 2023-04-07 09:22:57
