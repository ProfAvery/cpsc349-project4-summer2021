# Mockroblog - Mock APIs for Microblogging

**Q.** What's the minimum amount of code needed to mock up a miniature
       clone of Twitter?

**A.** How comfortable are you with SQL?

## Getting started

Use the following commands to get up and running:

```shell-session
$ sudo apt update                               # updates package index
$ sudo apt install --yes ruby-foreman sqlite2   # used to Procfile and database
$ python3 -m pip install sandman2               # used to expose API
$ cd api
$ make                                          # creates database
$ foreman start                                 # starts back-end
$ cd ..
$ npm start                                     # starts front-end
```

You can examine the data using the `sandman2`
[Admin Interface](http://localhost:5000/admin).

## Tools

See the following references for more information:

* [sandman2](https://github.com/jeffknupp/sandman2)
* [make](https://en.wikipedia.org/wiki/Makefile)
* [sqlite3](https://sqlite.org/cli.html)
* [foreman](https://ddollar.github.io/foreman/)


# Sample API calls

To create a user:

POST `http://localhost:5000/users/`

```json
{
    "username": "tester",
    "email": "test@example.com",
    "password": "testing"
}
```


To check a user's password:

`http://localhost:5000/users/?username=ProfAvery&password=password`


To start following a user:

POST to `http://localhost:5000/followers/`

```json
{
    "follower_id": 4,
    "following_id": 2
}
```


To stop following a user:

DELETE `http://localhost:5000/followers/6`

*(Note that `6` is the `id` of the entry in the `followers` table, not the
`user_id` of either user.)*


To retrieve a user's timeline:

`http://localhost:5000/posts/?user_id=1&sort=-timestamp`


Search posts for a keyword:

`http://localhost:5000/posts/?text=%%covid%%`

