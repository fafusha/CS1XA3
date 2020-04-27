# CS 1XA3 Project03 - rapopord
## Usage
Install conda enivornment wit
```
conda create -n djangoenv python=3.7 
conda activate djangoenv
```
Run locally with
```
python manage.py runserver localhost:8000
```
Run on mac1xa3.ca with
```
python manage.py runserver localhost:10082
```
Log in with of the users. (See Objective 11)

## Objective 01: Complete Login and SignUp Pages
*Description:*
- this feature is displayed in signup.djhtml which is rendered by
signup_view 
- it makes a POST Request sent by the form to /e/rapopord/login_view/create
which is handled by create_view 

*Exceptions:*
- If the /e/rapopord/login_view/create is called without arguments is redirects
to signup.djhtml

## Objective 02: Adding User Profile and Interests
*Description:*
- this feature is displayed in social_base.djhtml which is rendered by messages_view,
people_view and account_view.

## Objective 03: Account Settings Page
*Description:*
- this feature is displayed in account.djhtml which is rendered by
account_view
- it makes a POST Request to from update_info.js and a password from to /e/rapopord/account
which is handled by account_view

## Objective 04: Displaying People List
*Description:*
- this feature is displayed in people.djhtml which is rendered by
people_view
- it makes a POST Request from `More` button to /e/rapopord/moreppl
which is handled by more_ppl_view

*Exceptions:*
- If the /e/rapopord/moreppl is called without arguments is redirects
to login.djhtml

## Objective 05: Sending Friend Requests 
*Description:*
- this feature is displayed in people.djhtml which is rendered by
people_view
- it makes a POST Request from the button to /e/macid/friendrequest
which is handled by friend_request_view

*Exceptions:*
- If the /e/macid/friendrequest is called without arguments raises an error

## Objective 06: Accepting / Declining Friend Requests 
*Description:*
- this feature is displayed in people.djhtml which is rendered by
people_view
- it makes a POST Request from buttons to /e/rapopord/acceptdecline/
which is handled by accept_decline_view

*Exceptions:*
- If the /e/rapopord/acceptdecline/ is called without argument raises an error.

## Objective 07: Displaying Friends 
*Description:*
- this feature is displayed messages.djhtml which is rendered by
def messages_view

## Objective 08: Submitting Posts
*Description:*
- this feature is displayed in messages.djhtml which is rendered by
messages_view
- it makes a AJAX POST Request from messages.js to /e/rapopord/postsubmit/
which is handled by post_submit_view

*Exceptions:*
- If the /e/macid/something_post is called without arguments raises an error

## Objective 09: Displaying Post List
*Description:*
- this feature is displayed in messages.djhtml which is rendered by
messages_view
- it makes a POST Request from `More` button to /e/rapopord/morepost/
which is handled by more_post_view

*Exceptions:*
- If the /e/rapopord/morepost/ is called without arguments is redirects
to login.djhtml

## Objective 10: Liking Posts (and Displaying Like Count)
*Description:*
- this feature is displayed in messages.djhtml which is rendered by
messages_view
- it makes a POST Request from `Like` button to /e/rapopord/like
which is handled by like_view

*Exceptions:*
- If the /e/rapopord/like is called without arguments is redirects
to login.djhtml

## Objective 11: Create a Test Database
*Description:*
- Test database contains 5 users

*Users:*
- `TestUser1`
- `TestUser2`
- `TestUser3`
- `TestUser4`
- `TestUser5`

*Password:*
- `1234`
