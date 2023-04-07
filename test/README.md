# How to re-record tests

## Prepare TestLink instance

### Install server

#### Fedora (and other dnf based systems)

```bash
sudo dnf install httpd mariadb-server php{,-{gd,mysqlnd,soap}}
```

### Install server

#### Fedora (and other systemd based systems)

```bash
sudo systemctl start httpd mariadb
```

### Download TestLink

*If your http directory is different, change the variable value*

```shell
TESTLINK_HOMEDIR=/var/www/testlink
sudo mkdir -p "${TESTLINK_HOMEDIR}"
wget -c https://github.com/TestLinkOpenSourceTRMS/testlink-code/archive/refs/heads/testlink_1_9_20_fixed.zip -O - | sudo tar -xz --strip-components=2 -C "${TESTLINK_HOMEDIR}"
```

### Install testlink

1. Follow the initial setup process.

## Prepare TestLink for tests:

### Automatic
#### SQL
Dump the SQL file `test/db_dump/testlink-20210401T194903Z.sql` to you DB instance.
```shell
DB_USER=<YOUR_DB_USER>
mysql -u "${DB_USER}" -p testlink_void < db_dump/testlink.sql
```
#### Attachments
Copy files to attachments directory
```shell
TL_UPLOAD_AREA=<YOUR_TESTLINK_UPLOAD_AREA_PATH>
TL_UPLOAD_AREA=/var/testlink/upload_area
mkdir -p "${TL_UPLOAD_AREA}/nodes_hierarchy/6" && cp resources/attachment.png "${_}/2c46dff9581a972995ca0f7194cea408.png"
mkdir -p "${TL_UPLOAD_AREA}/tcversions/11" && cp resources/attachment.png "${_}/f3f53e0f28edc4f56d0806c2f2a372c6.png"
```

### Manual

### Steps
1. Login to TestLink.
2. Create the initial project: InitialProject (See Projects table).
3. Create projects (See Projects table).
4. Set TP:TestableProject as current project
5. Create users (See Users table).
6. Create apiKey for admin and Leader.
7. Create custom fields, and assign all to current project (See Custom Fields table).
8. Assign all custom fields to EditableProject.
9. Create issue trackers (See Issue Trackers table).
10. Create code trackers (See Code Trackers table).
11. Create keywords (See Keywords table).
12. Create test suites (See Test Suites table).
13. Create test cases (See Test Cases table).
14. Assign steps to tests cases (See Steps table).
15. Clone TC EP-2 as "Editable TC4 - ReportableA" (to bottom).
16. Clone TC EP-2 as "Editable TC5 - ReportableB" (to bottom).
17. Create test plans (See Test Plans table).
18. Create platforms (See Platforms table).
19. Create builds (See Builds table).
20. On TP:TestableProject > Add/Remove Test Cases > Select Test Suite Minefield > Add TP-1 to Build Minefield and all platforms and admin user.
21. Execute tests on TestableProject. The time should be 61, and execution status PASSED.
22. Upload attachment `resources/attachment.png` to `Test Suite Minefield` and to `TP-1`.


The following tables describes the data to be created on fresh TestLink instance.

#### Projects

| Name             | Prefix | Description                                           | Issue Tracker | Code Tracker | Requirement Feature | Active | Public |
|------------------|--------|-------------------------------------------------------|---------------|--------------|---------------------|--------|--------|
| InitialProject   | IP     | Initial project to test testlink-xmlrpc Node project. |               |              | Yes                 | Yes    | Yes    |
| RemoveProject    | RP     | Project to be removed during library tests.           |               |              |                     | No     | Yes    |
| TestableProject  | TP     | Project to be used on tests.                          |               |              |                     | No     | Yes    |
| EditableProject  | EP     | Project to be used on tests to add/edit.              |               |              |                     | No     | Yes    |

#### Users

| Login        | Password     | First Name    | Last Name     | Email                            | Role          | Has Api Key |
|--------------|--------------|---------------|---------------|----------------------------------|---------------|-------------|
| admin        | admin        | Testlink      | Administrator |                                  | admin         | Yes         |
| Leader       | Leader       | Leader        | Testlink      | leader@testlink-xmlrpc.com       | leader        | Yes         |
| SeniorTester | SeniorTester | Senior Tester | Testlink      | seniortester@testlink-xmlrpc.com | senior tester | No          |
| TestDesigner | TestDesigner | Test Designer | Testlink      | testdesigner@testlink-xmlrpc.com | test designer | No          |
| Tester       | Tester       | Tester        | Testlink      | tester@testlink-xmlrpc.com       | tester        | No          |
| Guest        | Guest        | Guest         | Testlink      | guest@testlink-xmlrpc.com        | guest         | No          |

#### Custom Fields

| Name             | Label                        | Type   | Enabled on Context | Display on execution | Available for                      |
|------------------|------------------------------|--------|--------------------|----------------------|------------------------------------|
| CF_Build         | CF Build                     | string | test specification | Yes                  | Build                              |
| CF_Requirement   | CF Requirement               | string | test specification |                      | Requirement                        |
| CF_RequirementSD | CF RequirementSD             | string | test specification |                      | Requirement Specification Document |
| CF_TestCase_TSD  | CF TestCase Test Spec Design | string | test specification | Yes                  | Test Case                          |
| CF_TestPlan      | CF TestPlan                  | string | test specification | Yes                  | Test Plan                          |
| CF_TestSuite     | CF TestSuite                 | string | test specification | Yes                  | Test Suite                         |
| CF_TestCase_TE   | CF TestCase Test Execution   | string | test specification | Yes                  | Test Case                          |
| CF_TestCase_TPD  | CF TestCase Test Plan Design | string | test specification | Yes                  | Test Case                          |
#### Issue Trackers

| Issue Tracker | Type                       | Configuration |
|---------------|----------------------------|---------------|
| LocalBugzilla | bugzilla (Interface: soap) |               |

#### Code Trackers

| Code Tracker | Type                     | Configuration |
|--------------|--------------------------|---------------|
| LocalStash   | stash (Interface: rest)  |               |

#### Keywords

| Project         | Keyword            | Description                              |
|-----------------|--------------------|------------------------------------------|
| TestableProject | Test Keyword       | Keyword to be used on library tests      |
| EditableProject | Assignable keyword | Keyword to be assigned by test execution |
| EditableProject | Assigned keyword   | Default assigned keyword                 |

#### Test Suites

| Project         | Assigned to          | Name                 | Custom field: CF TestSuite | Keywords         |
|-----------------|----------------------|----------------------|----------------------------|------------------|
| TestableProject |                      | Test Suite Minefield | Value for CF TS            | Test Keyword     |
| TestableProject | Test Suite Minefield | SubTest Suite        |                            |                  |
| TestableProject | Test Suite Minefield | SubTest Suite        |                            |                  |
| EditableProject |                      | Editable TS          | To edit CF TS              | Assigned keyword |
| EditableProject |                      | Second Editable TS   |                            |                  |

#### Test Cases

| Project         | Name                      | Test Suite           | Summary    | Custom field: CF TestCase |
|-----------------|---------------------------|----------------------|------------|---------------------------|
| TestableProject | TestCase 1                | Test Suite Minefield |            | Value for CF TC           |
| EditableProject | Editable TC1              | Editable TS          |            | To edit CF TC             |
| EditableProject | Editable TC2              | Editable TS          | Have steps | To edit CF TC             |
| EditableProject | Editable TC3 - Unassigned | Editable TS          |            |                           |

#### Steps

| Project         | Test Case | Name            | Expected results  |
|-----------------|-----------|-----------------|-------------------|
| EditableProject | EP-2      | First step      | Do something cool |
| EditableProject | EP-2      | Second step     | Coolest thing!    |
| EditableProject | EP-2      | Third step      | Meh               |
| TestableProject | TP-1      | Testable step 1 |                   |
| TestableProject | TP-1      | Testable step 2 |                   |

#### Test Plans

| Project         | Name                | Description                             | Active | Public | Custom Field:CF TestPlan | Assigned TCs |
|-----------------|---------------------|-----------------------------------------|--------|--------|--------------------------|--------------|
| TestableProject | Test Plan Minefield | Test plan to be used on library testing | Yes    | Yes    | Test Plan CF Value       | IP-1         |
| EditableProject | Editable TestPlan   | Test plan to be edited on tests         | Yes    | Yes    | Editable CF TP           | EP-1, EP-2   |
| EditableProject | Closeable TP        | Test plan to be closed on tests         |        |        |                          |              |
| EditableProject | Remove TP           | Test plan to be removed on tests        |        |        |                          |              |
| EditableProject | Reportable TP       | Test plan to be used on report tests    |        |        |                          | EP-4, EP-5   |

#### Platforms

| Project         | Name                | Description                       | On Design | On Execution | Assigned TP         |
|-----------------|---------------------|-----------------------------------|-----------|--------------|---------------------|
| TestableProject | Platform Minefield  | Platform to be used on tests      | Yes       | Yes          | Test Plan Minefield |
| EditableProject | Platform to Add     | Platform to add on tests          |           | Yes          |                     |
| EditableProject | Platform to Remove  | Platform to remove on tests       |           | Yes          | Editable TestPlan   |
| EditableProject | Platform editable   | Platform to be used on edit tests |           | Yes          | Editable TestPlan   |
| EditableProject | Reportable Platform |                                   |           | Yes          | Reportable TestPlan |

#### Builds

| Project         | Selected Test Plan | Name            | Description                 | Custom Field:CF Build | Release date |
|-----------------|--------------------|-----------------|-----------------------------|-----------------------|--------------|
| EditableProject | Editable TestPlan  | Editable Build  | Build to be edited on tests | CF Build edit Value   | 01/04/2021   |
| EditableProject | Editable TestPlan  | Closeable Build | Build to be closed on tests |                       | 01/04/2021   |
| TestableProject | Editable TestPlan  | Build Minefield | Build to be used on tests   | CF Build Value        | 01/04/2021   |
| EditableProject | Reportable TP      | Build Minefield | Build to be used on tests   | CF Build Value        | 01/04/2021   |
| EditableProject | Reportable TP      | Reportable Buid |                             |                       | 01/04/2021   |

#### Requirements folders
| Project         | Document Id | Title                        | Description                     | Type    | Custom Field:CF RequirementSD |
|-----------------|-------------|------------------------------|---------------------------------|---------|-------------------------------|
| EditableProject | EditReqS    | Editable Requirement Section | Requirement of editable project | Section | CF RequirementSD edit Value   |

#### Requirements
| Project         | Assign   | Document Id | Title            | Description           | Type      | Custom Field:CF Requirement | Coverage |
|-----------------|----------|-------------|------------------|-----------------------|-----------|-----------------------------|----------|
| EditableProject | EditReqS | ReqUC1      | Requirement UC 1 | Test Case Requirement | Test Case | CF Requirement edit Value   | EP-1     |
