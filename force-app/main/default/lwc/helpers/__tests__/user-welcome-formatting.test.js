import { formatWelcomeMessage } from "c/helpers";

describe("user welcome formatting", () => {
  it("returns only the forename when forename supplied", () => {
    const userMessage = formatWelcomeMessage("Mr", "Greg", "Davery");
    expect(userMessage).toBe("Greg");
  });
  it("returns title and surname when missing forename ", () => {
    const userMessage = formatWelcomeMessage("Mr", "", "Davery");
    expect(userMessage).toBe("Mr Davery");
  });
  it("returns surname when forename and title missing", () => {
    const userMessage = formatWelcomeMessage(undefined, undefined, "Davery");
    expect(userMessage).toBe("Davery");
  });
  it("returns empty string when all missing", () => {
    const userMessage = formatWelcomeMessage(undefined, undefined, undefined);
    expect(userMessage).toBe("");
  });
});
