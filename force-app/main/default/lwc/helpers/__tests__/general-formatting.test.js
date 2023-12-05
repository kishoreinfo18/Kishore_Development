import { formatDate, formatCurrency, formatYesNo } from "c/helpers";

describe("date formatting", () => {
  it.skip("formats the 11/7/2020 as 11 July 2020", () => {
    // JS dates are zero based on months..
    const today = new Date(2020, 6, 11);
    const formattedDate = formatDate(today);
    expect(formattedDate).toBe("11 July 2020");
  });
  it("formats undefined as --", () => {
    const formattedValue = formatDate(undefined);
    expect(formattedValue).toBe("--");
  });
});

describe("currency formatting", () => {
  it("formats the 250.35 as £250.35", () => {
    const moneyValue = 250.35;
    const formattedValue = formatCurrency(moneyValue);
    expect(formattedValue).toBe("£250.35");
  });
  it("formats 0 as £0.00", () => {
    const moneyValue = 0;
    const formattedValue = formatCurrency(moneyValue);
    expect(formattedValue).toBe("£0.00");
  });
  it("formats -120 as -£120.00", () => {
    const moneyValue = -120;
    const formattedValue = formatCurrency(moneyValue);
    expect(formattedValue).toBe("-£120.00");
  });
  it("formats undefined as --", () => {
    const formattedValue = formatCurrency(undefined);
    expect(formattedValue).toBe("--");
  });
  it("formats null as --", () => {
    const formattedValue = formatCurrency(null);
    expect(formattedValue).toBe("--");
  });
  it("formats NaN as --", () => {
    const formattedValue = formatCurrency(NaN);
    expect(formattedValue).toBe("--");
  });
  it("formats Infinity as --", () => {
    const formattedValue = formatCurrency(Infinity);
    expect(formattedValue).toBe("--");
  });
});

describe("boolean formatting", () => {
  it("formats true as Yes", () => {
    const yesFormatted = formatYesNo(true);
    expect(yesFormatted).toBe("Yes");
  });
  it("formats false as No", () => {
    const noFormatted = formatYesNo(false);
    expect(noFormatted).toBe("No");
  });
  it("formats undefined as No", () => {
    const noFormatted = formatYesNo(undefined);
    expect(noFormatted).toBe("No");
  });
});
