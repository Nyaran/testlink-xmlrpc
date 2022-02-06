## Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres
to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
 * Check on [changelog folder](changelog).

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
 * Fix connect with https ([#46] thanks [@oghmjos](https://github.com/oghmjos))

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
 * [#8]

## [1.9.18-3] - 2018-10-26
### Fixed
 * [#4]
 * [#5]
 * [#6]

## [1.9.18-2] - 2018-10-25
### Fixed
 * [#1]
 * Few fixes on README

## [1.9.18-1] - 2018-09-30
### Added
 * Project begins
