import {expect} from 'chai';
import {MandatoryFields} from '../src/decorators.js';

class TestClass {
	@MandatoryFields([])
	noMandatory(_: unknown): void {
		// empty
	}

	@MandatoryFields(['propA'])
	singleMandatory(_: unknown): void {
		// empty
	}

	@MandatoryFields(['propA', 'propB'])
	pairMandatory(_: unknown): void {
		// empty
	}

	@MandatoryFields([['propA', 'propB']])
	optionalMandatory(_: unknown): void {
		// empty
	}

	@MandatoryFields([{deepProp: ['deepPropA']}])
	deepMandatory(_: unknown): void {
		// empty
	}
}

describe('Decorators', () => {
	it('checkMandatoryFields - empty options with no mandatory', () => {
		expect(() => {
			new TestClass().noMandatory({});
		}).to.not.throw();
	});

	it('checkMandatoryFields - empty options with mandatory', () => {
		expect(() => {
			new TestClass().singleMandatory({});
		}).to.throw(Error, 'Field "propA" not present.');
	});

	it('checkMandatoryFields - options with no mandatory', () => {
		expect(() => {
			new TestClass().noMandatory({
				foo: 'bar',
			});
		}).to.not.throw();
	});

	it('checkMandatoryFields - options with mandatory success', () => {
		expect(() => {
			new TestClass().pairMandatory({
				foo: 'bar',
				propA: 1,
				propB: 2,
				propC: 3,
			});
		}).to.not.throw();
	});

	it('checkMandatoryFields - options with mandatory that not exist', () => {
		expect(() => {
			new TestClass().pairMandatory({
				propA: 1,
				foo: 'bar'
			});
		}).to.throw(Error, 'Field "propB" not present.');
	});

	it('checkMandatoryFields - options with optional mandatory success', () => {
		expect(() => {
			new TestClass().optionalMandatory({
				foo: 'bar',
				propA: 1,
			});
		}).to.not.throw();
	});

	it('checkMandatoryFields - options with optional mandatory without any', () => {
		expect(() => {
			new TestClass().optionalMandatory({
				foo: 'bar'
			});
		}).to.throw(Error, 'Expected one of this fields: {["propA","propB"]}.');
	});

	it('checkMandatoryFields - mandatory inside object success', () => {
		expect(() => {
			new TestClass().deepMandatory({
				foo: 'bar',
				deepProp: {
					deepPropA: 1,
					deepPropB: 2,
				}
			});
		}).to.not.throw();
	});

	it('checkMandatoryFields - mandatory inside object key not found', () => {
		expect(() => {
			new TestClass().deepMandatory({
				foo: 'bar',
				deepProp: {
					deepPropB: 2,
				}
			});
		}).to.throw(Error, 'Field "deepPropA" not present.');
	});

	it('checkMandatoryFields - mandatory inside object inner key not found', () => {
		expect(() => {
			new TestClass().deepMandatory({
				foo: 'bar',
				invalidDeep: {
					deepPropB: 2,
				}
			});
		}).to.throw(Error, 'Field "deepProp" not present.');
	});

	it('checkMandatoryFields - mandatory with undefined options', () => {
		expect(() => {
			new TestClass().singleMandatory(undefined);
		}).to.throw(Error, 'Expected one of this fields: {["propA"]}, but undefined/null received.');
		expect(() => {
			new TestClass().singleMandatory(null);
		}).to.throw(Error, 'Expected one of this fields: {["propA"]}, but undefined/null received.');
	});
});
