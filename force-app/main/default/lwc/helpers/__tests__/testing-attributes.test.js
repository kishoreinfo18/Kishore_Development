import { createDataNameFrom } from "c/helpers";

describe("testing attributes", () => {
  it("returns name with component and element name", () => {
    const dataName = createDataNameFrom("component-name", "element-name");
    expect(dataName).toBe("component-name_element-name");
  });
  it("returns name with component and element name and one additional name", () => {
    const dataName = createDataNameFrom(
      "component-name",
      "element-name",
      "one-more-name"
    );
    expect(dataName).toBe("component-name_element-name_one-more-name");
  });
  it("returns name with component and element name and three additional name", () => {
    const dataName = createDataNameFrom(
      "component-name",
      "element-name",
      "one",
      "two",
      "three"
    );
    expect(dataName).toBe("component-name_element-name_one_two_three");
  });
});
