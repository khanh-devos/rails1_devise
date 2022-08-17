# Friend List App

Hello, my name is Khanh.

This is my ruby on rails "Friend List"

upDated 17/8/2022.
technique usage:

- devise: user
- model Friend CRUD, belong to|dependent on model User.
- Postgresql database
- redis for "Active Jobs" sidekiq for sending email of reset-password-instruction
- custom Validation(friend email, must "check" otherwise cannot create new freind)

- Active Storage: avatar (preview supported)
- responsive layout (3 levels: 1000px, 800px, 600px)
- websocket checking appearance status

Thanks for reading
