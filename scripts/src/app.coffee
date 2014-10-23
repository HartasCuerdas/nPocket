express = require 'express'
pocket = require 'pocket-sdk'

consumer_key = ''
pocket.init(consumer_key, 'http://127.0.0.1:4000/pocket/callback')

app = express()

app.use require('cookie-parser')()
app.use pocket.oauth()
app.get '/', (req, res) -> res.redirect('/pocket/authorize')
app.get '/items', (req, res) ->
  token = req.cookies['access_token']
  return res.json([]) unless token
  pocket.get
    access_token: token
    state: 'unread'
  , (err, ret) ->
    res.json(err or ret)


app.listen(4000)

console.log 'Visit http://127.0.0.1:4000/'