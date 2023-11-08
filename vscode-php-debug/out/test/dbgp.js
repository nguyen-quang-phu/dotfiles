"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
Object.defineProperty(exports, "__esModule", { value: true });
const dbgp_1 = require("../dbgp");
const net_1 = require("net");
const iconv = __importStar(require("iconv-lite"));
const chai_1 = require("chai");
const mocha_1 = require("mocha");
(0, mocha_1.describe)('DbgpConnection', () => {
    function makePacket(message) {
        const messageBuffer = iconv.encode(message, dbgp_1.ENCODING);
        return Buffer.concat([Buffer.from(`${messageBuffer.length}\0`), messageBuffer, Buffer.from('\0')]);
    }
    const message = '<?xml version="1.0" encoding="iso-8859-1"?>\n<init xmlns="urn:debugger_protocol_v1" xmlns:xdebug="http://xdebug.org/dbgp/xdebug">This is just a test</init>';
    const packet = makePacket(message);
    let socket;
    let conn;
    (0, mocha_1.beforeEach)(() => {
        socket = new net_1.Socket();
        conn = new dbgp_1.DbgpConnection(socket);
    });
    (0, mocha_1.it)('should parse a response in one data event', done => {
        conn.on('message', (document) => {
            chai_1.assert.equal(document.documentElement.nodeName, 'init');
            chai_1.assert.equal(document.documentElement.textContent, 'This is just a test');
            done();
        });
        conn.on('warning', done);
        conn.on('error', done);
        setTimeout(() => {
            socket.emit('data', packet);
        }, 100);
    });
    (0, mocha_1.it)('should parse a response over multiple data events', done => {
        conn.on('message', (document) => {
            chai_1.assert.equal(document.documentElement.nodeName, 'init');
            chai_1.assert.equal(document.documentElement.textContent, 'This is just a test');
            done();
        });
        conn.on('warning', done);
        conn.on('error', done);
        const part1 = packet.slice(0, 50);
        const part2 = packet.slice(50, 100);
        const part3 = packet.slice(100);
        setTimeout(() => {
            socket.emit('data', part1);
            setTimeout(() => {
                socket.emit('data', part2);
                setTimeout(() => {
                    socket.emit('data', part3);
                }, 100);
            }, 100);
        }, 100);
    });
    (0, mocha_1.it)('should parse multiple responses in one data event', done => {
        conn.once('message', (document) => {
            chai_1.assert.equal(document.documentElement.nodeName, 'init');
            chai_1.assert.equal(document.documentElement.textContent, 'This is just a test');
            conn.once('message', (document) => {
                chai_1.assert.equal(document.documentElement.nodeName, 'response');
                chai_1.assert.equal(document.documentElement.textContent, 'This is just another test');
                done();
            });
        });
        conn.on('warning', done);
        conn.on('error', done);
        const packet2 = makePacket('<?xml version="1.0" encoding="iso-8859-1"?>\n<response xmlns="urn:debugger_protocol_v1" xmlns:xdebug="http://xdebug.org/dbgp/xdebug">This is just another test</response>');
        setTimeout(() => {
            socket.emit('data', packet);
            setTimeout(() => {
                socket.emit('data', packet2);
            });
        }, 100);
    });
    (0, mocha_1.it)('should error on invalid XML', () => new Promise((resolve, reject) => {
        conn.on('error', (error) => {
            chai_1.assert.isDefined(error);
            chai_1.assert.instanceOf(error, Error);
            resolve();
        });
        conn.once('message', (document) => {
            reject(new Error('emitted message event'));
        });
        socket.emit('data', makePacket('<</<<><>>><?><>'));
    }));
});
//# sourceMappingURL=dbgp.js.map