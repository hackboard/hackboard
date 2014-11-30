# Hackboard - Taipei Tech CSIE SE Project #

## 關於開發流程 ##

1. 接到issue，使用git-flow開新feature，issue name：issue_#xx
1. 開始實作issue/feature的功能 (請將不同的事情分開commit，不要全部集中在同一個commit內)
1. 完成後按下finish current (current state:Feature: issue_#xx)，請不要fast forward（不要勾選Rebase）
1. 確定沒問題後，將develop push到origin/develop
## 關於一個Issue 只要一個commit即可解決的狀況 ##

當一個Issue只需要一個Commit就可以解決的時候，source tree會進行 fast forward的動作，
所以，當你發現這一個 feature / issue 只要一個commit 就能解決的時候，請在該commit 訊息上
打上 finish issue #xx，這樣我才知道這個commit是解掉哪一個issue。

