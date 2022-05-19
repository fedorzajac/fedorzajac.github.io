# Setting up a github personal page

- create/open a github account
- setup personal token
- in `.git/config` add the token to repository url `url=https://*****your_token****@github.com/fedorzajac/fedorzajac.github.io.git` 

   e.g.
 
   `url=https://ghp_4bcd3fgHIJklmn0pqR5Tuvwxyz@github.com/fedorzajac/fedorzajac.github.io.git`
- create a new public repository named username.github.io, where username is your username (or organization name) on GitHub. 
- clone repository: `git clone https://github.com/username/username.github.io`
- add some files like `index.html` and save changes: 
```bash git add .
git commit -m 'initial commit'
git push origin master
```
## references

 - [github pages][gh]
 - [personal access token][token]


[token]: <https://docs.github.com/en/enterprise-server@3.5/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token>

[gh]: <https://pages.github.com/>