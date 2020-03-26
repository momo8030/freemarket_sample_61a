#メインページ
crumb :root do
  link "メルカリ", root_path
end

crumb :mypage do
  link "マイページ", user_path(:id)
  parent :root
end

crumb :info do
  link "本人情報の登録"
  parent :mypage
end

crumb :profile do
  link "プロフィール"
  parent :mypage
end

crumb :logout do
  link "ログアウト"
  parent :mypage
end

crumb :credit do
  link "支払い方法", cards_path
  parent :mypage
end

crumb :creditcard do
  link "クレジットカード情報入力"
  parent :credit
end

 crumb :item do |item|
   link item.name, item_path(item)
   parent :root
end

 crumb :item_ex do 
   link "出品商品画面"
   parent :mypage
end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).