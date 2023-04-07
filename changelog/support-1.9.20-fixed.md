### Changed
* Support TestLink 1.9.20_fixed:
  * Logic:
    * `updateBuildCustomFieldsValues` The parameter `customfields` now is a map with name as key.
    * `getReqCoverage` The parameter `requirementdocid` was replaced with `requirementversionid`.
    * `getTestCaseAttachments`: Added `version` parameter.
    * `assignTestCaseExecutionTask`: Parameters `platformid` and `platformname` are no longer required.
  * Tests: Updated and recorded.
