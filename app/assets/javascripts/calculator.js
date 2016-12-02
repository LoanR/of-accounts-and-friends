// calculate total of a board when loading page
function sumBoard(boardId) {
  var sum = 0;
  $('#transactions_content_' + boardId + ' .transaction .transaction_amount').each(function() {
    sum += (Number($(this).text()) * 100);
  });
  sum /= 100
  $('#transactions_sum_' + boardId).html(sum);
};

// add the new transaction value to the total without adding up all elements on the page
function addTransaction(boardId, childToAdd) {
  var totalAfter = (Number($('#transactions_sum_' + boardId).text()) * 100 + ($('#transactions_content_' + boardId + ' .transaction:nth-child(' + childToAdd + ') .transaction_amount').text() * 100)) / 100
  $('#transactions_sum_' + boardId).html(totalAfter);
};
