/**
 * NPM dependencies for plugins:
 *  "eslint": "^7.32.0",
    "eslint-config-airbnb": "^18.2.1",
    "eslint-import-resolver-typescript": "^2.5.0",
    "eslint-plugin-import": "^2.25.2",
    "eslint-plugin-jsx-a11y": "^6.4.1",
    "eslint-plugin-react": "^7.26.1",
    "eslint-plugin-react-hooks": "^4.2.0",
    "eslint-plugin-simple-import-sort": "^7.0.0",
    "@typescript-eslint/eslint-plugin": "5.3.1",
    "@typescript-eslint/parser": "5.3.1"

    `npm i -D eslint eslint-config-airbnb eslint-import-resolver-typescript eslint-plugin-import \
     eslint-plugin-jsx-a11y eslint-plugin-react eslint-plugin-react-hooks eslint-plugin-simple-import-sort\
     @typescript-eslint/parser @typescript-eslint/eslint-plugin`
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