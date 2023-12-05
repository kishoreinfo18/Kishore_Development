import { isExternalLink } from "c/helpers";

describe("testing navigation link", () => {
  it("returns false for dummy page API name", () => {
    expect(isExternalLink("MyPage__c")).toBe(false);
  });

  it("returns false for page with unwanted protocol", () => {
    expect(isExternalLink("ftp://1234567")).toBe(false);
  });

  it("returns true for URL starting http:// ", () => {
    expect(isExternalLink("http://someurl.com")).toBe(true);
  });

  it("returns true for URL starting https:// ", () => {
    expect(isExternalLink("https://anotherurl.co.uk")).toBe(true);
  });
});
