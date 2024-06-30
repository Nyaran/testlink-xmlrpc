type MandatoryFieldArg = string[] | Record<string, string[]>[]
type MandatoryFieldArgDual = MandatoryFieldArg | (string | MandatoryFieldArg)[]

export function MandatoryFields(mandatoryFields: MandatoryFieldArgDual) {
	// eslint-disable-next-line @typescript-eslint/no-explicit-any
	return (target: unknown, propertyKey: string, descriptor: PropertyDescriptor): any => {
		const method = descriptor.value as () => void;
		descriptor.value = function(options: Record<string, string>) {
			_checkMandatoryFields(options, mandatoryFields);
			return method.call(this, options); // eslint-disable-line @typescript-eslint/no-unsafe-return
		};
	};
}

/**
 * Check mandatory fields in various ways
 *
 * @param options - Options to be checked
 * @param mandatoryFields - Array with fields to check
 *     - If a String is given, check if it exists inside options
 *     - If an Array is given, check if at least one of the elements exists
 *     - If an Object is given, check if the field exists in options and also it inner options.
 *
 * @throws Error if field not found.
 */
function _checkMandatoryFields(options: string | Record<string, string>, mandatoryFields: MandatoryFieldArgDual): void {
	if (mandatoryFields && options == null) {
		throw new Error(`Expected one of this fields: {${JSON.stringify(mandatoryFields)}}, but undefined/null received.`);
	}

	for (const field of mandatoryFields) {
		if (Array.isArray(field)) {
			if (!(field as string[]).some(f => Object.hasOwn(options as Record<string, string>, f))) {
				throw new Error(`Expected one of this fields: {${JSON.stringify(field)}}.`);
			}
		} else if (typeof field === 'object') {
			_checkMandatoryFieldsObject(options as Record<string, string>, field);
		} else if (!(field in (options as Record<string, string>))) {
			throw new Error(`Field "${field}" not present.`);
		}
	}
}

function _checkMandatoryFieldsObject(options: Record<string, string>, field: Record<string, string[]>): void {
	for (const [fieldKey, fieldValue] of Object.entries(field)) {
		if (fieldKey in options) {
			_checkMandatoryFields(options[fieldKey], fieldValue);
		} else {
			throw new Error(`Field "${fieldKey}" not present.`);
		}
	}
}
