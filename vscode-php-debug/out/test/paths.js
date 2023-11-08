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
const paths_1 = require("../paths");
const assert = __importStar(require("assert"));
const mocha_1 = require("mocha");
(0, mocha_1.describe)('paths', () => {
    (0, mocha_1.describe)('isSameUri', () => {
        (0, mocha_1.it)('should compare to URIs', () => {
            assert.strictEqual((0, paths_1.isSameUri)('file:///var/www/test.php', 'file:///var/www/test.php'), true);
            assert.strictEqual((0, paths_1.isSameUri)('file:///var/www/test.php', 'file:///var/www/test2.php'), false);
        });
        (0, mocha_1.it)('should compare windows paths case-insensitive', () => {
            assert.strictEqual((0, paths_1.isSameUri)('file:///C:/Program%20Files/Apache/2.4/htdocs/test.php', 'file:///c:/Program%20Files/Apache/2.4/htdocs/test.php'), true);
            assert.strictEqual((0, paths_1.isSameUri)('file:///C:/Program%20Files/Apache/2.4/htdocs/test.php', 'file:///C:/Program%20Files/Apache/2.4/htdocs/test2.php'), false);
        });
    });
    (0, mocha_1.describe)('convertClientPathToDebugger', () => {
        (0, mocha_1.describe)('without source mapping', () => {
            (0, mocha_1.it)('should convert a windows path to a URI', () => {
                assert.equal((0, paths_1.convertClientPathToDebugger)('C:\\Users\\felix\\test.php'), 'file:///C:/Users/felix/test.php');
            });
            (0, mocha_1.it)('should convert a unix path to a URI', () => {
                assert.equal((0, paths_1.convertClientPathToDebugger)('/home/felix/test.php'), 'file:///home/felix/test.php');
            });
        });
        (0, mocha_1.describe)('with source mapping', () => {
            // unix to unix
            (0, mocha_1.it)('should convert a unix path to a unix URI', () => {
                // site
                assert.equal((0, paths_1.convertClientPathToDebugger)('/home/felix/mysite/site.php', {
                    '/var/www': '/home/felix/mysite',
                    '/app': '/home/felix/mysource',
                }), 'file:///var/www/site.php');
                // source
                assert.equal((0, paths_1.convertClientPathToDebugger)('/home/felix/mysource/source.php', {
                    '/var/www': '/home/felix/mysite',
                    '/app': '/home/felix/mysource',
                }), 'file:///app/source.php');
                // longest prefix matching for server paths
                assert.strictEqual((0, paths_1.convertClientPathToDebugger)('/home/felix/mysource/subdir/source.php', {
                    '/var/www': '/home/felix/mysite',
                    '/app/subdir1': '/home/felix/mysource/subdir',
                    '/app': '/home/felix/mysource',
                }), 'file:///app/subdir1/source.php');
            });
            // unix to windows
            (0, mocha_1.it)('should convert a unix path to a windows URI', () => {
                // site
                assert.equal((0, paths_1.convertClientPathToDebugger)('/home/felix/mysite/site.php', {
                    'C:\\Program Files\\Apache\\2.4\\htdocs': '/home/felix/mysite',
                    'C:\\Program Files\\MySource': '/home/felix/mysource',
                }), 'file:///C:/Program%20Files/Apache/2.4/htdocs/site.php');
                // source
                assert.equal((0, paths_1.convertClientPathToDebugger)('/home/felix/mysource/source.php', {
                    'C:\\Program Files\\Apache\\2.4\\htdocs': '/home/felix/mysite',
                    'C:\\Program Files\\MySource': '/home/felix/mysource',
                }), 'file:///C:/Program%20Files/MySource/source.php');
            });
            // windows to unix
            (0, mocha_1.it)('should convert a windows path to a unix URI', () => {
                // site
                assert.equal((0, paths_1.convertClientPathToDebugger)('C:\\Users\\felix\\mysite\\site.php', {
                    '/var/www': 'C:\\Users\\felix\\mysite',
                    '/app': 'C:\\Users\\felix\\mysource',
                }), 'file:///var/www/site.php');
                // source
                assert.equal((0, paths_1.convertClientPathToDebugger)('C:\\Users\\felix\\mysource\\source.php', {
                    '/var/www': 'C:\\Users\\felix\\mysite',
                    '/app': 'C:\\Users\\felix\\mysource',
                }), 'file:///app/source.php');
                // only driv eletter
                assert.equal((0, paths_1.convertClientPathToDebugger)('C:\\source.php', {
                    '/var/www': 'C:',
                }), 'file:///var/www/source.php');
                // only driv eletter
                assert.equal((0, paths_1.convertClientPathToDebugger)('C:\\app\\source.php', {
                    '/': 'C:',
                }), 'file:///app/source.php');
                // drive letter with slash
                assert.equal((0, paths_1.convertClientPathToDebugger)('C:\\app\\source.php', {
                    '/var/www': 'C:/',
                }), 'file:///var/www/app/source.php');
                // drive letter with slash
                assert.equal((0, paths_1.convertClientPathToDebugger)('C:\\app\\source.php', {
                    '/': 'C:/',
                }), 'file:///app/source.php');
            });
            (0, mocha_1.it)('should convert a windows path with inconsistent casing to a unix URI', () => {
                const localSourceRoot = 'C:\\Users\\felix\\myproject';
                const serverSourceRoot = '/var/www';
                assert.equal((0, paths_1.convertClientPathToDebugger)('c:\\Users\\felix\\myproject\\test.php', {
                    [serverSourceRoot]: localSourceRoot,
                }), 'file:///var/www/test.php');
            });
            // windows to windows
            (0, mocha_1.it)('should convert a windows path to a windows URI', () => {
                // site
                assert.equal((0, paths_1.convertClientPathToDebugger)('C:\\Users\\felix\\mysite\\site.php', {
                    'C:\\Program Files\\Apache\\2.4\\htdocs': 'C:\\Users\\felix\\mysite',
                    'C:\\Program Files\\MySource': 'C:\\Users\\felix\\mysource',
                }), 'file:///C:/Program%20Files/Apache/2.4/htdocs/site.php');
                // source
                assert.equal((0, paths_1.convertClientPathToDebugger)('C:\\Users\\felix\\mysource\\source.php', {
                    'C:\\Program Files\\Apache\\2.4\\htdocs': 'C:\\Users\\felix\\mysite',
                    'C:\\Program Files\\MySource': 'C:\\Users\\felix\\mysource',
                }), 'file:///C:/Program%20Files/MySource/source.php');
            });
        });
        (0, mocha_1.describe)('exact file mappings', () => {
            (0, mocha_1.it)('should map exact unix path', () => {
                assert.equal((0, paths_1.convertClientPathToDebugger)('/var/path/file.php', {
                    '/var/path2/file2.php': '/var/path/file.php',
                }), 'file:///var/path2/file2.php');
            });
            (0, mocha_1.it)('should map exact windows path', () => {
                assert.equal((0, paths_1.convertClientPathToDebugger)('C:\\var\\path\\file.php', {
                    'C:\\var\\path2\\file2.php': 'C:\\var\\path\\file.php',
                }), 'file:///C:/var/path2/file2.php');
            });
        });
        (0, mocha_1.describe)('relative paths', () => {
            (0, mocha_1.it)('should resolve relative path posix', () => {
                assert.equal((0, paths_1.convertClientPathToDebugger)('/var/www/foo/../bar'), 'file:///var/www/bar');
            });
            (0, mocha_1.it)('should resolve relative path maps posix', () => {
                assert.equal((0, paths_1.convertClientPathToDebugger)('/work/foo/test.php', {
                    '/var/www/html/bar': '/work/project/folder/../../foo',
                }), 'file:///var/www/html/bar/test.php');
            });
            (0, mocha_1.it)('should resolve relative path win32', () => {
                assert.equal((0, paths_1.convertClientPathToDebugger)('C:\\var\\www\\foo\\..\\bar'), 'file:///C:/var/www/bar');
            });
            (0, mocha_1.it)('should resolve relative path maps win32 to posix', () => {
                assert.equal((0, paths_1.convertClientPathToDebugger)('C:\\work\\foo\\test.php', {
                    '/var/www/html/bar': 'C:\\work\\project\\folder\\..\\..\\foo',
                }), 'file:///var/www/html/bar/test.php');
            });
            (0, mocha_1.it)('should resolve relative path maps win32 to win32', () => {
                assert.equal((0, paths_1.convertClientPathToDebugger)('C:\\work\\foo\\test.php', {
                    'C:\\var\\www\\html\\bar': 'C:\\work\\project\\folder\\..\\..\\foo',
                }), 'file:///C:/var/www/html/bar/test.php');
            });
        });
    });
    (0, mocha_1.describe)('convertDebuggerPathToClient', () => {
        (0, mocha_1.describe)('without source mapping', () => {
            (0, mocha_1.it)('should convert a windows URI to a windows path', () => {
                assert.equal((0, paths_1.convertDebuggerPathToClient)('file:///C:/Users/felix/test.php'), 'C:\\Users\\felix\\test.php');
            });
            (0, mocha_1.it)('should convert a unix URI to a unix path', () => {
                assert.equal((0, paths_1.convertDebuggerPathToClient)('file:///home/felix/test.php'), '/home/felix/test.php');
            });
            (0, mocha_1.it)('should handle non-unicode special characters', () => {
                assert.equal((0, paths_1.convertDebuggerPathToClient)('file:///d:/arx%20iT/2-R%C3%A9alisation/mmi/V1.0/Web/core/header.php'), 'd:\\arx iT\\2-Réalisation\\mmi\\V1.0\\Web\\core\\header.php');
            });
        });
        (0, mocha_1.describe)('with source mapping', () => {
            // unix to unix
            (0, mocha_1.it)('should map unix uris to unix paths', () => {
                // site
                assert.equal((0, paths_1.convertDebuggerPathToClient)('file:///var/www/site.php', {
                    '/var/www': '/home/felix/mysite',
                    '/app': '/home/felix/mysource',
                }), '/home/felix/mysite/site.php');
                // source
                assert.equal((0, paths_1.convertDebuggerPathToClient)('file:///app/source.php', {
                    '/var/www': '/home/felix/mysite',
                    '/app': '/home/felix/mysource',
                }), '/home/felix/mysource/source.php');
                // longest prefix matching for local paths
                assert.strictEqual((0, paths_1.convertDebuggerPathToClient)('file:///app/subdir/source.php', {
                    '/var/www': '/home/felix/mysite',
                    '/app/subdir': '/home/felix/mysource/subdir1',
                    '/app': '/home/felix/mysource',
                }), '/home/felix/mysource/subdir1/source.php');
            });
            // unix to windows
            (0, mocha_1.it)('should map unix uris to windows paths', () => {
                // site
                assert.equal((0, paths_1.convertDebuggerPathToClient)('file:///var/www/site.php', {
                    '/var/www': 'C:\\Users\\felix\\mysite',
                    '/app': 'C:\\Users\\felix\\mysource',
                }), 'C:\\Users\\felix\\mysite\\site.php');
                // source
                assert.equal((0, paths_1.convertDebuggerPathToClient)('file:///app/source.php', {
                    '/var/www': 'C:\\Users\\felix\\mysite',
                    '/app': 'C:\\Users\\felix\\mysource',
                }), 'C:\\Users\\felix\\mysource\\source.php');
                // only drive letter
                assert.equal((0, paths_1.convertDebuggerPathToClient)('file:///var/www/source.php', {
                    '/var/www': 'C:',
                }), 'C:\\source.php');
                // only drive letter
                assert.equal((0, paths_1.convertDebuggerPathToClient)('file:///app/source.php', {
                    '/': 'C:',
                }), 'C:\\app\\source.php');
                // drive letter with slash
                assert.equal((0, paths_1.convertDebuggerPathToClient)('file:///var/www/source.php', {
                    '/var': 'C:/',
                }), 'C:\\www\\source.php');
                // drive letter with slash
                assert.equal((0, paths_1.convertDebuggerPathToClient)('file:///app/source.php', {
                    '/': 'C:/',
                }), 'C:\\app\\source.php');
            });
            // windows to unix
            (0, mocha_1.it)('should map windows uris to unix paths', () => {
                // dir/site
                assert.equal((0, paths_1.convertDebuggerPathToClient)('file:///C:/Program%20Files/Apache/2.4/htdocs/dir/site.php', {
                    'C:\\Program Files\\Apache\\2.4\\htdocs': '/home/felix/mysite',
                    'C:\\Program Files\\MySource': '/home/felix/mysource',
                }), '/home/felix/mysite/dir/site.php');
                // site
                assert.equal((0, paths_1.convertDebuggerPathToClient)('file:///C:/Program%20Files/Apache/2.4/htdocs/site.php', {
                    'C:\\Program Files\\Apache\\2.4\\htdocs': '/home/felix/mysite',
                    'C:\\Program Files\\MySource': '/home/felix/mysource',
                }), '/home/felix/mysite/site.php');
                // source
                assert.equal((0, paths_1.convertDebuggerPathToClient)('file:///C:/Program%20Files/MySource/source.php', {
                    'C:\\Program Files\\Apache\\2.4\\htdocs': '/home/felix/mysite',
                    'C:\\Program Files\\MySource': '/home/felix/mysource',
                }), '/home/felix/mysource/source.php');
                // multi level source
                assert.equal((0, paths_1.convertDebuggerPathToClient)('file:///C:/Program%20Files/MySource/src/app/source.php', {
                    'C:\\Program Files\\Apache\\2.4\\htdocs': '/home/felix/mysite',
                    'C:\\Program Files\\MySource': '/home/felix/mysource',
                }), '/home/felix/mysource/src/app/source.php');
            });
            // windows to windows
            (0, mocha_1.it)('should map windows uris to windows paths', () => {
                // site
                assert.equal((0, paths_1.convertDebuggerPathToClient)('file:///C:/Program%20Files/Apache/2.4/htdocs/site.php', {
                    'C:\\Program Files\\Apache\\2.4\\htdocs': 'C:\\Users\\felix\\mysite',
                    'C:\\Program Files\\MySource': 'C:\\Users\\felix\\mysource',
                }), 'C:\\Users\\felix\\mysite\\site.php');
                // source
                assert.equal((0, paths_1.convertDebuggerPathToClient)('file:///C:/Program%20Files/MySource/source.php', {
                    'C:\\Program Files\\Apache\\2.4\\htdocs': 'C:\\Users\\felix\\mysite',
                    'C:\\Program Files\\MySource': 'C:\\Users\\felix\\mysource',
                }), 'C:\\Users\\felix\\mysource\\source.php');
            });
        });
        (0, mocha_1.describe)('exact file mappings', () => {
            (0, mocha_1.it)('should map exact unix path', () => {
                assert.equal((0, paths_1.convertDebuggerPathToClient)('file:///var/path2/file2.php', {
                    '/var/path2/file2.php': '/var/path/file.php',
                }), '/var/path/file.php');
            });
            (0, mocha_1.it)('should map exact windows path', () => {
                assert.equal((0, paths_1.convertDebuggerPathToClient)('file:///C:/var/path2/file2.php', {
                    'C:\\var\\path2\\file2.php': 'C:\\var\\path\\file.php',
                }), 'C:\\var\\path\\file.php');
            });
        });
    });
    (0, mocha_1.describe)('sshfs', () => {
        (0, mocha_1.it)('should map sshfs to remote unix', () => {
            assert.equal((0, paths_1.convertClientPathToDebugger)('ssh://host/path/file.php', {
                '/root/path': 'ssh://host/path/',
            }), 'file:///root/path/file.php');
        });
        (0, mocha_1.it)('should map remote unix to sshfs', () => {
            assert.equal((0, paths_1.convertDebuggerPathToClient)('file:///root/path/file.php', {
                '/root/path': 'ssh://host/path/',
            }), 'ssh://host/path/file.php');
        });
        (0, mocha_1.it)('should map sshfs to remote unix relative', () => {
            assert.equal((0, paths_1.convertClientPathToDebugger)('ssh://host/path/file.php', {
                '/root/path': 'ssh://host/test/../path/',
            }), 'file:///root/path/file.php');
        });
        (0, mocha_1.it)('should map remote unix to sshfs relative', () => {
            assert.equal((0, paths_1.convertDebuggerPathToClient)('file:///root/path/file.php', {
                '/root/path': 'ssh://host/test/../path/',
            }), 'ssh://host/path/file.php');
        });
    });
    (0, mocha_1.describe)('UNC', () => {
        (0, mocha_1.it)('should convert UNC to url', () => {
            assert.equal((0, paths_1.convertClientPathToDebugger)('\\\\DARKPAD\\smb\\test1.php', {}), 'file://darkpad/smb/test1.php');
        });
        (0, mocha_1.it)('should convert url to UNC', () => {
            assert.equal((0, paths_1.convertDebuggerPathToClient)('file://DARKPAD/SMB/test2.php', {}), '\\\\darkpad\\SMB\\test2.php');
        });
    });
    (0, mocha_1.describe)('UNC mapping', () => {
        (0, mocha_1.it)('should convert UNC to mapped url', () => {
            assert.equal((0, paths_1.convertClientPathToDebugger)('\\\\DARKPAD\\smb\\test1.php', {
                '/var/test': '\\\\DARKPAD\\smb',
            }), 'file:///var/test/test1.php');
        });
        (0, mocha_1.it)('should convert url to mapped UNC', () => {
            assert.equal((0, paths_1.convertDebuggerPathToClient)('file:///var/test/test2.php', {
                '/var/test': '\\\\DARKPAD\\smb',
            }), '\\\\darkpad\\smb\\test2.php');
        });
    });
    (0, mocha_1.describe)('Phar', () => {
        (0, mocha_1.it)('should map win32 Phar client to debugger', () => {
            assert.equal((0, paths_1.convertClientPathToDebugger)('C:\\otherfolder\\internal\\file.php', {
                'phar://C:/folder/file.phar': 'C:\\otherfolder',
            }), 'phar://C:/folder/file.phar/internal/file.php');
        });
        (0, mocha_1.it)('should map win32 Phar debugger to debugger', () => {
            assert.equal((0, paths_1.convertDebuggerPathToClient)('phar://C:/folder/file.phar/internal/file.php', {
                'phar://C:/folder/file.phar': 'C:\\otherfolder',
            }), 'C:\\otherfolder\\internal\\file.php');
        });
        (0, mocha_1.it)('should map posix Phar client to debugger', () => {
            assert.equal((0, paths_1.convertClientPathToDebugger)('/otherfolder/internal/file.php', {
                'phar:///folder/file.phar': '/otherfolder',
            }), 'phar:///folder/file.phar/internal/file.php');
        });
        (0, mocha_1.it)('should map posix Phar debugger to debugger', () => {
            assert.equal((0, paths_1.convertDebuggerPathToClient)('phar:///folder/file.phar/internal/file.php', {
                'phar:///folder/file.phar': '/otherfolder',
            }), '/otherfolder/internal/file.php');
        });
    });
    (0, mocha_1.describe)('isPositiveMatchInGlobs', () => {
        (0, mocha_1.it)('should not match empty globs', () => {
            assert.equal((0, paths_1.isPositiveMatchInGlobs)('/test/test.php', []), false);
        });
        (0, mocha_1.it)('should match positive globs', () => {
            assert.equal((0, paths_1.isPositiveMatchInGlobs)('/test/test.php', ['**/test/**']), true);
        });
        (0, mocha_1.it)('should not match positive globs', () => {
            assert.equal((0, paths_1.isPositiveMatchInGlobs)('/test/test.php', ['**/not_test/**']), false);
        });
        (0, mocha_1.it)('should match negative globs', () => {
            assert.equal((0, paths_1.isPositiveMatchInGlobs)('/test/test.php', ['!**/test.php', '**/test/**']), false);
        });
        (0, mocha_1.it)('should not match negative globs', () => {
            assert.equal((0, paths_1.isPositiveMatchInGlobs)('/test/test.php', ['!**/not_test/test.php', '**/test/**']), true);
        });
    });
});
//# sourceMappingURL=paths.js.map