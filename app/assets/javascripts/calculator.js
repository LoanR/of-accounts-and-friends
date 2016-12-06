// sum total transactions of a board when loading page
function sumBoard(boardId) {
  var sum = 0;
  $('#transactions_content_' + boardId + ' .transaction .transaction_amount').each(function() {
    sum += Number($(this).text().replace(/[\D]/g,''));
  });
  $('#transactions_sum_' + boardId).text(sum);
};

// add the new transaction value to an existing total
function addToTotal(oldTotalSelector, boardId, transactionId) {
  var newTotal = (Number(oldTotalSelector.text().replace(/[\D]/g,'')) + Number($('#transaction_' + transactionId + '_amount').text().replace(/[\D]/g,''))).toString();
  // console.log(newTotal);
  newTotal = newTotal.length < 3 ? (Array(4 - newTotal.length).join('0') + newTotal) : newTotal;
  // console.log(newTotal);
  var dec = (newTotal.match(/\d{2}$/))[0];
  // console.log(dec);
  var int = newTotal.replace(/\d{2}$/, '').split('').reverse().join('').match(/\d{1,3}/g).join(' ').split('').reverse().join('')
  // console.log(int);
  oldTotalSelector.text(int + ', ' + dec);
}

// insert a 3 decimals result in a specified place
function threeDecimalOp(intStr, realSelector, bitSelector) {
  var int = intStr.replace(/(\d|-){3}$/, '').split('').reverse().join('').match(/(\d|-){1,3}/g).join(' ').split('').reverse().join('');
  var wrongDec = (intStr.match(/\d{3}$/))[0];
  var bit = (wrongDec.match(/\d$/))[0];
  var dec = wrongDec.replace(/\d$/, '');
  realSelector.text(int + ', ' + dec);
  bitSelector.text(bit);
}

// add the new transaction value to the board total
function addTransaction(boardId, transactionId) {
  var oldTotalSelector = $('#transactions_sum_' + boardId);
  addToTotal(oldTotalSelector, boardId, transactionId);
};

// changing board average because of new transaction
function changeBoardAverage(boardId, friendsId) {
  var newBoardAv = parseInt((Number($('#transactions_sum_' + boardId).text().replace(/[\D]/g,'')) * 10) / Number(friendsId.length)).toString();
  newBoardAv = newBoardAv.length < 4 ? (Array(5 - newBoardAv.length).join('0') + newBoardAv) : newBoardAv;
  var realSelector = $('#real_for_' + boardId);
  var bitSelector = $('#bit_for_' + boardId);
  threeDecimalOp(newBoardAv, realSelector, bitSelector);
}

// add the new transaction value to the friend total
function addToFriendTotal(friendId, boardId, transactionId) {
  var oldTotalSelector = $('#friend_' + friendId + '_total_expenses_for_' + boardId);
  addToTotal(oldTotalSelector, boardId, transactionId);
}

function friendsBalance(boardId, friendsId) {
  for (var index = friendsId.length - 1; index >= 0; index--) {
    var friendId = friendsId[index];
    var friendBalance = (Number($('#average_for_' + boardId).text().replace(/[\D]/g,'')) - (Number($('#friend_' + friendId + '_total_expenses_for_' + boardId).text().replace(/[\D]/g,'')) * 10)).toString();
    count = friendBalance.length;
    if (parseInt(friendBalance) < 0) {
      friendBalance = count < 5 ? friendBalance.replace('-', '-' + '0'.repeat(5 - count)) : friendBalance;
      console.log(friendBalance);
    } else {
      friendBalance = count < 4 ? (Array(5 - count).join('0') + friendBalance) : friendBalance;
    }
    var realSelector = $('#friend_' + friendId + '_real_for_' + boardId);
    var bitSelector = $('#friend_' + friendId + '_bit_for_' + boardId);
    threeDecimalOp(friendBalance, realSelector, bitSelector);
  }
}

// function friendExpenses(friendId, boardId, transactionId) {
//   $('#friend_<%= friend.id %>_total_expenses_for_<%= @current_board.id %>')
//   console.log(transactionsValue)
// };
