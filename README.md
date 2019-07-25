Internome API
=============
Introduction
------------
The best way to increase endurance in any given physical activity is via interval training: short bursts of intense exercise punctuated by perios of fairly low-intesity training. As a drummer, I have been frustrated by the lack of resources available to help me get better as a player.

It is hoped that this application will remedy at least some of the this frustration. The basic idea is to have the application play metronomic clicks at increasing and decreasing tempo, allowing the practitioner to practice ruduments or patterns (or scales) to intervals to increase endurance and dexterity.

For more information about drumming please visit the [Percussive Arts Society](https://www.pas.org/). NOTE: ALthough a lot of their resources used to be free (to use), you now unfortunately have to be a member to utilize many of their resources.

For notes about the Client, please see the README [here](https://github.com/gbbenson68/internome-client).

Technologies Used
-----------------
The web application back end was written with the help of and utilizing the following technologies:
*   Express.js
*   Mongoose
*   MongoDB
*   JavaScript
*   Node.js
*   git/GitHub
*   Atom
*   Hosted by Heroku.

_This application was developed on Ubuntu 18.04.2 LTS. No Microsoft developers were harmed during the making of this application._

Development and Planning (Back End Notes)
-----------------------------------------
For the greater description of overall planning and development, please see the [Development and Planning](https://github.com/gbbenson68/internome-client#development-and-planning) section in the Client README. Herein contains only specific notes regarding the Back End.

*   The development of the API end points was fairly straighforward, as there was only one resource other than USERS to implement. I also had a very clear idea of what I wanted to happen before coding began.

*   There is very little logic on the back end - the routes were kept as simple as possible to keep the application logic in the upstream application. However, since it is implemented in JavaScript using Mongoose and MongoDB, it can be easily and quickly extended.

Entity-Relationship-Diagram
---------------------------
The basic ERD for this is below:

![Imgur](https://i.imgur.com/AuCVR6A.png)

Resource Structure and Desription
---------------------------------
The ```USERS``` resource, in its final form, has the structure as below (not including the ):

| Field          | Type   | Notes          |
|----------------|--------|----------------|
| _id            | Object | Mongo ObjectID |
| email          | String |                |
| hashedPassword | String |                |
| token          | String |                |
| updatedAt      | Date   | ISO Date       |
| createdAt      | Date   | ISO Date       |

The ```PROFILES``` resource, in its final form, has the structure as below:

| Field     | Type   | Notes          |
|-----------|--------|----------------|
| _id       | Object | Mongo ObjectID |
| name      | String |                |
| minTempo  | Number |                |
| maxTempo  | Number |                |
| owner     | Object | Mongo ObjectID |
| updatedAt | Date   | ISO Date       |
| createdAt | Date   | ISO Date       |

API End Points
--------------
| Verb   | URI Pattern            | Controller#Action |
|--------|------------------------|-------------------|
| POST   | `/sign-up`             | `users#signup`    |
| POST   | `/sign-in`             | `users#signin`    |
| DELETE | `/sign-out`            | `users#signout`   |
| PATCH  | `/change-password`     | `users#changepw`  |
| GET    | `/profiles`            | `profiles#index`  |
| POST   | `/profiles`            | `profiles#create` |
| GET    | `/profiles/:id`        | `profiles#show`   |
| PATCH  | `/profiles/:id`        | `profiles#update` |


Basic Directory Structure
-------------------------
Below are listed the _relevant_ directories and files for the application - not all objects are listed.
```
server.js
```
This is the server code for the API itself.

```
app/models
```
*   ```user.js``` - holds the USER model

*   ```profile.js``` - holds the PROFILE model

```
app/routes
```
*   ```user_routes.js``` - holds the RESTful USER routes

*   ```profile_routes.js```- holds the RESTful PROFILE routes

```
config
```
*   ```db.js``` - holds configuration details for Mongoose and MongoDB

```
curl-scripts/auth
```
*   ```sign-up.sh``` - used to test ```/sign-up``` route

*   ```sign-in.sh``` - used to test ```/sign-in``` route

*   ```sign-out.sh``` - used to test ```/sign-out``` route

*   ```change-password.sh``` - used to test ```/change-password``` route

```
curl-scripts/profiles
```
*   ```index.sh``` - used to test the ```/profiles``` GET route for all profiles of a given user.

*   ```show.sh``` - used to test the ```/profiles``` GET route for a given profile of a given user.

*   ```create.sh``` - used to test the ```/profiles``` POST route

*   ```update.sh``` - used to test the ```/profiles/:id``` PATCH route

*   ```destroy.sh``` - used to test the ```/profiles/:id``` DELETE route

```
lib
```
*   ```auth.js``` - holds authentication library methods

*   ```custom_errors.js``` - holds library objects for custom erros

*   ```error_handler.js``` - holds library methods for custom errors

*   ```remove_blank_fields.js``` - holds library methods for forms


Known Bugs and To-dos
---------------------
_Feel free to contact me at guy dot b dot benson at gmail dot com if you've found a bug, or have a suggestion about functionality. Please include an appropriate subject so I don't think that it's spam!_

#### Known Bugs
*   There are no bugs on the Back End, as far as I'm aware.

#### To-Dos
*   I would like to add fields for numItervals and intervalType at some stage, which would be used to specify the number of intervals (peaks) in the routine and what kind of routne - sinusoidal vs. square wave, for example.

_Please check the experimental branch for the latest goings-on!_

About Me
--------
I am an aerospace engineer by education and a software engineer by experience. I’ve always been intrigued by using software to solve practical problems, whether it be something as simple as providing an HTML interface for viewing invoices or something as complex as modeling the fluid flow through a rocket thruster. I recently decided to upgrade my skill set with an immersive software engineering program at General Assembly, and I am now taking my ambitions to the next level. I am eager and excited to take on those sometimes seemingly unsurmountable challenges that affect us all.
