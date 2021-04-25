module.exports = {
    diff: true,
    extension: ['ts'],
    package: './package.json',
    reporter: 'spec',
    require: 'ts-node/register',
    slow: 75,
    timeout: 2000,
    ui: 'bdd',
    file: ['test/_tests.setup.ts'],
    'watch-files': ['src/**/*.ts', 'test/**/*.ts'],
    'watch-ignore': ['lib/vendor']
};