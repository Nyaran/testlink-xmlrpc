## Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres
to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### 💥 Breaking Change
* This package is now pure ESM. Please [read this](https://gist.github.com/sindresorhus/a39789f98801d908bbc7ff3ecc99d99c).
* Drop Node 14 and 16 support.

### 🏠 Internal
* Update eslint config to use flat config.
* Update eslint to v9.
* Add restrictive Code Style with eslint.
* Replace [istanbuljs/nyc](https://github.com/istanbuljs/nyc) with [c8](https://github.com/bcoe/c8).
* Improve linting
* Fix some non-working tests

## [2.1.0] - 2023-04-07
### Added
* New methods supported:
	* `getTestCaseRequirements`
	* `getRequirement`
	* `createUser`
	* `setUserRoleOnProject`
### Changed
* Add `platformondesign` & `platformonexecution` flag in `createPlatform` helper. ([#258](https://github.com/Nyaran/testlink-xmlrpc/issues/258) thanks [@HedCET](https://github.com/HedCET))
* Support TestLink 1.9.20_fixed:
	* Logic:
		* `updateBuildCustomFieldsValues` The parameter `customfields` now is a map with name as key.
		* `getReqCoverage` The parameter `requirementdocid` was replaced with `requirementversionid`.
		* `getTestCaseAttachments`: Added `version` parameter.
		* `assignTestCaseExecutionTask`: Parameters `platformid` and `platformname` are no longer required.
	* Tests: Updated and recorded.

### Internal
* Tweaks on codeql and tests workflows
* Remove node12 tests
* Add https://www.buymeacoffee.com/nyaran to funding
* Tweaks on tsconfig
* Add workflow to publish package

## [2.0.4] - 2022-12-18
### Changed
* Added tests for node 18 and 19.
* Remove tests for node 17.

### Fix
* Exports typings properly. Fixes #207

## [2.0.3] - 2022-02-06
### Added
 * Add funding links to package.json
 * Add `scripts.prepare` (allows to use repo as version directly)
 * Run tests on node 17.

### Changed
 * Update devDependencies and use closed versions.
 * Not launch tests on Node 15 as is not maintained.
 * Rename "master" branch to "main"
 * Improve packaging discarding `.npmignore` and using `files` property on `package.json`.

### Fixed
 * Fix connect with https ([#46](https://github.com/Nyaran/testlink-xmlrpc/issues/46) thanks [@oghmjos](https://github.com/oghmjos))

### Removed
 * Run tests on node 15.

## [2.0.2] - 2021-05-27
### Changed
 * Upgrade ts-node to v10.
 * Move ts-node to devDependencies.
 * Add links on README badges.

### Fixed
 * Ignore .idea directory by git.
 * Ignore unnecessary files from package.
 * Fix repository url on package.json.

## [2.0.1] - 2021-04-25
### Fixed
 * Fix README badges.

## [2.0.0] - 2021-04-25
### Added
 * Added a lot of tests.

### Changed
 * Now the project uses its own versioning, not linked to TestLink. 
 * Migrated to TypeScript.

### Fixed
 * Few fixes on mandatory fields on some methods.

## [1.9.18-5] - 2019-02-27
### Added
 * Allow using secure mode

### Changed
 * platform is not required on getLastExecutionResult method

## [1.9.18-4] - 2018-11-07
### Added
 * Added "thanks" section to README

### Fixed
 * [#8](https://github.com/Nyaran/testlink-xmlrpc/issues/8)

## [1.9.18-3] - 2018-10-26
### Fixed
 * [#4](https://github.com/Nyaran/testlink-xmlrpc/issues/4)
 * [#5](https://github.com/Nyaran/testlink-xmlrpc/issues/5)
 * [#6](https://github.com/Nyaran/testlink-xmlrpc/issues/6)

## [1.9.18-2] - 2018-10-25
### Fixed
 * [#1](https://github.com/Nyaran/testlink-xmlrpc/issues/1)
 * Few fixes on README

## [1.9.18-1] - 2018-09-30
### Added
 * Project begins
