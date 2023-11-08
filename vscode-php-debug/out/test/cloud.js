"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const cloud_1 = require("../cloud");
const net_1 = require("net");
const mocha_1 = require("mocha");
const iconv_lite_1 = require("iconv-lite");
const dbgp_1 = require("../dbgp");
(0, mocha_1.describe)('XdebugCloudConnection', () => {
    function _xmlCloud(cmd, success, msg = '', id = '') {
        let err = `<cloud${cmd} success="${success}">`;
        if (!success) {
            err += `<error id="${id}"><message>${msg}</message></error>`;
        }
        err += `</cloud${cmd}>`;
        return _xml(err);
    }
    function _xml(xml) {
        const data = (0, iconv_lite_1.encode)(`<?xml version="1.0" encoding="UTF-8"?>\n${xml}`, dbgp_1.ENCODING);
        return Buffer.concat([(0, iconv_lite_1.encode)(data.length.toString() + '\0', dbgp_1.ENCODING), data, (0, iconv_lite_1.encode)('\0', dbgp_1.ENCODING)]);
    }
    // <cloudstop xmlns="urn:debugger_protocol_v1" xmlns:xdebug="https://xdebug.org/dbgp/xdebug" success="1" userid="test"/>
    // <cloudinit xmlns="urn:debugger_protocol_v1" xmlns:xdebug="https://xdebug.org/dbgp/xdebug" success="1" userid="test"><accountInfo name="User Name" uid="test" active="true" remaining="100" made="103"><name>user.name@xdebug.org</name></accountInfo></cloudinit>
    // <cloudinit xmlns="urn:debugger_protocol_v1" xmlns:xdebug="https://xdebug.org/dbgp/xdebug" success="0" userid="" ><error id="CLOUD-ERR-03"><message>Cannot find account for &#39;test&#39;</message></error></cloudinit>
    // <init xmlns="urn:debugger_protocol_v1" xmlns:xdebug="https://xdebug.org/dbgp/xdebug" fileuri="file:///test.php" language="PHP" xdebug:language_version="8.1.2" protocol_version="1.0" xdebug:userid="test"><engine version="3.2.0-dev"><![CDATA[Xdebug]]></engine><author><![CDATA[Derick Rethans]]></author><url><![CDATA[https://xdebug.org]]></url><copyright><![CDATA[Copyright (c) 2002-2021 by Derick Rethans]]></copyright></init>
    let conn;
    let testSocket;
    (0, mocha_1.beforeEach)(() => {
        testSocket = new net_1.Socket();
        testSocket.connect = (...param) => {
            if (param[1] instanceof Function) {
                testSocket.once('connect', param[1]);
            }
            return testSocket;
        };
        testSocket.write = (...param) => {
            setTimeout(() => {
                if (param[1] instanceof Function) {
                    ;
                    param[1]();
                }
                testSocket.emit('write', param[0]);
            }, 1);
            return true;
        };
        testSocket.end = (...param) => {
            setTimeout(() => {
                if (param[0] instanceof Function) {
                    ;
                    param[0]();
                }
            }, 1);
            return testSocket;
        };
        conn = new cloud_1.XdebugCloudConnection('test', testSocket);
    });
    (0, mocha_1.it)('should connect and stop', (done) => {
        testSocket.on('write', (buffer) => {
            testSocket.emit('data', _xmlCloud('stop', 1));
        });
        conn.connectAndStop().then(done, done);
        testSocket.emit('connect');
    });
    (0, mocha_1.it)('should connect and stop and fail', (done) => {
        testSocket.on('write', (buffer) => {
            testSocket.emit('data', _xmlCloud('stop', 0, 'A client for test has not been previously registered', 'ERR-10'));
        });
        conn.connectAndStop().then(() => done(Error('should not have succeeded')), err => done());
        testSocket.emit('connect');
    });
    (0, mocha_1.it)('should connect with error', (done) => {
        conn.connect().then(() => done(Error('should not have succeeded')), err => done());
        testSocket.emit('error', new Error('connection error'));
    });
    (0, mocha_1.it)('should connect', (done) => {
        testSocket.on('write', (buffer) => {
            testSocket.emit('data', _xmlCloud('init', 1));
        });
        conn.connect().then(done, done);
        testSocket.emit('connect');
    });
    (0, mocha_1.it)('should connect and fail', (done) => {
        testSocket.on('write', (buffer) => {
            testSocket.emit('data', _xmlCloud('init', 0, 'Cannot find account for test', 'CLOUD-ERR-03'));
        });
        conn.connect().then(() => done(Error('should not have succeeded ')), err => done());
        testSocket.emit('connect');
    });
    (0, mocha_1.it)('should connect and init', (done) => {
        testSocket.on('write', (buffer) => {
            testSocket.emit('data', _xmlCloud('init', 1));
        });
        conn.connect().then(() => {
            // after connect, send init and wait for connection event
            testSocket.emit('data', _xml('<init xmlns="urn:debugger_protocol_v1" xmlns:xdebug="https://xdebug.org/dbgp/xdebug" fileuri="file:///test.php" language="PHP" xdebug:language_version="8.1.2" protocol_version="1.0" xdebug:userid="test"><engine version="3.2.0-dev"><![CDATA[Xdebug]]></engine><author><![CDATA[Derick Rethans]]></author><url><![CDATA[https://xdebug.org]]></url><copyright><![CDATA[Copyright (c) 2002-2021 by Derick Rethans]]></copyright></init>'));
        }, done);
        conn.on('connection', conn => done());
        testSocket.emit('connect');
    });
    (0, mocha_1.it)('should connect and init and stop', (done) => {
        testSocket.once('write', (buffer) => {
            testSocket.emit('data', _xmlCloud('init', 1));
        });
        conn.connect().then(() => {
            // after connect, send init and wait for connection event
            testSocket.emit('data', _xml('<init xmlns="urn:debugger_protocol_v1" xmlns:xdebug="https://xdebug.org/dbgp/xdebug" fileuri="file:///test.php" language="PHP" xdebug:language_version="8.1.2" protocol_version="1.0" xdebug:userid="test"><engine version="3.2.0-dev"><![CDATA[Xdebug]]></engine><author><![CDATA[Derick Rethans]]></author><url><![CDATA[https://xdebug.org]]></url><copyright><![CDATA[Copyright (c) 2002-2021 by Derick Rethans]]></copyright></init>'));
        }, done);
        conn.on('connection', conn => {
            testSocket.once('write', (buffer) => {
                testSocket.emit('data', _xml('<response xmlns="urn:debugger_protocol_v1" xmlns:xdebug="https://xdebug.org/dbgp/xdebug" command="stop" transaction_id="1" status="stopped" reason="ok"/>'));
            });
            conn.sendStopCommand().then(() => done(), done);
        });
        testSocket.emit('connect');
    });
});
//# sourceMappingURL=cloud.js.map