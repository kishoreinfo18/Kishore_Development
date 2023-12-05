import SSP_RESOURCES from "@salesforce/resourceUrl/ssp";

const createSvgPathForEntitlementImage = svgName => {
  return SSP_RESOURCES + `/images/${svgName}.svg#Page-1`;
};

const createPngPathForEntitlementImage = pngName => {
  return SSP_RESOURCES + `/images/${pngName}.png`;
};

export { createSvgPathForEntitlementImage, createPngPathForEntitlementImage };
