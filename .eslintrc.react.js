/**
  run `npm i -D eslint && npx eslint --init`
  Additional plugins:
    - eslint-import-resolver-typescript
    - eslint-plugin-simple-import-sort
    - @typescript-eslint/parser 
    - @typescript-eslint/eslint-plugin
 */

/**
 * Eslint for React config file.
 */
module.exports = {
 env: {
   browser: true,
   es2021: true,
   jest: true,
 },
 extends: ['plugin:react/recommended', 'airbnb'],
 parser: '@typescript-eslint/parser',
 /**
  * Manual web-components loading configuration
  */
 // ignorePatterns: ['**/wc/**'],
 // ignorePatterns: ['**/wc/**.js'], 
 parserOptions: {
   ecmaFeatures: {
     jsx: true,
   },
   ecmaVersion: 12,
   sourceType: 'module',
 },
 plugins: ['react', '@typescript-eslint', 'import', 'simple-import-sort'],
 rules: {
   'import/extensions': 0,
   'react/jsx-filename-extension': [1, { extensions: ['.jsx', '.tsx'] }],
   'no-use-before-define': 0,
   '@typescript-eslint/no-use-before-define': [2],
   'react/prop-types': 0,
   'no-unused-vars': 'off',
   '@typescript-eslint/no-unused-vars': ['error'],
   'react/jsx-props-no-spreading': 0,
   'import/no-cycle': 1,
   'react/react-in-jsx-scope': 0,
   'no-shadow': 0,
   indent: 'off',
   '@typescript-eslint/indent': ['error', 2],
   'simple-import-sort/imports': 'error',
   'simple-import-sort/exports': 'error',
 },
 settings: {
   'import/parsers': {
     '@typescript-eslint/parser': ['.ts', '.tsx'],
   },
   'import/resolver': {
     typescript: {
       alwaysTryTypes: true,
       project: 'tsconfig.json',
     },
   },
 },
 globals: {
   React: true,
   google: true,
   mount: true,
   mountWithRouter: true,
   shallow: true,
   shallowWithRouter: true,
   context: true,
   expect: true,
   jsdom: true,
   JSX: true,
 },
};