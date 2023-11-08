"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const chai_1 = require("chai");
const proxyConnect_1 = require("../proxyConnect");
const iconv_lite_1 = require("iconv-lite");
const dbgp_1 = require("../dbgp");
const net_1 = require("net");
const mocha_1 = require("mocha");
(0, mocha_1.describe)('ProxyConnect', () => {
    function _xml(cmd, success, msg = '', id = 0) {
        const err = `<proxy${cmd} success="${success}"><error id="${id}"><message>${msg}</message></error></proxy${cmd}>`;
        return (0, iconv_lite_1.encode)(`<?xml version="1.0" encoding="UTF-8"?>\n${err}`, dbgp_1.ENCODING);
    }
    const host = 'host';
    const port = 9001;
    let conn;
    let testSocket;
    let msgs;
    (0, mocha_1.beforeEach)(() => {
        testSocket = new net_1.Socket();
        testSocket.connect = (...param) => {
            return testSocket;
        };
        conn = new proxyConnect_1.ProxyConnect(host, port, 9000, true, undefined, 3000, testSocket);
        msgs = conn.msgs;
    });
    (0, mocha_1.it)('should timeout', (done) => {
        chai_1.assert.exists(conn);
        conn.sendProxyInitCommand().catch((err) => {
            chai_1.assert.equal(err.message, msgs.timeout);
            done();
        });
        testSocket.emit('error', new Error(msgs.timeout));
    });
    (0, mocha_1.it)('should fail if proxy is unreachable', (done) => {
        chai_1.assert.exists(conn);
        conn.sendProxyInitCommand().catch((err) => {
            chai_1.assert.equal(err.message, msgs.resolve);
            done();
        });
        testSocket.emit('lookup', new Error(msgs.resolve));
    });
    (0, mocha_1.it)('should throw an error for duplicate IDE key', (done) => {
        chai_1.assert.exists(conn);
        conn.sendProxyInitCommand().catch((err) => {
            chai_1.assert.equal(err.message, msgs.duplicateKey);
            done();
        });
        testSocket.emit('data', _xml('init', 0, msgs.duplicateKey));
        testSocket.emit('close', false);
    });
    (0, mocha_1.it)('should request registration', (done) => {
        conn.on('log_request', (str) => {
            chai_1.assert.equal(str, msgs.registerInfo);
            done();
        });
        conn.sendProxyInitCommand().catch((err) => {
            done(err);
        });
    });
    (0, mocha_1.it)('should be registered', (done) => {
        conn.on('log_response', (str) => {
            chai_1.assert.equal(str, msgs.registerSuccess);
            done();
        });
        conn.sendProxyInitCommand().catch((err) => {
            done(err);
        });
        testSocket.emit('data', _xml('init', 1));
        testSocket.emit('close', false);
    });
    (0, mocha_1.it)('should request deregistration', (done) => {
        conn.on('log_request', (str) => {
            chai_1.assert.equal(str, msgs.deregisterInfo);
            done();
        });
        testSocket.emit('data', _xml('init', 1));
        testSocket.emit('close', false);
        conn.sendProxyStopCommand().catch((err) => {
            done(err);
        });
    });
    (0, mocha_1.it)('should be deregistered', (done) => {
        conn.on('log_response', (str) => {
            chai_1.assert.equal(str, msgs.deregisterSuccess);
            done();
        });
        testSocket.emit('data', _xml('stop', 1));
        testSocket.emit('close', false);
        conn.sendProxyStopCommand().catch((err) => {
            done(err);
        });
    });
    (0, mocha_1.it)('should throw an error for nonexistent IDE key', (done) => {
        conn.sendProxyInitCommand().catch((err) => {
            done(err);
        });
        testSocket.emit('data', _xml('init', 1));
        testSocket.emit('close', false);
        conn.sendProxyStopCommand().catch((err) => {
            chai_1.assert.equal(msgs.nonexistentKey, err.message);
            done();
        });
        testSocket.emit('data', _xml('stop', 0, msgs.nonexistentKey));
        testSocket.emit('close', false);
    });
});
//# sourceMappingURL=proxy.js.map