const formatDate = value => {
  if (!value) {
    return "--";
  }
  const dateFormatOptions = {
    day: "numeric",
    month: "long",
    year: "numeric"
  };
  const dateFormatLocale = "en-GB";
  const dateValue = new Date(value);
  const dateFormatted = dateValue.toLocaleDateString(
    dateFormatLocale,
    dateFormatOptions
  );
  return dateFormatted;
};

const formatDateWithoutOptions = value => {
  if (!value) {
    return "--";
  }
  const dateFormatLocale = "en-GB";
  const dateValue = new Date(value);
  return dateValue.toLocaleDateString(dateFormatLocale);
};

const formatCurrency = value => {
  if (
    value === undefined ||
    value === null ||
    isNaN(value) ||
    value === Infinity
  ) {
    return "--";
  }
  const significantValue = Math.abs(value);
  let currencyFormatted = `£${significantValue.toFixed(2)}`;
  if (value < 0) {
    currencyFormatted = "-" + currencyFormatted;
  }
  return currencyFormatted;
};

const formatYesNo = value => {
  const yesNoFormatted = value ? "Yes" : "No";
  return yesNoFormatted;
};

const formatWelcomeMessage = (title, forenames, surname) => {
  let message = "";
  if (forenames) {
    message = forenames;
  } else if (title && surname) {
    message = `${title} ${surname}`;
  } else if (surname) {
    message = surname;
  }
  return message.trim();
};

export {
  formatDate,
  formatCurrency,
  formatYesNo,
  formatWelcomeMessage,
  formatDateWithoutOptions
};
