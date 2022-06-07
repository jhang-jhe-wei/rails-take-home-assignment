# README
## Requirement
- [chromedriver](https://chromedriver.chromium.org/)

## How to Run?
```bash
bundle install
yarn install
rails db:create
rails db:migrate
rails db:seed
rails s
```

## 關於測試
此專案使用 BDD 進行開發, Spec 測試覆蓋率 100%
在複雜邏輯的情況下(通常是在 Model 層的 Methods)會額外做 Unit Test
目前有使用的測試:
- E2E test(feature test)
- Unit test

### 規格表
以下內容使用 `rspec -f d` 產生

```
User adjusts tracking lists order
  expects last created tracking_list is the first in the page
  when current user down the first tracking list in the page
    expects to see the tracking list move to the second position
  when current user up the last tracking list in the page
    expects to see the tracking list move to the last second position

User creates a tracking list
  expects to see new tracking list
  expects to see new tracking stock record link
  expects to see created successfully message
  does not expect to see no tracking list message
  without name
    expects to see name cannot be blank
  when switches to other user
    expects to see no tracking list message

User creates a tracking stock record
  expects to see the stock list on the page
  expect to see tracking list name on the page
  when user fill in the correct stock code
    expects to see create successfully message in the landing page
    expects to see stock list in the tracking list
  when user fill in the incorrect stock code
    expects to see stock does not exist message in the current page
  when user fill in the stock code which already in the same tracking list
    expects to see stock aleady in the same tracking list in the current page

User deletes the tracking stock record
  expects to see delete link in tracking stock
  when delete tmsc
    expects see delete successfully message
    expects tmsc does not in the page

User deletes the tracking list
  when current user has one tracking list
    expects to see the delete successfully message
    expects to see the no tracking list message
  when current user has three tracking lists
    expects to see two tracking list

User edits the tracking list
  when current user has one tracking list
    expects to see name of the tracking_list has changed
    expects to see the updated successfully message
  when current user has many tracking lists
    expects to see name of the second tracking list has changed

User switches to another user
  expect to see the first user name
  expect to change current user

User visits landing page
  when current user does not have tracking list
    expects to see no tracking list message
    expects to see the create tracking list button
  when current user has many tracking list
    expects to see their all tracking lists

TrackingList
  #calculate_row_order
    when current user add their first tracking list
      Other user add their first tracking list
      row_order
        is expected to eq 1
    when current user has 5 tracking lists, remove the second tracking list and add a new tracking list
      row_order
        is expected to eq 6
  #down
    when current user has 10 tracking lists
      down the tracking list which order is 9
    when current user has 8 tracking lists
      down the tracking list which order is 1
    when current user only has one tracking list, after down
      row_order
        is expected to eq 1
  #up
    when current user has 10 tracking lists
      Order of the tracking list is 9, after up
    when current user has 8 tracking lists
      Order of the tracking list is 8, after up
    when current user only has one tracking list, after up
      row_order
        is expected to eq 1

Finished in 13.53 seconds (files took 1.89 seconds to load)
38 examples, 0 failures
```
