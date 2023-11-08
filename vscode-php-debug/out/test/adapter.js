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
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const chai = __importStar(require("chai"));
const chai_as_promised_1 = __importDefault(require("chai-as-promised"));
const path = __importStar(require("path"));
const debugadapter_testsupport_1 = require("@vscode/debugadapter-testsupport");
const semver = __importStar(require("semver"));
const net = __importStar(require("net"));
const mocha_1 = require("mocha");
chai.use(chai_as_promised_1.default);
const assert = chai.assert;
(0, mocha_1.describe)('PHP Debug Adapter', () => {
    const TEST_PROJECT = path.normalize(__dirname + '/../../testproject');
    let client;
    (0, mocha_1.beforeEach)('start debug adapter', async () => {
        client = new debugadapter_testsupport_1.DebugClient('node', path.normalize(__dirname + '/../phpDebug'), 'php');
        client.defaultTimeout = 10000;
        await client.start(process.env['VSCODE_DEBUG_PORT'] ? parseInt(process.env['VSCODE_DEBUG_PORT']) : undefined);
    });
    (0, mocha_1.afterEach)('stop debug adapter', () => client.stop());
    (0, mocha_1.describe)('initialization', () => {
        (0, mocha_1.it)('should return supported features', async () => {
            const response = await client.initializeRequest();
            assert.equal(response.body.supportsConfigurationDoneRequest, true);
            assert.equal(response.body.supportsEvaluateForHovers, true);
            assert.equal(response.body.supportsConditionalBreakpoints, true);
            assert.equal(response.body.supportsFunctionBreakpoints, true);
        });
    });
    (0, mocha_1.describe)('launch as CLI', () => {
        const program = path.join(TEST_PROJECT, 'hello_world.php');
        (0, mocha_1.it)('should error on non-existing file', () => assert.isRejected(Promise.all([client.launch({ program: 'thisfiledoesnotexist.php' }), client.configurationSequence()])));
        (0, mocha_1.it)('should error on env without program', () => assert.isRejected(Promise.all([client.launch({ env: { some: 'key' } }), client.configurationSequence()])));
        (0, mocha_1.it)('should run program to the end', () => Promise.all([
            client.launch({ program }),
            client.configurationSequence(),
            client.waitForEvent('terminated'),
        ]));
        (0, mocha_1.it)('should stop on entry', async () => {
            const [event] = await Promise.all([
                client.waitForEvent('stopped'),
                client.launch({ program, stopOnEntry: true }),
                client.configurationSequence(),
            ]);
            assert.propertyVal(event.body, 'reason', 'entry');
        });
        (0, mocha_1.it)('should not stop if launched without debugging', () => Promise.all([
            client.launch({ program, stopOnEntry: true, noDebug: true }),
            client.configurationSequence(),
            client.waitForEvent('terminated'),
        ]));
    });
    (0, mocha_1.describe)('socket path listen', () => {
        const program = path.join(TEST_PROJECT, 'hello_world.php');
        (0, mocha_1.it)('should error on port and socketPath', () => assert.isRejected(Promise.all([client.launch({ port: 9003, hostname: 'unix:///test' }), client.configurationSequence()])));
        (process.platform === 'win32' ? mocha_1.it : mocha_1.it.skip)('should listen on windows pipe', async () => {
            await Promise.all([
                client.launch({ program, hostname: '\\\\?\\pipe\\test' }),
                client.configurationSequence(),
            ]);
            await client.disconnectRequest();
        });
        (process.platform === 'win32' ? mocha_1.it.skip : mocha_1.it)('should listen on unix pipe', async () => {
            await Promise.all([
                client.launch({
                    program,
                    hostname: 'unix:///tmp/test',
                    runtimeArgs: ['-dxdebug.client_host=unix:///tmp/text'],
                }),
                client.configurationSequence(),
                client.waitForEvent('terminated'),
            ]);
        });
    });
    (0, mocha_1.describe)('continuation commands', () => {
        const program = path.join(TEST_PROJECT, 'function.php');
        (0, mocha_1.it)('should handle run');
        (0, mocha_1.it)('should handle step_over');
        (0, mocha_1.it)('should handle step_in');
        (0, mocha_1.it)('should handle step_out');
        (0, mocha_1.it)('should error on pause request', () => assert.isRejected(client.pauseRequest({ threadId: 1 })));
        (0, mocha_1.it)('should handle disconnect', async () => {
            await Promise.all([client.launch({ program, stopOnEntry: true }), client.configurationSequence()]);
            await client.disconnectRequest();
        });
    });
    async function assertStoppedLocation(reason, path, line) {
        const event = (await client.waitForEvent('stopped'));
        assert.propertyVal(event.body, 'reason', reason);
        const threadId = event.body.threadId;
        const response = await client.stackTraceRequest({ threadId });
        const frame = response.body.stackFrames[0];
        let expectedPath = path;
        let actualPath = frame.source.path;
        if (process.platform === 'win32') {
            expectedPath = expectedPath.toLowerCase();
            actualPath = actualPath.toLowerCase();
        }
        assert.equal(actualPath, expectedPath, 'stopped location: path mismatch');
        assert.equal(frame.line, line, 'stopped location: line mismatch');
        return { threadId, frame };
    }
    (0, mocha_1.describe)('breakpoints', () => {
        const program = path.join(TEST_PROJECT, 'hello_world.php');
        async function waitForBreakpointUpdate(breakpoint) {
            while (true) {
                const event = (await client.waitForEvent('breakpoint'));
                if (event.body.breakpoint.id === breakpoint.id) {
                    Object.assign(breakpoint, event.body.breakpoint);
                    break;
                }
            }
        }
        (0, mocha_1.describe)('line breakpoints', () => {
            async function testBreakpointHit(program, line) {
                await client.launch({ program });
                const breakpoint = (await client.setBreakpointsRequest({
                    breakpoints: [{ line }],
                    source: { path: program },
                })).body.breakpoints[0];
                await client.configurationDoneRequest(), await waitForBreakpointUpdate(breakpoint);
                assert.isTrue(breakpoint.verified, 'breakpoint verification mismatch: verified');
                assert.equal(breakpoint.line, line, 'breakpoint verification mismatch: line');
                await assertStoppedLocation('breakpoint', program, line);
            }
            (0, mocha_1.it)('should stop on a breakpoint', () => testBreakpointHit(program, 4));
            (0, mocha_1.it)('should stop on a breakpoint in file with spaces in its name', () => testBreakpointHit(path.join(TEST_PROJECT, 'folder with spaces', 'file with spaces.php'), 4));
            (0, mocha_1.it)('should stop on a breakpoint identical to the entrypoint', () => testBreakpointHit(program, 3));
            (0, mocha_1.it)('should support removing a breakpoint', async () => {
                await client.launch({ program });
                // set two breakpoints
                let breakpoints = (await client.setBreakpointsRequest({
                    breakpoints: [{ line: 3 }, { line: 5 }],
                    source: { path: program },
                })).body.breakpoints;
                await client.configurationDoneRequest(), await waitForBreakpointUpdate(breakpoints[0]);
                await waitForBreakpointUpdate(breakpoints[1]);
                assert.lengthOf(breakpoints, 2);
                assert.isTrue(breakpoints[0].verified, 'breakpoint verification mismatch: verified');
                assert.equal(breakpoints[0].line, 3, 'breakpoint verification mismatch: line');
                assert.isTrue(breakpoints[1].verified, 'breakpoint verification mismatch: verified');
                assert.equal(breakpoints[1].line, 5, 'breakpoint verification mismatch: line');
                // stop at first
                const [{ threadId }] = await Promise.all([
                    assertStoppedLocation('breakpoint', program, 3),
                    client.configurationDoneRequest(),
                ]);
                // remove second
                breakpoints = (await client.setBreakpointsRequest({
                    breakpoints: [{ line: 3 }],
                    source: { path: program },
                })).body.breakpoints;
                await waitForBreakpointUpdate(breakpoints[0]);
                assert.lengthOf(breakpoints, 1);
                assert.isTrue(breakpoints[0].verified, 'breakpoint verification mismatch: verified');
                assert.equal(breakpoints[0].line, 3, 'breakpoint verification mismatch: line');
                // should run to end
                await Promise.all([client.waitForEvent('terminated'), client.continueRequest({ threadId })]);
            });
        });
        (0, mocha_1.describe)('exception breakpoints', () => {
            const program = path.join(TEST_PROJECT, 'error.php');
            (0, mocha_1.it)('should not break on anything if the file matches the ignore pattern', async () => {
                await client.launch({ program, ignore: ['**/*.*'] });
                await client.setExceptionBreakpointsRequest({ filters: ['*'] });
                await Promise.all([client.configurationDoneRequest(), client.waitForEvent('terminated')]);
            });
            (0, mocha_1.it)('should not break on exception that matches the ignore pattern', async () => {
                const program = path.join(TEST_PROJECT, 'ignore_exception.php');
                await client.launch({ program, ignoreExceptions: ['NS1\\NS2\\IgnoreException'] });
                await client.setExceptionBreakpointsRequest({ filters: ['*'] });
                await Promise.all([client.configurationDoneRequest(), client.waitForEvent('terminated')]);
            });
            (0, mocha_1.it)('should support stopping only on a notice', async () => {
                await client.launch({ program });
                await client.setExceptionBreakpointsRequest({ filters: ['Notice'] });
                const [, { threadId }] = await Promise.all([
                    client.configurationDoneRequest(),
                    assertStoppedLocation('exception', program, 6),
                ]);
                await Promise.all([client.continueRequest({ threadId }), client.waitForEvent('terminated')]);
            });
            (0, mocha_1.it)('should support stopping only on a warning', async () => {
                await client.launch({ program });
                await client.setExceptionBreakpointsRequest({ filters: ['Warning'] });
                const [{ threadId }] = await Promise.all([
                    assertStoppedLocation('exception', program, 9),
                    client.configurationDoneRequest(),
                ]);
                await Promise.all([client.continueRequest({ threadId }), client.waitForEvent('terminated')]);
            });
            (0, mocha_1.it)('should support stopping only on an error');
            (0, mocha_1.it)('should support stopping only on an exception', async () => {
                await client.launch({ program });
                await client.setExceptionBreakpointsRequest({ filters: ['Exception'] });
                const [, { threadId }] = await Promise.all([
                    client.configurationDoneRequest(),
                    assertStoppedLocation('exception', program, 12),
                ]);
                await Promise.all([client.continueRequest({ threadId }), client.waitForEvent('terminated')]);
            });
            // support for stopping on "*" was added in 2.3.0
            if (!process.env['XDEBUG_VERSION'] || semver.gte(process.env['XDEBUG_VERSION'], '2.3.0')) {
                (0, mocha_1.it)('should support stopping on everything', async () => {
                    await client.launch({ program });
                    await client.setExceptionBreakpointsRequest({ filters: ['*'] });
                    // Notice
                    const [, { threadId }] = await Promise.all([
                        client.configurationDoneRequest(),
                        assertStoppedLocation('exception', program, 6),
                    ]);
                    // Warning
                    await Promise.all([
                        client.continueRequest({ threadId }),
                        assertStoppedLocation('exception', program, 9),
                    ]);
                    // Exception
                    await Promise.all([
                        client.continueRequest({ threadId }),
                        assertStoppedLocation('exception', program, 12),
                    ]);
                    // Fatal error: uncaught exception
                    await Promise.all([
                        client.continueRequest({ threadId }),
                        assertStoppedLocation('exception', program, 12),
                    ]);
                    await Promise.all([client.continueRequest({ threadId }), client.waitForEvent('terminated')]);
                });
            }
            mocha_1.it.skip('should report the error in a virtual error scope', async () => {
                await client.launch({ program });
                await client.setExceptionBreakpointsRequest({ filters: ['Notice', 'Warning', 'Exception'] });
                const [{ body: { threadId }, },] = await Promise.all([
                    client.waitForEvent('stopped'),
                    client.configurationDoneRequest(),
                ]);
                async function getErrorScope() {
                    const frameId = (await client.stackTraceRequest({ threadId: threadId })).body.stackFrames[0].id;
                    const errorScope = (await client.scopesRequest({ frameId })).body.scopes[0];
                    const variables = (await client.variablesRequest({
                        variablesReference: errorScope.variablesReference,
                    })).body.variables;
                    const errorInfo = { name: errorScope.name };
                    const type = variables.find(variable => variable.name === 'type');
                    if (type) {
                        errorInfo.type = type.value;
                    }
                    const message = variables.find(variable => variable.name === 'message');
                    if (message) {
                        errorInfo.message = message.value;
                    }
                    const code = variables.find(variable => variable.name === 'code');
                    if (code) {
                        errorInfo.code = code.value;
                    }
                    return errorInfo;
                }
                let expectedErrorScope = {
                    name: 'Notice',
                    type: 'Notice',
                    message: '"Undefined index: undefined_index"',
                };
                if (!process.env['XDEBUG_VERSION'] || semver.gte(process.env['XDEBUG_VERSION'], '2.3.0')) {
                    expectedErrorScope.code = '8';
                }
                assert.deepEqual(await getErrorScope(), expectedErrorScope);
                await Promise.all([client.continueRequest({ threadId: threadId }), client.waitForEvent('stopped')]);
                expectedErrorScope = {
                    name: 'Warning',
                    type: 'Warning',
                    message: '"Illegal offset type"',
                };
                if (!process.env['XDEBUG_VERSION'] || semver.gte(process.env['XDEBUG_VERSION'], '2.3.0')) {
                    expectedErrorScope.code = '2';
                }
                assert.deepEqual(await getErrorScope(), expectedErrorScope);
                await Promise.all([client.continueRequest({ threadId: threadId }), client.waitForEvent('stopped')]);
                assert.deepEqual(await getErrorScope(), {
                    name: 'Exception',
                    type: 'Exception',
                    message: '"this is an exception"',
                });
                await Promise.all([client.continueRequest({ threadId: threadId }), client.waitForEvent('stopped')]);
                const fatalErrorScope = await getErrorScope();
                assert.propertyVal(fatalErrorScope, 'name', 'Fatal error');
                assert.propertyVal(fatalErrorScope, 'type', 'Fatal error');
                assert.match(fatalErrorScope.message, /^"Uncaught Exception/i);
                assert.match(fatalErrorScope.message, /this is an exception/);
                assert.match(fatalErrorScope.message, /"$/);
            });
        });
        (0, mocha_1.describe)('conditional breakpoints', () => {
            const program = path.join(TEST_PROJECT, 'variables.php');
            (0, mocha_1.it)('should stop on a conditional breakpoint when condition is true', async () => {
                await client.launch({ program });
                const bp = (await client.setBreakpointsRequest({
                    breakpoints: [{ line: 10, condition: '$anInt === 123' }],
                    source: { path: program },
                })).body.breakpoints[0];
                await client.configurationDoneRequest();
                await waitForBreakpointUpdate(bp);
                assert.equal(bp.verified, true, 'breakpoint verification mismatch: verified');
                assert.equal(bp.line, 10, 'breakpoint verification mismatch: line');
                const { frame } = await assertStoppedLocation('breakpoint', program, 10);
                const result = (await client.evaluateRequest({
                    context: 'watch',
                    frameId: frame.id,
                    expression: '$anInt',
                })).body.result;
                assert.equal(result, '123');
            });
            (0, mocha_1.it)('should not stop on a conditional breakpoint when condition is false', async () => {
                await client.launch({ program });
                const bp = (await client.setBreakpointsRequest({
                    breakpoints: [{ line: 10, condition: '$anInt !== 123' }],
                    source: { path: program },
                })).body.breakpoints[0];
                await client.configurationDoneRequest();
                await waitForBreakpointUpdate(bp);
                assert.equal(bp.verified, true, 'breakpoint verification mismatch: verified');
                assert.equal(bp.line, 10, 'breakpoint verification mismatch: line');
                await client.waitForEvent('terminated');
            });
        });
        (0, mocha_1.describe)('function breakpoints', () => {
            const program = path.join(TEST_PROJECT, 'function.php');
            (0, mocha_1.it)('should stop on a function breakpoint', async () => {
                await client.launch({ program });
                const breakpoint = (await client.setFunctionBreakpointsRequest({
                    breakpoints: [{ name: 'a_function' }],
                })).body.breakpoints[0];
                await client.configurationDoneRequest();
                await waitForBreakpointUpdate(breakpoint);
                assert.strictEqual(breakpoint.verified, true);
                await assertStoppedLocation('breakpoint', program, 5);
            });
        });
        (0, mocha_1.describe)('hit count breakpoints', () => {
            const program = path.join(TEST_PROJECT, 'hit.php');
            async function testHits(condition, hits, verified = true) {
                await client.launch({ program });
                const breakpoint = (await client.setBreakpointsRequest({
                    breakpoints: [{ line: 4, hitCondition: condition }],
                    source: { path: program },
                })).body.breakpoints[0];
                await client.configurationDoneRequest();
                if (verified) {
                    await waitForBreakpointUpdate(breakpoint);
                }
                else {
                    assert.strictEqual(breakpoint.message, 'Invalid hit condition. Specify a number, optionally prefixed with one of the operators >= (default), == or %');
                }
                assert.strictEqual(breakpoint.verified, verified);
                for (const hitVal of hits) {
                    const { threadId, frame } = await assertStoppedLocation('breakpoint', program, 4);
                    const result = (await client.evaluateRequest({
                        context: 'watch',
                        frameId: frame.id,
                        expression: '$i',
                    })).body.result;
                    assert.equal(result, hitVal);
                    await client.continueRequest({ threadId });
                }
                await client.waitForEvent('terminated');
            }
            async function testFunctionHits(condition, hits, verified = true) {
                await client.launch({ program });
                const breakpoint = (await client.setFunctionBreakpointsRequest({
                    breakpoints: [{ name: 'f1', hitCondition: condition }],
                })).body.breakpoints[0];
                await client.configurationDoneRequest();
                if (verified) {
                    await waitForBreakpointUpdate(breakpoint);
                }
                else {
                    assert.strictEqual(breakpoint.message, 'Invalid hit condition. Specify a number, optionally prefixed with one of the operators >= (default), == or %');
                }
                assert.strictEqual(breakpoint.verified, verified);
                for (const hitVal of hits) {
                    const { threadId, frame } = await assertStoppedLocation('breakpoint', program, 9);
                    const result = (await client.evaluateRequest({
                        context: 'watch',
                        frameId: frame.id,
                        expression: '$i',
                    })).body.result;
                    assert.equal(result, hitVal);
                    await client.continueRequest({ threadId });
                }
                await client.waitForEvent('terminated');
            }
            (0, mocha_1.describe)('hit count line breakpoints', () => {
                (0, mocha_1.it)('should not stop for broken condition "a"', async () => {
                    await testHits('a', [], false);
                });
                (0, mocha_1.it)('should stop when the hit count is gte than 3 with condition "3"', async () => {
                    await testHits('3', ['3']);
                });
                (0, mocha_1.it)('should stop when the hit count is gte than 3 with condition ">=3"', async () => {
                    await testHits('>=3', ['3', '4', '5']);
                });
                (0, mocha_1.it)('should stop when the hit count is equal to 3 with condition "==3"', async () => {
                    await testHits('==3', ['3']);
                });
                (0, mocha_1.it)('should stop on every 2nd hit with condition "%2"', async () => {
                    await testHits('%2', ['2', '4']);
                });
            });
            (0, mocha_1.describe)('hit count function breakpoints', () => {
                (0, mocha_1.it)('should not stop for broken condition "a"', async () => {
                    await testFunctionHits('a', [], false);
                });
                (0, mocha_1.it)('should stop when the hit count is gte than 3 with condition "3"', async () => {
                    await testFunctionHits('3', ['3']);
                });
                (0, mocha_1.it)('should stop when the hit count is gte than 3 with condition ">=3"', async () => {
                    await testFunctionHits('>=3', ['3', '4', '5']);
                });
                (0, mocha_1.it)('should stop when the hit count is equal to 3 with condition "==3"', async () => {
                    await testFunctionHits('==3', ['3']);
                });
                (0, mocha_1.it)('should stop on every 2nd hit with condition "%2"', async () => {
                    await testFunctionHits('%2', ['2', '4']);
                });
            });
        });
    });
    (0, mocha_1.describe)('variables', () => {
        const program = path.join(TEST_PROJECT, 'variables.php');
        let localScope;
        let superglobalsScope;
        let constantsScope;
        (0, mocha_1.beforeEach)(async () => {
            await client.launch({
                program,
                xdebugSettings: {
                    max_data: 10000,
                    max_children: 100,
                },
            });
            await client.setBreakpointsRequest({ source: { path: program }, breakpoints: [{ line: 19 }] });
            const [, event] = await Promise.all([
                client.configurationDoneRequest(),
                client.waitForEvent('stopped'),
            ]);
            const stackFrame = (await client.stackTraceRequest({ threadId: event.body.threadId })).body.stackFrames[0];
            const scopes = (await client.scopesRequest({ frameId: stackFrame.id })).body.scopes;
            localScope = scopes.find(scope => scope.name === 'Locals');
            superglobalsScope = scopes.find(scope => scope.name === 'Superglobals');
            constantsScope = scopes.find(scope => scope.name === 'User defined constants'); // Xdebug >2.3 only
        });
        (0, mocha_1.it)('should report scopes correctly', () => {
            assert.isDefined(localScope, 'Locals');
            assert.isDefined(superglobalsScope, 'Superglobals');
            // support for user defined constants was added in 2.3.0
            if (!process.env['XDEBUG_VERSION'] || semver.gte(process.env['XDEBUG_VERSION'], '2.3.0')) {
                assert.isDefined(constantsScope, 'User defined constants');
            }
        });
        (0, mocha_1.describe)('local variables', () => {
            let localVariables;
            (0, mocha_1.beforeEach)(async () => {
                localVariables = (await client.variablesRequest({ variablesReference: localScope.variablesReference }))
                    .body.variables;
            });
            (0, mocha_1.it)('should report local scalar variables correctly', () => {
                // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
                const variables = Object.create(null);
                for (const variable of localVariables) {
                    variables[variable.name] = variable.value;
                }
                assert.propertyVal(variables, '$aBoolean', 'true');
                assert.propertyVal(variables, '$aFloat', '1.23');
                assert.propertyVal(variables, '$aString', '"123"');
                assert.propertyVal(variables, '$anEmptyString', '""');
                assert.propertyVal(variables, '$aVeryLongString', '"' + 'lol'.repeat(1000) + '"');
                assert.propertyVal(variables, '$anInt', '123');
                assert.propertyVal(variables, '$nullValue', 'null');
                assert.propertyVal(variables, '$variableThatsNotSet', 'uninitialized');
            });
            (0, mocha_1.it)('should report arrays correctly', async () => {
                const anArray = localVariables.find(variable => variable.name === '$anArray');
                assert.isDefined(anArray);
                assert.propertyVal(anArray, 'value', 'array(3)');
                assert.property(anArray, 'variablesReference');
                const items = (await client.variablesRequest({ variablesReference: anArray.variablesReference })).body
                    .variables;
                assert.lengthOf(items, 3);
                assert.propertyVal(items[0], 'name', '0');
                assert.propertyVal(items[0], 'value', '1');
                assert.propertyVal(items[1], 'name', 'test');
                assert.propertyVal(items[1], 'value', '2');
                assert.propertyVal(items[2], 'name', 'test2');
                assert.propertyVal(items[2], 'value', 'array(1)');
                const test2Items = (await client.variablesRequest({ variablesReference: items[2].variablesReference }))
                    .body.variables;
                assert.lengthOf(test2Items, 1);
                assert.propertyVal(test2Items[0], 'name', 't');
                assert.propertyVal(test2Items[0], 'value', '123');
            });
            (0, mocha_1.it)('should report large arrays correctly', async () => {
                const aLargeArray = localVariables.find(variable => variable.name === '$aLargeArray');
                assert.isDefined(aLargeArray);
                assert.propertyVal(aLargeArray, 'value', 'array(100)');
                assert.property(aLargeArray, 'variablesReference');
                const largeArrayItems = (await client.variablesRequest({
                    variablesReference: aLargeArray.variablesReference,
                })).body.variables;
                assert.lengthOf(largeArrayItems, 100);
                assert.propertyVal(largeArrayItems[0], 'name', '0');
                assert.propertyVal(largeArrayItems[0], 'value', '"test"');
                assert.propertyVal(largeArrayItems[99], 'name', '99');
                assert.propertyVal(largeArrayItems[99], 'value', '"test"');
            });
            (0, mocha_1.it)('should report keys with spaces correctly', async () => {
                const arrayWithSpaceKey = localVariables.find(variable => variable.name === '$arrayWithSpaceKey');
                assert.isDefined(arrayWithSpaceKey);
                assert.propertyVal(arrayWithSpaceKey, 'value', 'array(1)');
                assert.property(arrayWithSpaceKey, 'variablesReference');
                const arrayWithSpaceKeyItems = (await client.variablesRequest({
                    variablesReference: arrayWithSpaceKey.variablesReference,
                })).body.variables;
                assert.lengthOf(arrayWithSpaceKeyItems, 1);
                assert.propertyVal(arrayWithSpaceKeyItems[0], 'name', 'space key');
                assert.propertyVal(arrayWithSpaceKeyItems[0], 'value', '1');
            });
            (0, mocha_1.it)('should report values with null correctly', async () => {
                const arrayExtended = localVariables.find(variable => variable.name === '$arrayExtended');
                assert.isDefined(arrayExtended);
                assert.propertyVal(arrayExtended, 'value', 'array(1)');
                assert.property(arrayExtended, 'variablesReference');
                const arrayExtendedItems = (await client.variablesRequest({
                    variablesReference: arrayExtended.variablesReference,
                })).body.variables;
                assert.lengthOf(arrayExtendedItems, 1);
                assert.propertyVal(arrayExtendedItems[0], 'name', 'a\0b');
                assert.propertyVal(arrayExtendedItems[0], 'value', '"c\0d"');
            });
            (0, mocha_1.it)('should report values with unicode correctly', async () => {
                const arrayExtended = localVariables.find(variable => variable.name === '$arrayExtended2');
                assert.isDefined(arrayExtended);
                assert.propertyVal(arrayExtended, 'value', 'array(2)');
                assert.property(arrayExtended, 'variablesReference');
                const arrayExtendedItems = (await client.variablesRequest({
                    variablesReference: arrayExtended.variablesReference,
                })).body.variables;
                assert.lengthOf(arrayExtendedItems, 2);
                assert.propertyVal(arrayExtendedItems[0], 'name', 'Приветствие');
                assert.propertyVal(arrayExtendedItems[0], 'value', '"КУ-КУ"');
                assert.propertyVal(arrayExtendedItems[1], 'name', 'Прощание');
                assert.propertyVal(arrayExtendedItems[1], 'value', '"Па-Ка"');
            });
        });
        // support for user defined constants was added in 2.3.0
        if (!process.env['XDEBUG_VERSION'] || semver.gte(process.env['XDEBUG_VERSION'], '2.3.0')) {
            (0, mocha_1.it)('should report user defined constants correctly', async () => {
                const constants = (await client.variablesRequest({
                    variablesReference: constantsScope.variablesReference,
                })).body.variables;
                assert.lengthOf(constants, 1);
                assert.propertyVal(constants[0], 'name', 'TEST_CONSTANT');
                assert.propertyVal(constants[0], 'value', '123');
            });
        }
    });
    (0, mocha_1.describe)('setVariables', () => {
        const program = path.join(TEST_PROJECT, 'variables.php');
        let localScope;
        let localVariables;
        // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
        let variables = Object.create(null);
        (0, mocha_1.beforeEach)(async () => {
            await client.launch({ program });
            await client.setBreakpointsRequest({ source: { path: program }, breakpoints: [{ line: 19 }] });
            const [, event] = await Promise.all([
                client.configurationDoneRequest(),
                client.waitForEvent('stopped'),
            ]);
            const stackFrame = (await client.stackTraceRequest({ threadId: event.body.threadId })).body.stackFrames[0];
            const scopes = (await client.scopesRequest({ frameId: stackFrame.id })).body.scopes;
            localScope = scopes.find(scope => scope.name === 'Locals');
        });
        async function getLocals() {
            localVariables = (await client.variablesRequest({ variablesReference: localScope.variablesReference }))
                .body.variables;
            // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
            variables = Object.create(null);
            for (const variable of localVariables) {
                variables[variable.name] = variable.value;
            }
        }
        (0, mocha_1.it)('should set the value of an integer', async () => {
            await getLocals();
            assert.propertyVal(variables, '$anInt', '123');
            await client.setVariableRequest({
                variablesReference: localScope.variablesReference,
                name: '$anInt',
                value: '100',
            });
            await getLocals();
            assert.propertyVal(variables, '$anInt', '100');
        });
        (0, mocha_1.it)('should set the value of a string', async () => {
            await getLocals();
            assert.propertyVal(variables, '$aString', '"123"');
            await client.setVariableRequest({
                variablesReference: localScope.variablesReference,
                name: '$aString',
                value: '"aaaa"',
            });
            await getLocals();
            assert.propertyVal(variables, '$aString', '"aaaa"');
        });
        (0, mocha_1.it)('should set the value of an nested property', async () => {
            await getLocals();
            let anArray = localVariables.find(variable => variable.name === '$anArray');
            assert.propertyVal(anArray, 'value', 'array(3)');
            await client.setVariableRequest({
                variablesReference: localScope.variablesReference,
                name: '$anArray',
                value: 'array(1,2)',
            });
            await getLocals();
            anArray = localVariables.find(variable => variable.name === '$anArray');
            assert.propertyVal(anArray, 'value', 'array(2)');
        });
    });
    (0, mocha_1.describe)('virtual sources', () => {
        (0, mocha_1.it)('should break on an exception inside eval code');
        (0, mocha_1.it)('should return the eval code with a source request');
    });
    (0, mocha_1.describe)('parallel requests', () => {
        (0, mocha_1.it)('should report multiple requests as threads');
    });
    (0, mocha_1.describe)('evaluation', () => {
        (0, mocha_1.it)('should return the eval result', async () => {
            const program = path.join(TEST_PROJECT, 'variables.php');
            await client.launch({
                program,
            });
            await client.setBreakpointsRequest({ source: { path: program }, breakpoints: [{ line: 19 }] });
            await client.configurationDoneRequest();
            const { frame } = await assertStoppedLocation('breakpoint', program, 19);
            const response = (await client.evaluateRequest({
                context: 'hover',
                frameId: frame.id,
                expression: '$anInt',
            })).body;
            assert.equal(response.result, '123');
            assert.equal(response.variablesReference, 0);
        });
        (0, mocha_1.it)('should return variable references for structured results', async () => {
            const program = path.join(TEST_PROJECT, 'variables.php');
            await client.launch({
                program,
            });
            await client.setBreakpointsRequest({ source: { path: program }, breakpoints: [{ line: 19 }] });
            await client.configurationDoneRequest();
            const { frame } = await assertStoppedLocation('breakpoint', program, 19);
            const response = (await client.evaluateRequest({
                context: 'hover',
                frameId: frame.id,
                expression: '$anArray',
            })).body;
            assert.equal(response.result, 'array(3)');
            assert.notEqual(response.variablesReference, 0);
            const vars = await client.variablesRequest({ variablesReference: response.variablesReference });
            assert.deepEqual(vars.body.variables[0].name, '0');
            assert.deepEqual(vars.body.variables[0].value, '1');
        });
    });
    mocha_1.describe.skip('output events', () => {
        const program = path.join(TEST_PROJECT, 'output.php');
        (0, mocha_1.it)('stdout and stderr events should be complete and in correct order', async () => {
            await Promise.all([client.launch({ program }), client.configurationSequence()]);
            await client.assertOutput('stdout', 'stdout output 1\nstdout output 2');
            await client.assertOutput('stderr', 'stderr output 1\nstderr output 2');
        });
    });
    (0, mocha_1.describe)('special adapter tests', () => {
        (0, mocha_1.it)('max connections', async () => {
            await Promise.all([client.launch({ maxConnections: 1, log: true }), client.configurationSequence()]);
            const s1 = net.createConnection({ port: 9003 });
            const o1 = await client.assertOutput('console', 'new connection');
            assert.match(
            // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
            o1.body.output, /^new connection \d+ from/);
            net.createConnection({ port: 9003 });
            const o = await client.waitForEvent('output');
            assert.match(
            // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
            o.body.output, /^new connection from .* - dropping due to max connection limit/, 'Second connection does not generate proper error output');
            await new Promise(resolve => {
                s1.on('close', resolve);
                s1.end();
            });
        });
        (0, mocha_1.it)('stack depth', async () => {
            const program = path.join(TEST_PROJECT, 'stack.php');
            await Promise.all([client.launch({ program }), client.configurationSequence()]);
            const event = (await client.waitForEvent('stopped'));
            assert.propertyVal(event.body, 'reason', 'breakpoint');
            const threadId = event.body.threadId;
            const response = await client.stackTraceRequest({ threadId, levels: 1 });
            assert.lengthOf(response.body.stackFrames, 1);
            assert.equal(response.body.totalFrames, 4);
            assert.equal(response.body.stackFrames[0].name, 'depth3');
            const response2 = await client.stackTraceRequest({ threadId, startFrame: 1 /* , levels: 3*/ });
            assert.lengthOf(response2.body.stackFrames, 3);
            assert.equal(response2.body.totalFrames, 4);
            assert.equal(response2.body.stackFrames[0].name, 'depth2');
            assert.equal(response2.body.stackFrames[1].name, 'depth1');
            assert.equal(response2.body.stackFrames[2].name, '{main}');
        });
        (0, mocha_1.it)('skip entry paths', async () => {
            const program = path.join(TEST_PROJECT, 'variables.php');
            await client.launch({ program, skipEntryPaths: ['**/variables.php'] });
            await client.setBreakpointsRequest({ source: { path: program }, breakpoints: [{ line: 19 }] });
            await client.configurationDoneRequest();
            await client.assertOutput('console', 'skipping entry point');
        });
    });
});
//# sourceMappingURL=adapter.js.map