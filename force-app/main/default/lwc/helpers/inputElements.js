const classSelectorFromClassName = className => `.${className}`;

const isValid = elementReference => {
  if (elementReference && elementReference.validity) {
    return elementReference.validity.valid;
  }
  return false;
};

const areAllValid = elementReferences => {
  let allValid = false;
  for (const elementReference of elementReferences) {
    allValid = isValid(elementReference);
    if (!allValid) {
      break;
    }
  }
  return allValid;
};

const invokeAllValidation = elementReferences => {
  for (const elementReference of elementReferences) {
    elementReference.reportValidity();
  }
};

const fromTemplate = template => {
  const getElementReferenceByClassName = className => {
    const selector = classSelectorFromClassName(className);
    const element = template.querySelector(selector);
    return element;
  };
  const getElementReferenceByTypeName = typeName => {
    const element = template.querySelector(typeName);
    return element;
  };
  return {
    getElementReferenceByClassName,
    getElementReferenceByTypeName
  };
};

const getAllElementReferencesFromMap = elementReferencesMap => {
  const allElementReferences = [];
  for (const key in elementReferencesMap) {
    if (Object.prototype.hasOwnProperty.call(elementReferencesMap, key)) {
      allElementReferences.push(elementReferencesMap[key].elementReference);
    }
  }
  return allElementReferences;
};

const fromElementReferenceMap = elementReferencesMap => {
  const getValueByName = elementName => {
    if (
      Object.prototype.hasOwnProperty.call(elementReferencesMap, elementName)
    ) {
      return elementReferencesMap[elementName].elementReference.value;
    }
    return "";
  };
  return {
    getValueByName
  };
};

const validationPatterns = {
  CUSTOMER_NAME_VALIDATION_PATTERN: "^[a-zA-Z ,'.-]+$",
  BANK_ACCOUNT_NUMBER_VALIDATION_PATTERN: "^[0-9]+$",
  BANK_ACCOUNT_SORT_CODE_PART_VALIDATION_PATTERN: "^[0-9]+$",
  POSTCODE_VALIDATION_PATTERN: "^[A-Za-z]{1,2}\\d[A-Za-z\\d]? ?\\d[A-Za-z]{2}$",
  ADDRESS_VALIDATION_PATTERN: "^[a-zA-Z 0-9.,'\\-&]*$",
  PASSWORD_VALIDATION_PATTERN:
    "(?=^.{10,}$)(?=.*\\d)(?=.*\\W+)(?![.\\n])(?=.*[A-Z])(?=.*[a-z]).*$"
};

export {
  fromTemplate,
  classSelectorFromClassName,
  isValid,
  areAllValid,
  invokeAllValidation,
  getAllElementReferencesFromMap,
  validationPatterns,
  fromElementReferenceMap
};
