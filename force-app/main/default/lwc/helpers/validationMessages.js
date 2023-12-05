const requiredMessage = fieldDescription =>
  `${fieldDescription} is a required field.`;

const invalidFormatMessage = fieldDescription =>
  `Please enter a valid ${fieldDescription}.`;

const crossFieldMismatchMessage = fieldDescription =>
  `Please ensure the ${fieldDescription} match.`;

const oneRequiredMessage = fieldDescription =>
  `Please provide at least one ${fieldDescription}.`;

export {
  requiredMessage,
  invalidFormatMessage,
  crossFieldMismatchMessage,
  oneRequiredMessage
};
