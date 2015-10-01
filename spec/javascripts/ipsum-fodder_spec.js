describe("IpsumFodder", function() {
  it("cleans word params", function() {
    expect(IpsumFodder.cleanWordParams("word-romance")).toEqual("romance");
  });

  it("cleans category params", function() {
    expect(IpsumFodder.cleanCategoryParams("category-pirate")).toEqual("pirate");
  });

  describe("handleIgnoreParams", function() {
    it("adds an ignore params if category is ignore", function() {
      expect(IpsumFodder.handleIgnoreParam("ignore", {})).toEqual({ignore: true});
    });

    it("adds no params if category is not ignore", function() {
      expect(IpsumFodder.handleIgnoreParam("pirate", {})).toEqual({});
    });
  });

  describe("postNewWord calls", function() {
    it("should make an AJAX request to the words URL", function() {
      spyOn($, "ajax");
      IpsumFodder.postNewWord();
      expect($.ajax.calls.mostRecent().args[0].url).toEqual("/words");
    });
  });
});
