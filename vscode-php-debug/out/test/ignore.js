"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const chai_1 = require("chai");
const mocha_1 = require("mocha");
const ignore_1 = require("../ignore");
(0, mocha_1.describe)('ignoreExceptions', () => {
    (0, mocha_1.it)('should match exact', () => {
        chai_1.assert.isTrue((0, ignore_1.shouldIgnoreException)('BaseException', ['BaseException']));
    });
    (0, mocha_1.it)('should no match exact', () => {
        chai_1.assert.isFalse((0, ignore_1.shouldIgnoreException)('BaseException', ['SomeOtherException']));
    });
    (0, mocha_1.it)('should match wildcard end exact', () => {
        chai_1.assert.isTrue((0, ignore_1.shouldIgnoreException)('BaseException', ['BaseException*']));
    });
    (0, mocha_1.it)('should match wildcard end extra', () => {
        chai_1.assert.isTrue((0, ignore_1.shouldIgnoreException)('BaseExceptionMore', ['BaseException*']));
    });
    (0, mocha_1.it)('should match namespaced exact', () => {
        chai_1.assert.isTrue((0, ignore_1.shouldIgnoreException)('NS1\\BaseException', ['NS1\\BaseException']));
    });
    (0, mocha_1.it)('should match namespaced wildcard exact', () => {
        chai_1.assert.isTrue((0, ignore_1.shouldIgnoreException)('NS1\\BaseException', ['NS1\\BaseException*']));
    });
    (0, mocha_1.it)('should match namespaced wildcard extra', () => {
        chai_1.assert.isTrue((0, ignore_1.shouldIgnoreException)('NS1\\BaseExceptionMore', ['NS1\\BaseException*']));
    });
    (0, mocha_1.it)('should match namespaced wildcard whole level', () => {
        chai_1.assert.isTrue((0, ignore_1.shouldIgnoreException)('NS1\\BaseException', ['NS1\\*']));
    });
    (0, mocha_1.it)('should not match namespaced wildcard more levels', () => {
        chai_1.assert.isFalse((0, ignore_1.shouldIgnoreException)('NS1\\NS2\\BaseException', ['NS1\\*']));
    });
    (0, mocha_1.it)('should match namespaced wildcard in middle', () => {
        chai_1.assert.isTrue((0, ignore_1.shouldIgnoreException)('NS1\\NS2\\BaseException', ['NS1\\*\\BaseException']));
    });
    (0, mocha_1.it)('should match namespaced wildcard multiple', () => {
        chai_1.assert.isTrue((0, ignore_1.shouldIgnoreException)('NS1\\NS2\\NS3\\BaseException', ['NS1\\*\\*\\BaseException']));
    });
    (0, mocha_1.it)('should match namespaced wildcard levels', () => {
        chai_1.assert.isTrue((0, ignore_1.shouldIgnoreException)('NS1\\NS2\\NS3\\BaseException', ['NS1\\**\\BaseException']));
    });
});
//# sourceMappingURL=ignore.js.map