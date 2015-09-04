function allowDrop(ev) {
  ev.preventDefault();
}

function drag(ev) {
  ev.dataTransfer.setData("text", ev.target.id);
}

function postNewWord(wordParams, wordList, wordId) {
  $.ajax({
    type: "POST",
    url: "/words",
    data: {word: wordParams },
    success: function(data) {
      $(wordList).prepend(document.getElementById(wordId));
    },
    error: function(data) {
      alert(data.responseText.toString());
    }
  });
}

function dropNewWord(ev) {
  ev.preventDefault();
  //TODO: Disallow dragging on non-category elements
  var evWordId = ev.dataTransfer.getData("text");
  var evCategoryId = ev.target.id;
  var wordList = $(ev.target).find('ul')[0];

  var wordName = evWordId.replace('word-', '');
  var categoryType = evCategoryId.replace('category-', '');

  var wordParams = {name: wordName, category: categoryType};

  if (categoryType == 'ignore'){
    wordParams.ignore = true;
  }

  postNewWord(wordParams, wordList, evWordId);
}
