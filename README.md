# Curated

Curated is an open source & data platform consisting of a curated dataset of GitHub comments ranked by user reactions for popular repositories. The goal is to provide easy access to meaningful information for anyone interested in learning best practices and development history of popular open source projects.

## Architecture

Curated has a simple ecosystem where **api** and **scheduler** are two distinct processes sharing **domain** logic while interfacing with different external components: user interfaces and data operations, respectively.

```
api users
         \
mobile ----> api -> domain <- scheduler -> octograph
         /            |                       |
web                postgres                 github
```

The following repositories compose the project ecosystem:

* **api** - open data endpoints
* [domain](https://github.com/curated/domain) - models and persistence
* **mobile** - open data mobile app
* [octograph](https://github.com/curated/octograph) - github graphql client
* **scheduler** - github data workers
* **web** - open data responsive app

Additional repositories supporting development:

* [coding-standards](https://github.com/curated/coding-standards) - shared configurations across all repositories to help ensure quality and consistency
