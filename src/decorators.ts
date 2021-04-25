export function MandatoryFields(mandatoryFields: string | any[] | any) {
    // eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types
    return (target: any, propertyKey: string, descriptor: PropertyDescriptor): any => {
        const method = descriptor.value;
        descriptor.value = function (options: any) {
            _checkMandatoryFields(options, mandatoryFields);
            return method.call(this, options);
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
function _checkMandatoryFields(options: any | any[], mandatoryFields: string | any[] | any): void {
    if (mandatoryFields && options == null) {
        throw new Error(`Expected one of this fields: [${mandatoryFields}], but undefined/null received.`);
    }

    for (const field of mandatoryFields) {
        if (Array.isArray(field)) {
            if (!field.some(f => Object.prototype.hasOwnProperty.call(options, f))) {
                throw new Error(`Expected one of this fields: [${field}].`);
            }
        } else if (typeof field === 'object') {
            _checkMandatoryFieldsObject(options, field);
        } else if (!(field in options)) {
            throw new Error(`Field "${field}" not present.`);
        }
    }
}

function _checkMandatoryFieldsObject(options: any | any[], field: any): void {
    for (const [fieldKey, fieldValue] of Object.entries(field)) {
        if (fieldKey in options) {
            _checkMandatoryFields(options[fieldKey], fieldValue);
        } else {
            throw new Error(`Field "${fieldKey}" not present.`);
        }
    }
}
