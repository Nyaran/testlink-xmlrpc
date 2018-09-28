/**
 * @license
 * This file is part of testlink-xmlrpc.
 *
 * testlink-xmlrpc is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * testlink-xmlrpc is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with testlink-xmlrpc. If not, see <https://www.gnu.org/licenses/>.
 *
 * @author Luis Zurro de Cos <luiszurrodecos@gmail.com
 */

const constants = {
    ActionOnDuplicate: {
        BLOCK: "block",
        GENERATE_NEW: "generate_new",
        CREATE_NEW_VERSION: "create_new_version"
    },

    ExecutionStatus: {
        NOT_RUN: 'n',
        PASSED: 'p',
        FAILED: 'f',
        BLOCKED: 'b'
    },

    ExecutionType: {
        MANUAL: 1,
        AUTOMATED: 2
    },

    Details: {
        FULL: "full",
        SIMPLE: "simple",
        VALUE: "value"
    },

    TestCaseStatus: {
        FINAL: 7,
        FUTURE: 6,
        OBSOLETE: 5,
        REWORK: 4,
        REVIEW_IN_PROGRESS: 3,
        READY_FOR_REVIEW: 2,
        DRAFT: 1,
    },

    StepAction: {
        CREATE: 'create', // If step exist, do nothing
        UPDATE: 'update', // If steps does not exist, create it, else update
        PUSH: 'push'    // Shift down all steps with step number >= step number provided (NOT IMPLEMENTED YET ON TESTLINK)
    },

    ImportanceLevel: {
        HIGH: 3,
        MEDIUM: 2, // Default importance
        LOW: 1
    }
};

module.exports = constants;
