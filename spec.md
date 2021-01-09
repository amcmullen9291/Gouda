# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app 
#yes
- [x] Use ActiveRecord for storing information in a database 
#yes
- [x] Include more than one model class (e.g. User, Post, Category) #Employee Class, Hours Class, and Weeks Class
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts) 
#Employee Class has_many :hours
#Employee Class has_many :weeks
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User) 
#Week Class belongs_to :Employee
#Hour Class belongs_to :Employee
- [x] Include user accounts with unique login attribute (username or email) 
#randomly generated ID number plus User chosen password
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying 
#CRUD routes for Hours 
- [x] Ensure that users can't modify content created by other users
- [x] Include user input validations
#required="required" field validations
- [ ] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code 
#yes

Confirm
- [x] You have a large number of small Git commits 
#84 commits
- [x] Your commit messages are meaningful 
#later commits are detailed
- [x] You made the changes in a commit that relate to the commit message #yes
- [x] You don't include changes in a commit that aren't related to the    commit message 

#limited space but, yes
