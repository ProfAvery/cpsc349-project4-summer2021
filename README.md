# Mockroblog - Mock APIs for Microblogging

**Q.** What's the minimum amount of code needed to mock up a miniature
       clone of Twitter?

**A.** How comfortable are you with SQL?

## Getting started

Use the following commands to get up and running:

```shell-session
$ sudo apt update                               # updates package index
$ sudo apt install --yes ruby-foreman sqlite3   # used to manage Procfile and database
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

| Operation     | HTTP Method | URL                            |
|---------------|-------------|--------------------------------|
| Create a user | POST        | `http://localhost:5000/users/` |

```json
{
    "username": "tester",
    "email": "test@example.com",
    "password": "testing"
}
```


| Operation               | HTTP Method | URL                            |
|-------------------------|-------------|---------------------------------------------------------------------|
| Check a user's password | GET         | `http://localhost:5000/users/?username=ProfAvery&password=password` |
| Start following a user  | POST        | `http://localhost:5000/followers/`                                   |

```json
{
    "follower_id": 4,
    "following_id": 2
}
```


| Operation              | HTTP Method | URL                            |
|------------------------|-------------|---------------------------------------------------------------------|
| Stop following a user  | DELETE      | `http://localhost:5000/followers/6`                                 |

Note that `6` is the `id` of the entry in the `followers` table, not the `user_id` of either user.


| Operation                  | HTTP Method | URL                            |
|----------------------------|-------------|---------------------------------------------------------------------|
| Retrieve a user's timeline | GET         | `http://localhost:5000/followers/6`                                 |
| Search posts for a keyword | GET         | `http://localhost:5000/posts/?text=%%covid%%`                       |

## Other features

This version of the [Mockroblog database](./api/mockroblog.sql) includes
additional data not included in
[Project 3](https://github.com/ProfAvery/cpsc349-project3):

 * Likes
 * Direct Messages
 * Polls

The REST API exposed by `sandman2` also allows additional types of queries
against existing data. See
[the documentation](https://pythonhosted.org/sandman2/interacting.html) for
details.
