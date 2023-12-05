const getIconNameForEntitlementName = entitlementName => {
  let iconName = "healthcare";
  const entitlementNameClean = entitlementName.trim().toLowerCase();
  switch (entitlementNameClean) {
    case "gpservices":
    case "gp services":
      iconName = "stethoscope";
      break;
    case "newchild":
    case "new child":
    case "new child payment":
      iconName = "new_child";
      break;
    case "auditory":
      iconName = "auditory";
      break;
    case "poca":
      iconName = "physiotherapy";
      break;
    case "diagnosis":
      iconName = "diagnostics";
      break;
    case "healthcheck":
      iconName = "assessment";
      break;
    case "complimentary":
      iconName = "complimentary-therapies";
      break;
    case "bereavement":
      iconName = "difficult-time";
      break;
    case "miscellaneous":
      iconName = "receipt";
      break;
    case "dental":
    case "physiotheraphy":
    case "healthcare":
    case "podiatry":
    case "optical":
    case "hospital":
    case "wellbeing":
      iconName = entitlementNameClean;
      break;
    case "diagnostic":
      iconName = "diagnostics";
      break;
    case "prescription":
      iconName = "medical";
      break;
    case "gpvisit":
    case "gp visit":
      iconName = "gp";
      break;
    case "care":
      iconName = "physiotherapy";
      break;
    case "dentalaccident":
    case "dental accident":
      iconName = "dental_emergency";
      break;
    case "child":
      iconName = "new_child";
      break;
    case "assessment":
      iconName = "assessment";
      break;
    default:
      iconName = "healthcare";
  }
  return iconName;
};

const getClaimDisplayNameForStatus = claimStatus => {
  let statusDisplayName = "";
  switch (claimStatus) {
    case "PROCESSING":
      statusDisplayName = "Submitted";
      break;
    case "MORE_INFORMATION_REQUIRED":
      statusDisplayName = "Requires action";
      break;
    case "PAID":
      statusDisplayName = "Approved";
      break;
    case "REJECTED":
      statusDisplayName = "Rejected";
      break;
    case "CANCELLED":
      statusDisplayName = "Cancelled";
      break;
    default:
      statusDisplayName = "Unknown";
  }
  return statusDisplayName;
};

const getIconNameForClaimStatus = statusName => {
  let iconName = "healthcare";
  const statusNameClean = statusName.trim().toLowerCase();
  switch (statusNameClean) {
    case "paid":
      iconName = "sys-tick";
      break;
    case "rejected":
      iconName = "sys-cross";
      break;
    case "required action":
      iconName = "sys-warning";
      break;
    default:
      iconName = "sys-warning";
  }
  return iconName;
};

export {
  getIconNameForEntitlementName,
  getClaimDisplayNameForStatus,
  getIconNameForClaimStatus
};
