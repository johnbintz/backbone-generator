*Not done yet!*

Currently only works with Rails-ish projects and with Jasmine & Jammit. I'm selfish.

### Models

`backbone-generate model Admin::User` creates an AdminUserModel object in:

* `public/javascripts/models/admin/user.js`
* `spec/javascripts/models/admin/user_spec.js`

### View

`backbone-generate view Admin::User` creates an AdminUserView object in:

* `public/javascripts/views/admin/user.js`
* `spec/javascripts/views/admin/user_spec.js`
* `app/views/admin/user.jst`

### Collection

`backbone-generate collection Admin::User` creates an AdminUsersCollection object in:

* `public/javascripts/collections/admin/users.js`
* `spec/javascripts/collections/admin/users_spec.js`

Please add more and make it more friendly with things that are not Rails, Jasmine, and Jammit!

