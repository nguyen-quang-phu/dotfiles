"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const chai_1 = require("chai");
const mocha_1 = require("mocha");
const envfile_1 = require("../envfile");
(0, mocha_1.describe)('EnvFile', () => {
    (0, mocha_1.it)('should work without envfile', () => {
        const ret = (0, envfile_1.getConfiguredEnvironment)({ env: { TEST: 'TEST' } });
        chai_1.assert.deepEqual(ret, { TEST: 'TEST' });
    });
    (0, mocha_1.it)('should work with missing envfile', () => {
        const ret = (0, envfile_1.getConfiguredEnvironment)({ env: { TEST: 'TEST' }, envFile: 'NONEXISTINGFILE' });
        chai_1.assert.deepEqual(ret, { TEST: 'TEST' });
    });
    (0, mocha_1.it)('should merge envfile', () => {
        const ret = (0, envfile_1.getConfiguredEnvironment)({ env: { TEST: 'TEST' }, envFile: 'testproject/envfile' });
        chai_1.assert.deepEqual(ret, { TEST: 'TEST', TEST1: 'VALUE1', Test2: 'Value2' });
    });
    (process.platform === 'win32' ? mocha_1.it : mocha_1.it.skip)('should merge envfile on win32', () => {
        const ret = (0, envfile_1.getConfiguredEnvironment)({ env: { TEST1: 'TEST' }, envFile: 'testproject/envfile' });
        chai_1.assert.deepEqual(ret, { TEST1: 'TEST', Test2: 'Value2' });
    });
    (process.platform === 'win32' ? mocha_1.it : mocha_1.it.skip)('should merge envfile on win32 case insensitive', () => {
        const ret = (0, envfile_1.getConfiguredEnvironment)({ env: { Test1: 'TEST' }, envFile: 'testproject/envfile' });
        chai_1.assert.deepEqual(ret, { TEST1: 'TEST', Test2: 'Value2' });
    });
    (process.platform !== 'win32' ? mocha_1.it : mocha_1.it.skip)('should merge envfile on unix', () => {
        const ret = (0, envfile_1.getConfiguredEnvironment)({ env: { TEST1: 'TEST' }, envFile: 'testproject/envfile' });
        chai_1.assert.deepEqual(ret, { TEST1: 'TEST', Test2: 'Value2' });
    });
    (process.platform !== 'win32' ? mocha_1.it : mocha_1.it.skip)('should merge envfile on unix case insensitive', () => {
        const ret = (0, envfile_1.getConfiguredEnvironment)({ env: { Test1: 'TEST' }, envFile: 'testproject/envfile' });
        chai_1.assert.deepEqual(ret, { Test1: 'TEST', TEST1: 'VALUE1', Test2: 'Value2' });
    });
});
//# sourceMappingURL=envfile.js.map