const createDataNameFrom = (
  componentInstanceName,
  elementName,
  ...additionalNames
) => {
  let dataName = `${componentInstanceName}_${elementName}`;
  if (additionalNames && additionalNames.length > 0) {
    dataName = `${dataName}_${additionalNames.join("_")}`;
  }
  return dataName;
};

export { createDataNameFrom };
