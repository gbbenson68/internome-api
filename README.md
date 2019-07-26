Internome API
=============
Introduction
------------
The best way to increase endurance in any given physical activity is via interval training: short bursts of intense exercise punctuated by perios of fairly low-intesity training. As a drummer, I have been frustrated by the lack of resources available to help me get better as a player.

It is hoped that this application will remedy at least some of the this frustration. The basic idea is to have the application play metronomic clicks at increasing and decreasing tempo, allowing the practitioner to practice ruduments or patterns (or scales) to intervals to increase endurance and dexterity.

In general, the user should be allowed to specify a tempo range (minimum and maximum tempo) and a duration, and the tempo would be varied from low to high and back to low again via a sinusoidal function. In the future, the user should also be able to specify the number of intervals and also the interval type (sinusoid vs square wave, for example). Additionally, the intervals should be displayed so that the user can better visualize at what tempo they are playing and what they will be playing next. 

For more information on interval training, please visit the Wikipedia site [here](https://en.wikipedia.org/wiki/Interval_training).

For more information about drumming please visit the [Percussive Arts Society](https://www.pas.org/). NOTE: ALthough a lot of their resources used to be free (to use), you now unfortunately have to be a member to utilize many of their resources.

For notes about the Client, please see the README [here](https://github.com/gbbenson68/internome-client).

Relevant Links
--------------
*   The **client repository** can be found [here](https://github.com/gbbenson68/internome-client).
*   The **deployed client** can be found [here](https://gbbenson68.github.io/internome-client/).
*   The **deployed API** can be found [here](https://tranquil-everglades-98645.herokuapp.com/). _(NOTE: Due to the way Heroku works, you will only get be able to get the following response:_ ```Cannot GET /```_.)_

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

*   The development of the API end points was somewhat straighforward, as there was only one resource other than USERS to implement. I also had a very clear idea of what I wanted to happen before coding began, so implementation went rather smoothly. I knew, for example, that I wanted GET, POST, PATCH and DELETE routes; with the GET routes being a SHOW of a given resource and an INDEX of only those profiles owned by the given user.

*   There is very little logic on the back end - the routes were kept as simple as possible to keep the application logic in the upstream application. The most difficult part was making sure that the INDEX GET retrieved only the profiles owned by the given user. Additionally, since it is implemented in JavaScript using Mongoose and MongoDB, it can be easily and quickly extended.

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

Installation and Deployment Instructions
-------------------------
Before you attempt to install and deploy this API, please ensure that you have the following software installed on your machine of choice (NOTE: These instructions apply mainly for Linux or macOS X systems. For Windows systems, you may want to think about [Cygwin](http://www.cygwin.com/) or [Git for Windows](https://gitforwindows.org/).):
*   git CLI - installation instructions [here](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).
*   [Node.js](https://nodejs.org/en/download/) - contains the Node Package Manager (npm).
*   [MongoDB](https://www.mongodb.com/download-center/community) - Only necessary for development in a local environment.
*   [Heroku](https://devcenter.heroku.com/articles/git) - read these instructions if you wish to deploy the API on Heroku.
*   C/C++ compiler - most modern computer languages are actually implemented in C or C++, so it would be wise to install a C/C++ compiler, the most popular being [gcc/g++](https://gcc.gnu.org/) on Linux and macOS X.
*   [curl](https://curl.haxx.se/download.html) - to test the installation, you can use the provided ```curl``` scripts.

1.  From this GitHub repository, [fork](https://help.github.com/en/articles/fork-a-repo) and [clone](https://help.github.com/en/articles/cloning-a-repository) into your local environment.
2.  Change into (```cd```) the root directory of the cloned repository and execute ```npm install```. This will install any required Node.js modules. The npm is fairly verbose, so if there are any missing modules, you will be notified.
3.  For local installations, ensure that you have ```nodemon``` installed: ```npm install -g nodemon```. You can then run the server in a local environment by running ```nodemon server.js | tee -a nodemon.log```.
4.  To deploy on Heroku (assuming that you first have a Heroku account), make sure that you've deployed your code as per the directions in the lin above. Additionally, you will need to set up a MongoDB sandbox. To do so, execute ```heroku addons:create mongolab:sandbox``` from the root directory.
5.  To test the installation, run the provided curl scripts.


Known Bugs and To-dos
---------------------
_Feel free to contact me at guy dot b dot benson at gmail dot com if you've found a bug, or have a suggestion about functionality. Please include an appropriate subject so I don't think that it's spam!_

#### Known Bugs
*   There are no bugs on the Back End, as far as I'm aware.

#### To-Dos
*   I would like to add fields for ```numItervals``` and ```intervalType``` at some stage, which would be used to specify the number of intervals (peaks) in the routine and what kind of routne - sinusoidal vs. square wave, for example.

_Please check the experimental branch for the latest goings-on!_

About Me
--------
I am an aerospace engineer by education and a software engineer by experience. I’ve always been intrigued by using software to solve practical problems, whether it be something as simple as providing an HTML interface for viewing invoices or something as complex as modeling the fluid flow through a rocket thruster. I recently decided to upgrade my skill set with an immersive software engineering program at General Assembly, and I am now taking my ambitions to the next level. I am eager and excited to take on those sometimes seemingly unsurmountable challenges that affect us all.
