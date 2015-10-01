var IpsumFodder = {
  cleanWordParams: function(word) {
    return word.replace('word-', '');
  },
  cleanCategoryParams: function(category) {
    return category.replace('category-', '');
  },
  handleIgnoreParam: function(categoryType, wordParams) {
    if (categoryType == 'ignore'){
      wordParams.ignore = true;
    }
    return wordParams;
  },
  postNewWord: function(wordParams, wordList, wordId) {
    $.ajax({
      type: "POST",
      url: "/words",
      data: {word: wordParams},
      success: function(data) {
        $(wordList).prepend(document.getElementById(wordId));
      },
      error: function(data) {
        alert(data.responseText.toString());
      }
    });
  },
  dropNewWord: function(ev) {
    ev.preventDefault();
    var evWordId = ev.dataTransfer.getData("text");
    var evCategoryId = event.currentTarget.id;
    var wordList = $(event.currentTarget).find('ul')[0];

    var wordName = IpsumFodder.cleanWordParams(evWordId);
    var categoryType = IpsumFodder.cleanCategoryParams(evCategoryId);
    var baseWordParams = {name: wordName, category: categoryType};
    var wordParams = IpsumFodder.handleIgnoreParam(categoryType, baseWordParams);

    IpsumFodder.postNewWord(wordParams, wordList, evWordId);
  },
  dragWord: function(ev) {
    ev.dataTransfer.setData("text", ev.target.id);
  }
};

function allowDrop(ev) {
  ev.preventDefault();
}
