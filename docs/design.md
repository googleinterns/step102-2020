# STEP Beach Pod Project Design Doc - Starfish
##### Authors: Andres Holguin, Aradhya Bansal, Keely Wan
##### Reviewers: nkelman, colettet
##### Originally Proposed: 2020-06-19 / Last Updated: 2020-08-06

## Objective

### Problem:
A lot of course notes go to waste. Seeing other people’s notes could be helpful to students for a number of reasons including being able to:
- Improve one’s own note taking skills
- Extract additional insights from course material
- Catch up on missed lectures.

In addition, great collaboration tools like Google Docs aren’t used often enough in the context of collaborative learning and more specifically, collaborative note taking. 
When students are able to take notes together and view each other's contributions, it allows them to learn from each other and even gives the instructor a way to check for understanding, but this isn’t happening enough. 

### Goals:
- Encourage the sharing of quality course notes 
- Make learning more collaborative
- Provide an easy to use platform to create Google Docs and upload PDF notes
- Help students identify the notes that are most relevant to them, quickly
- Help students struggling with course material access additional resources to aid their studies

### NON-Goals:
- Encourage cheating
- Create a platform where students can ask questions about courses (this is where group chats already shine)
- Charge students for these notes
- Create a platform where students can rate and review courses and professors

## Background

Digital note-taking is becoming increasingly popular seen through the usage of tools like 
Google Docs, Microsoft OneNote, Evernote, Notion, GoodNotes, Nebo, and Notability; 
yet, these notes aren’t shared often enough with others. 
A  [gamified](https://en.wikipedia.org/wiki/Gamification) platform could encourage users to be more active and to engage with the community. 
Social media platforms like Reddit have shown how increasing gamification also increases user engagement.

### User Profiles

Bob is a college student who takes notes on his iPad for his computer science courses and other various online courses. 
Bob’s friends and students younger than him often ask if they can see his notes because Bob writes excellent notes. 
Bob manages to share these notes with the people who ask him, but it makes Bob wonder if any other people would benefit from his notes. 
Bob does not know where to share or put his notes so they can be viewed publicly.

John is a super collaborative person who enjoys working with his peers. 
He is tired of taking notes on his own, and wishes that there was a way for him to work collaboratively with friends to take shared notes. 
More importantly, he wants a quick and easy template that everyone can follow so they can create consistent and helpful notes.

Jane is a college student who doesn’t like to take notes for her classes. 
She always bothers her friends who are reluctant to share their notes. 
She doesn’t know where else to go to see high quality notes for her classes. 
She also doesn’t know how to learn to write better notes because there aren’t many public notes available.

## Requirements and Scale

This section will cover what needs to be done to meet the requirements for the platform’s users, which are also defined here.

### Users
The platform’s primary users will be college students like Bob, John, and Jane described in the Background section. 
The solution to Bob’s problem would be a public and gamified platform where he is encouraged to share his notes. 
The solution to John’s problem would be a real-time collaborative note taking platform with built-in templates that is seamlessly integrated with another public platform to find and share notes. 
The solution to Jane’s problem would be a platform that gives her free access to high quality notes for her specific courses.

### Essential Requirements
The platform will necessarily allow users to 
**Share** notes, 
**Search** for notes, 
**Save** the notes for later use, 
and **Incentivise** users to keep using the platform.

#### Share
Users will be able to share any notes they may have on hand by either uploading a PDF or generating a Google Doc that is automatically linked to the platform. 
As part of the sharing process, users can specify certain labels to help make their notes more identifiable. 
The labelling of the School and Course for which the notes are relevant will be heavily encouraged. 
Extra labels, called “miscellaneous labels”, such as the professor teaching the course or the topic being covered, will be suggested by the platform based on recent user activity, but users can also add their own labels.

#### Search
Users can search for notes by the university name and/or course code. Search results will be sorted by the platform by taking into account the number of users that have saved a particular note. 
To encourage growth in the platform, varied search results will be displayed such as “Most Saved”, and trending notes for different time spans including all-time, this month, this week, and today. 
Users can also see the most “Recently Posted” notes. To help users narrow down their search further, they will be able to apply active filters on the frontend that filter search results by note titles and miscellaneous labels.

#### Save
"Save" as a feature is an umbrella term for users being able to a) publicly favorite their notes and b) download notes to save for later. 
Each note tile will have a button users can click to save that particular note under their profile’s “Favorite Notes” tab. Users can also simply download the notes straight away and save them for personal use later. 
The amount of times users on the platform “save” (either publicly favorite or download) a particular note will be correlated with the “rating” of that particular note and influence how high up that note is displayed in search results. 
When notes get saved, the author’s total “prestige” on the platform goes up.

#### Incentivise
The platform incentivises users to share their notes through a points system wherein users can earn prestige points as the notes they share are saved by other users on the platform. 
The hope is that, eventually, prestige points will become redeemable for great rewards. 
Users should also be able to publicly view how many prestige points other users have which will encourage them to earn more points themselves and make more informed decisions around which author’s notes to use.

### Technical Requirements
- Handle up to 10,000 (average number of students enrolled at a “medium-sized” [college](https://www.collegedata.com/en/explore-colleges/the-facts-on-fit/features-that-set-colleges-apart/college-size-small-medium-or-large/) users at launch with the ability scale up to millions in the future
- Host multiple binary files (PDFs) and links (GDocs) for each user
    - Google Docs will be hosted on the user’s personal Google Drive
    - Assuming each of a million users hosts on average 25 files per year on the platform, assuming an average size of 200 KB, total storage capacity would need to increase by ~5TB per year

## Design Ideas
The project will follow the Model-View-Controller (MVC) framework and separate the application into three main logical components: Model, View, and Controller. 
This allows for clear separation of application tasks like business logic, UI logic, and input logic, making it easy for the team to work on separate tasks in parallel. 
The MVC framework also allows for easy and frictionless testability and since it’s a common and standard design pattern, it’s really easy for new developers to onboard, increasing the overall scalability of the application.

The chrome extension is an additional component of the project that is separate from the MVC architecture of the main platform.

### Storing Data
![Entity Rlationship Diagram for SQL Database](/docs/assets/sql_er.png)
###### Entity Relationship Diagram for SQL Database
A SQL database, particularly MySQL hosted on Google Cloud SQL, can be used to store and track all data. 
The entity relationship diagram describing the important entities and their associated data is shown in the figure above. 
SQL is preferred over a NoSQL alternative because of how structured the platform’s data is and how easily the important data within the platform is categorized into different entities, 
the primary entities being Users, Notes, and Labels. The “favorite_notes” and “misc_note_labels” tables are bridge tables that keep track of many-to-many relationships like the notes a user has saved by “favoriting” and the misc labels attached to a single note. 

Instances of model classes for Users, Notes, and Labels can be built up with the [builder design pattern](https://en.wikipedia.org/wiki/Builder_pattern#:~:text=The%20builder%20pattern%20is%20a,Gang%20of%20Four%20design%20patterns.) using data retrieved from the SQL database using controller classes for each table. 
These objects can be passed between the client and the server as JSON. 
The standard methods on the controller classes will be to insert and delete rows, but additional methods can easily be added for more complex SQL queries, 
for example, like a method to get all school and course labels, to retrieve the notes most favorited in a given time span, or to get the most used misc label.

### Logging In
Instead of creating user accounts on the webapp and handling sensitive data, users can be authenticated using Google OAuth 2.0 with their Google accounts. 
This will all be handled by a navigation bar component which will appear on every page. 
When a user is logged in, they should be able to upload a note or view their profile from the navigation bar. 
Cookies and session management can also be implemented to ensure users can persist their sign in between browsing sessions.

### Creating a Google Doc
A Chrome extension would allow users to quickly generate a Google Doc without needing to access the web application. 
The Google Docs will be created on the user’s own Google Drive instead of a shared Google Drive across the platform. 
Like the webapp, the Chrome extension will also need to use OAuth to access Drive. 
In order to simplify the process of creating a Google Doc, the chrome extension will only have three inputs - title, school, and course. 
Once the user clicks generate, the chrome extension should make a copy of an existing notes template Google Doc in the user’s Google Drive 
and add the new document’s information such as the unique document ID to the database with a POST request to a Java Servlet so it can be viewed on the Starfish platform. 
It should then open the Google Doc in a new tab.

### Uploading Notes
![Upload Form](/docs/assets/upload_form.png)

Google Cloud BlobStore can be used as a file storing solution to host PDF notes uploaded directly to the platform and the SQL database can keep track of the “blobkey” to access and serve these notes to the client. 
When a user uploads a note, a POST request can be made to a Java Servlet which handles adding all new labels to the labels database table, adding the note data to the notes table, and making associations between notes and miscellaneous labels for that note by inserting rows to the misc_notes_label table.

### Previewing and Rating Notes
![Note Preview](/docs/assets/note_preview.png)
When a user clicks a note preview card on the main platform, it should open a modal window similar to above on which users can preview the note (whether its a PDF or Google Doc), 
favorite the note so as to be able to view it in their own profile later, or download the note directly to their computer. 
They can also report the note if they think there is any inappropriate content visible.

When a user favorites or downloads a note, the author’s total points, which should be visible by hovering over the author’s name in the note preview modal, should increase by a set amount. 
This can be handled by making a POST request to a Java Servlet everytime that a note gets saved and incrementing the author’s total points in the database depending on the event (favorite or download). 
Different events for user point modification like “Favorite” and “Download” can be stored inside a Java enum and additional events can easily be added in the future if needed.

### Determining Trending Notes in a given Time span and Searching
Since the database keeps track of the date that a row in the favorite_notes table is inserted, ordering all notes by those that are most popular, 
determined by the number of favorites they have past a given date range, can be easily accomplished with a single SQL query:
```
SELECT * FROM notes AS a
LEFT JOIN (SELECT note_id, COUNT(*) AS count
	FROM favorite_notes
	WHERE date >= ?
	GROUP BY note_id) AS b
ON a.id = b.note_id
ORDER BY count DESC, id;
```
The same SQL query can be used to search for notes and get a response in order of what’s most trending in a given time span simply by adding a WHERE clause to the query:

```WHERE school = ? AND course = ?```

## Alternatives Considered
Instead of organizing all the shared notes by the school and course labels, one alternative that was considered was creating individual pages for each course. 
This way, a user could find all the notes related to the class on the course page. Users could also share tips/external resources on the course page. 
However, this forces users to go through the additional step of creating a course page for new courses before they can upload their notes, which could discourage them from sharing their notes on the platform. 
In addition, the tips and external resources could just be included in the notes that are being shared.

One additional consideration for the organization of the notes was to require both the school and course label to be specified. 
However, this reduces the flexibility contributors have when sharing their notes. 
For example, a set of notes called “How to make friends at MIT” would be related to a school (MIT), but not a particular course. 
By making the course label required, not only would the contributor have difficulty deciding what course to put it under, but users would also have difficulty searching for it.

Another design consideration was how users would rate the notes. 
One idea was for users to rate the courses themselves, but this deviates from the main goal and audience of the app. 
This app is intended for students who are currently taking the course and trying to succeed, not students who are trying to decide whether they should take the course. 
In addition, there are already many apps dedicated to course and professor reviews. 
There were several rating systems considered for rating the course notes such as a like/dislike button or a five star rating system. 
With these systems, users have to actively make a judgment on the quality of the note which could create a negative space on the platform that could discourage users from sharing more notes when they see dislikes or zero stars. 
