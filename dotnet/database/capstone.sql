USE master
GO

--drop database if it exists
IF DB_ID('final_capstone') IS NOT NULL
BEGIN
	ALTER DATABASE final_capstone SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE final_capstone;
END

CREATE DATABASE final_capstone
GO

USE final_capstone
GO

--create tables
CREATE TABLE users (
	user_id int IDENTITY(1,1) NOT NULL,
	username varchar(50) NOT NULL,
	password_hash varchar(200) NOT NULL,
	salt varchar(200) NOT NULL,
	user_role varchar(50) NOT NULL
	CONSTRAINT PK_user PRIMARY KEY (user_id)
)

CREATE TABLE deck (
	deck_id int IDENTITY (101, 1) NOT NULL,
	user_id int NOT NULL,
	deck_name varchar(50) NOT NULL,
	deck_description varchar(100) NOT NULL,
	isPublic bit DEFAULT(0) NOT NULL,
	CONSTRAINT PK_deck PRIMARY KEY (deck_id),
	CONSTRAINT FK_deck FOREIGN KEY (user_id) REFERENCES users(user_id)
)

CREATE TABLE card (
	card_id int IDENTITY (1001,1) NOT NULL,
	card_front varchar(200) NOT NULL,
	card_back varchar(500) NOT NULL,
	card_image varchar(250) DEFAULT('') NOT NULL,
	user_id int NOT NULL,
	isPublic bit DEFAULT(0) NOT NULL,
	CONSTRAINT FK_card FOREIGN KEY (user_id) REFERENCES users(user_id),
	CONSTRAINT PK_card PRIMARY KEY (card_id)
)

CREATE TABLE tag(
	tag_id int IDENTITY(2001,1) NOT NULL,
	tag_name varchar (50) NOT NULL,
	CONSTRAINT PK_tag PRIMARY KEY (tag_id)
)

CREATE TABLE card_tag(
	tag_id int NOT NULL,
	card_id int NOT NULL,
	CONSTRAINT PK_card_tag PRIMARY KEY (tag_id, card_id),
	CONSTRAINT FK_ct_card FOREIGN KEY (card_id) REFERENCES card(card_id),
	CONSTRAINT FK_ct_tag FOREIGN KEY (tag_id) REFERENCES tag(tag_id)
	
)

CREATE TABLE card_deck(
	card_id int NOT NULL,
	deck_id int NOT NULL,
	CONSTRAINT PK_card_deck PRIMARY KEY (card_id, deck_id),
	CONSTRAINT FK_card_id FOREIGN KEY (card_id) REFERENCES card(card_id),
	CONSTRAINT FK_deck_id FOREIGN KEY (deck_id) REFERENCES deck(deck_id)
)

CREATE TABLE submitted_deck(
	sub_id int IDENTITY (3001,1) NOT NULL,
	deck_id int NOT NULL,
	CONSTRAINT PK_submitted PRIMARY KEY (sub_id),
	CONSTRAINT FK_submitted_deck FOREIGN KEY (deck_id) REFERENCES deck(deck_id)
)


--populate default data
-- user/password
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('user@email.com','Jg45HuwT7PZkfuKTz6IB90CtWY4=','LHxP4Xh7bN0=','user'); --1

-- admin/password
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('admin@email.com','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','admin'); --2

INSERT INTO users (username, password_hash, salt, user_role) VALUES ('christie@email.com','3vzKJie2mWj1w+bhypXrw9gCmZs=','zPsuX5l8uEE=','user'); --3
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('maggie@email.com','J7SOHtPJG5k4M1VGCnM1lSNxNw0=','K42Yxzk5N2k=','user'); --4
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('nick@email.com','zPMw3Sd47iyNbuZzvpHwjjbMJNg=', 'YTyhrq4+5VI=', 'user'); --5
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('sam@email.com','XsEiS6F75bbCSN33tcKuPNkrNe0=','QMdy+AEe9nc=','user'); --6

INSERT INTO tag (tag_name) VALUES ('OOP'); --2001
INSERT INTO tag (tag_name) VALUES ('SQL'); --2002
INSERT INTO tag (tag_name) VALUES ('vue.js'); --2003
INSERT INTO tag (tag_name) VALUES ('testing'); --2004
INSERT INTO tag (tag_name) VALUES ('loops and arrays in C#'); --2005
INSERT INTO tag (tag_name) VALUES ('Collections in C#'); --2006
INSERT INTO tag (tag_name) VALUES ('CSS'); --2007
INSERT INTO tag (tag_name) VALUES ('html'); --2008
INSERT INTO tag (tag_name) VALUES ('javascript'); --2009
INSERT INTO tag (tag_name) VALUES ('API'); --2010
INSERT INTO tag (tag_name) VALUES ('web services'); --2011
INSERT INTO tag (tag_name) VALUES ('coding basics'); --2012
INSERT INTO tag (tag_name) VALUES ('git'); --2013
INSERT INTO tag (tag_name) VALUES ('shell commands'); --2014
INSERT INTO tag (tag_name) VALUES ('Ohio birds'); --2015
INSERT INTO tag (tag_name) VALUES ('big cats'); --2016
INSERT INTO tag (tag_name) VALUES ('small cats'); --2017
INSERT INTO tag (tag_name) VALUES ('paintings'); --2018



--insert data into Christie's profile user_id 3
INSERT INTO deck (user_id, deck_name, deck_description) VALUES (3, 'Object Oriented Programming', 'Cards related to OOP principles'); --101
INSERT INTO deck (user_id, deck_name, deck_description, isPublic) VALUES (3, 'Data types, arrays, and collections in C#', '', 0); --102
INSERT INTO deck (user_id, deck_name, deck_description) VALUES (3, 'C# Coding basics', 'Basic coding terminology'); --103
INSERT INTO deck (user_id, deck_name, deck_description, isPublic) VALUES (3, 'git and shell', 'git and shell definitions and commands', 0); --104


INSERT INTO card (card_front, card_back, user_id) VALUES ('What are the 3 principles of OOP?', 'Encapsulation, Inheritance, and Polymorphism', 3); --1001
INSERT INTO card_deck (card_id, deck_id) VALUES (1001, 101);
INSERT INTO card_tag (tag_id, card_id) VALUES (2001, 1001);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is encapsulation?', 'Bundling of data with the methods that operate on that data, 
	or restricting of direct access to some of an objects components.', 3); --1002
INSERT INTO card_deck (card_id, deck_id) VALUES (1002, 101);
INSERT INTO card_tag (tag_id, card_id) VALUES (2001, 1002);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is inheritance?', 'Allows a child class to take on the properties of and methods defined
	in a parent class.', 3); --1003
INSERT INTO card_deck (card_id, deck_id) VALUES (1003, 101);
INSERT INTO card_tag (tag_id, card_id) VALUES (2001, 1003);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is polymorphism?', 'Allows different types of objects to be treated as the same type of thing
	within a program.', 3); --1004
INSERT INTO card_deck (card_id, deck_id) VALUES (1004, 101);
INSERT INTO card_tag (tag_id, card_id) VALUES (2001, 1004);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is a class?', 'The blueprint of an object that defines the properties and methods. 
	They are the embodiment of an object oriented programming.', 3); --1005
INSERT INTO card_deck (card_id, deck_id) VALUES (1005, 101);
INSERT INTO card_tag (tag_id, card_id) VALUES (2001, 1005);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is a method?', 'A reusable unit of code that may return a value.', 3); --1006
INSERT INTO card_deck (card_id, deck_id) VALUES (1006, 103);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1006);

INSERT INTO card (card_front, card_back, user_id, isPublic) VALUES ('What is the difference between a "for loop" and a "while loop"?', 'A "for loop" runs a 
	specific number of times. A "while loop" runs until a specified condition is false.', 3, 0); --1007
INSERT INTO card_deck (card_id, deck_id) VALUES (1007, 103);
INSERT INTO card_deck (card_id, deck_id) VALUES (1007, 102);
INSERT INTO card_tag (tag_id, card_id) VALUES (2005, 1007);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1007);

INSERT INTO card (card_front, card_back, user_id, isPublic) VALUES ('What is the difference between a "while loop" and a " do while loop"?', 'A "while loop" may never
	run if the conditional is false when it gets to the loop. A "do while loop" will always run at least once.', 3, 0); --1008
INSERT INTO card_deck (card_id, deck_id) VALUES (1008, 103);
INSERT INTO card_deck (card_id, deck_id) VALUES (1008, 102);
INSERT INTO card_tag (tag_id, card_id) VALUES (2005, 1008);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1008);

INSERT INTO card (card_front, card_back, user_id, isPublic) VALUES ('What is the difference between a value or primitive data type and a reference type?', 
	'A primitive type stores a value that consumes a fixed amount of memory. A reference type stores complex data and references a space on the heap 
	where the data is stored.', 3, 1); --1009
INSERT INTO card_deck (card_id, deck_id) VALUES (1009, 103);
INSERT INTO card_deck (card_id, deck_id) VALUES (1009, 102);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1009);

INSERT INTO card (card_front, card_back, user_id, isPublic) VALUES ('What is an object"?', 'An in-memory data structure that combines state and behavior into a 
	usable and useful abstraction. A collection of properties and methods.', 3, 0); --1010
INSERT INTO card_deck (card_id, deck_id) VALUES (1010, 101);
INSERT INTO card_deck (card_id, deck_id) VALUES (1010, 102);
INSERT INTO card_deck (card_id, deck_id) VALUES (1010, 103);
INSERT INTO card_tag (tag_id, card_id) VALUES (2001, 1010);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1010);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is the difference between overloading a method and overriding a method?', 'Overloading is 
	when have methods with the same name that take in different number and/or type of parameters. Overriding is when a child class creates a new version of
	a method from the parent class.', 3); --1011
INSERT INTO card_deck (card_id, deck_id) VALUES (1011, 103);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1011);

INSERT INTO card (card_front, card_back, user_id, isPublic) VALUES ('What is an array"?', 'A data structure consisting of elements that have the same type and is a 
	fixed size.', 3, 1); --1012
INSERT INTO card_deck (card_id, deck_id) VALUES (1012, 102);
INSERT INTO card_deck (card_id, deck_id) VALUES (1012, 103);
INSERT INTO card_tag (tag_id, card_id) VALUES (2005, 1012);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1012);

INSERT INTO card (card_front, card_back, user_id, isPublic) VALUES ('What is a shell?', 'A command line interface to the operating system that allows the user 
	to type commands, execute programs, and see responses as text.', 3, 1); --1013
INSERT INTO card_deck (card_id, deck_id) VALUES (1013, 104);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1013);

INSERT INTO card (card_front, card_back, user_id, isPublic) VALUES ('pwd', 'Command: print working directory. Shows the current directory', 3, 1); --1014
INSERT INTO card_deck (card_id, deck_id) VALUES (1014, 104);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1014);

INSERT INTO card (card_front, card_back, user_id, isPublic) VALUES ('ls -a', 'list all of the contents in current directory. (-a includes hidden files)', 3, 1); --1015
INSERT INTO card_deck (card_id, deck_id) VALUES (1015, 104);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1015);

INSERT INTO card (card_front, card_back, user_id, isPublic) VALUES ('cd', 'Change Directory: used to change the current working directory', 3, 1); --1016
INSERT INTO card_deck (card_id, deck_id) VALUES (1016, 104);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1016);

INSERT INTO card (card_front, card_back, user_id, isPublic) VALUES ('~ (tilde character)', 'designates the home directory', 3, 1); --1017
INSERT INTO card_deck (card_id, deck_id) VALUES (1017, 104);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1017);

INSERT INTO card (card_front, card_back, user_id, isPublic) VALUES ('.. (two dots)', 'reference to parent directory', 3, 1); --1018
INSERT INTO card_deck (card_id, deck_id) VALUES (1018, 104);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1018);

INSERT INTO card (card_front, card_back, user_id, isPublic) VALUES ('. (one dot)', 'self-reference to current directory', 3, 1); --1019
INSERT INTO card_deck (card_id, deck_id) VALUES (1019, 104);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1019);

INSERT INTO card (card_front, card_back, user_id, isPublic) VALUES ('mkdir', 'make a new directory', 3, 1); --1020
INSERT INTO card_deck (card_id, deck_id) VALUES (1020, 104);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1020);

INSERT INTO card (card_front, card_back, user_id, isPublic) VALUES ('touch <filename>', 'create an empty file with the specified name', 3, 1); --1021
INSERT INTO card_deck (card_id, deck_id) VALUES (1021, 104);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1021);

INSERT INTO card (card_front, card_back, user_id, isPublic) VALUES ('git init', 'Initializes and new Git repository. Creates a .git subdirectory in the current
	directory, which contains all of the necessary metadata for the repo.', 3, 1); --1022
INSERT INTO card_deck (card_id, deck_id) VALUES (1022, 104);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1022);

INSERT INTO card (card_front, card_back, user_id, isPublic) VALUES ('git status', 'Displays the state of the working directory and the staging area.', 3, 1); --1023
INSERT INTO card_deck (card_id, deck_id) VALUES (1023, 104);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1023);

INSERT INTO card (card_front, card_back, user_id, isPublic) VALUES ('git add', 'Adds changes in the working directory to the staging area. It tells Git that you want to 
	include updates on the next commit.', 3, 1); --1024
INSERT INTO card_deck (card_id, deck_id) VALUES (1024, 104);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1024);

INSERT INTO card (card_front, card_back, user_id, isPublic) VALUES ('git commit -m "message"', 'Commits the staged snapshot to the project history. Also records the 
	commit message', 3, 1); --1025
INSERT INTO card_deck (card_id, deck_id) VALUES (1025, 104);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1025);

INSERT INTO card (card_front, card_back, user_id, isPublic) VALUES ('git clone <remote repo link>', 'Clone an existing repository.', 3, 1); --1026
INSERT INTO card_deck (card_id, deck_id) VALUES (1026, 104);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1026);

INSERT INTO card (card_front, card_back, user_id, isPublic) VALUES ('git push origin main', 'used to send changes made to the "main" branch', 3, 1); --1027
INSERT INTO card_deck (card_id, deck_id) VALUES (1027, 104);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1027);

INSERT INTO card (card_front, card_back, user_id, isPublic) VALUES ('origin', 'Default name of remote repository that has been cloned to local machine.', 3, 1); --1028
INSERT INTO card_deck (card_id, deck_id) VALUES (1028, 104);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1028);


INSERT INTO card (card_front, card_back, user_id, isPublic) VALUES ('main', 'Default name of primary branch on local repository. Used to be called master', 3, 1); --1029
INSERT INTO card_deck (card_id, deck_id) VALUES (1029, 104);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1029);




--add data to Maggie's profile user_id 4

INSERT INTO deck (user_id, deck_name, deck_description) VALUES (4, 'Object Oriented Programming', 'Cards related to OOP principles'); --105
INSERT INTO deck (user_id, deck_name, deck_description) VALUES (4, 'Data types, arrays, and collections in C#', ''); --106
INSERT INTO deck (user_id, deck_name, deck_description) VALUES (4, 'C# Coding basics', 'Basic coding terminology'); --107
INSERT INTO deck (user_id, deck_name, deck_description) VALUES (4, 'git and shell', 'git and shell definitions and commands'); --108

INSERT INTO card (card_front, card_back, user_id) VALUES ('What are the 3 principles of OOP?', 'Encapsulation, Inheritance, and Polymorphism', 4); --1030
INSERT INTO card_deck (card_id, deck_id) VALUES (1030, 105);
INSERT INTO card_tag (tag_id, card_id) VALUES (2001, 1030);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is encapsulation?', 'Bundling of data with the methods that operate on that data, 
	or restricting of direct access to some of an objects components.', 4); --1031
INSERT INTO card_deck (card_id, deck_id) VALUES (1031, 105);
INSERT INTO card_tag (tag_id, card_id) VALUES (2001, 1031);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is inheritance?', 'Allows a child class to take on the properties of and methods defined
	in a parent class.', 4); --1032
INSERT INTO card_deck (card_id, deck_id) VALUES (1032, 105);
INSERT INTO card_tag (tag_id, card_id) VALUES (2001, 1032);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is polymorphism?', 'Allows different types of objects to be treated as the same type of thing
	within a program.', 4); --1033
INSERT INTO card_deck (card_id, deck_id) VALUES (1033, 105);
INSERT INTO card_tag (tag_id, card_id) VALUES (2001, 1033);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is a class?', 'The blueprint of an object that defines the properties and methods. 
	They are the embodiment of an object oriented programming.', 4); --1034
INSERT INTO card_deck (card_id, deck_id) VALUES (1034, 105);
INSERT INTO card_tag (tag_id, card_id) VALUES (2001, 1034);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is a method?', 'A reusable unit of code that may return a value.', 4); --1035
INSERT INTO card_deck (card_id, deck_id) VALUES (1035, 107);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1035);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is the difference between a "for loop" and a "while loop"?', 'A "for loop" runs a 
	specific number of times. A "while loop" runs until a specified condition is false.', 4); --1036
INSERT INTO card_deck (card_id, deck_id) VALUES (1036, 106);
INSERT INTO card_deck (card_id, deck_id) VALUES (1036, 107);
INSERT INTO card_tag (tag_id, card_id) VALUES (2005, 1036);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1036);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is the difference between a "while loop" and a " do while loop"?', 'A "while loop" may never
	run if the conditional is false when it gets to the loop. A "do while loop" will always run at least once.', 4); --1036
INSERT INTO card_deck (card_id, deck_id) VALUES (1037, 106);
INSERT INTO card_deck (card_id, deck_id) VALUES (1037, 107);
INSERT INTO card_tag (tag_id, card_id) VALUES (2005, 1037);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1037);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is the difference between a value or primitive data type and a reference type?', 
	'A primitive type stores a value that consumes a fixed amount of memory. A reference type stores complex data and references a space on the heap 
	where the data is stored.', 4); --1038
INSERT INTO card_deck (card_id, deck_id) VALUES (1038, 106);
INSERT INTO card_deck (card_id, deck_id) VALUES (1038, 107);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1038);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is an object"?', 'An in-memory data structure that combines state and behavior into a 
	usable and useful abstraction. A collection of properties and methods.', 4); --1039
INSERT INTO card_deck (card_id, deck_id) VALUES (1039, 105);
INSERT INTO card_deck (card_id, deck_id) VALUES (1039, 106);
INSERT INTO card_deck (card_id, deck_id) VALUES (1039, 107);
INSERT INTO card_tag (tag_id, card_id) VALUES (2001, 1039);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1039);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is the difference between overloading a method and overriding a method?', 'Overloading is 
	when have methods with the same name that take in different number and/or type of parameters. Overriding is when a child class creates a new version of
	a method from the parent class.', 4); --1040
INSERT INTO card_deck (card_id, deck_id) VALUES (1040, 107);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1040);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is an array"?', 'A data structure consisting of elements that have the same type and is a 
	fixed size.', 4); --1041
INSERT INTO card_deck (card_id, deck_id) VALUES (1041, 106);
INSERT INTO card_deck (card_id, deck_id) VALUES (1041, 107);
INSERT INTO card_tag (tag_id, card_id) VALUES (2005, 1041);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1041);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is a shell?', 'A command line interface to the operating system that allows the user 
	to type commands, execute programs, and see responses as text.', 4); --1042
INSERT INTO card_deck (card_id, deck_id) VALUES (1042, 108);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1042);

INSERT INTO card (card_front, card_back, user_id) VALUES ('pwd', 'Command: print working directory. Shows the current directory', 4); --1043
INSERT INTO card_deck (card_id, deck_id) VALUES (1043, 108);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1043);

INSERT INTO card (card_front, card_back, user_id) VALUES ('ls -a', 'list all of the contents in current directory. (-a includes hidden files)', 4); --1044
INSERT INTO card_deck (card_id, deck_id) VALUES (1044, 108);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1044);

INSERT INTO card (card_front, card_back, user_id) VALUES ('cd', 'Change Directory: used to change the current working directory', 4); --1045
INSERT INTO card_deck (card_id, deck_id) VALUES (1045, 108);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1045);

INSERT INTO card (card_front, card_back, user_id) VALUES ('~ (tilde character)', 'designates the home directory', 4); --1046
INSERT INTO card_deck (card_id, deck_id) VALUES (1046, 108);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1046);

INSERT INTO card (card_front, card_back, user_id) VALUES ('.. (two dots)', 'reference to parent directory', 4); --1047
INSERT INTO card_deck (card_id, deck_id) VALUES (1047, 108);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1047);

INSERT INTO card (card_front, card_back, user_id) VALUES ('. (one dot)', 'self-reference to current directory', 4); --1048
INSERT INTO card_deck (card_id, deck_id) VALUES (1048, 108);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1048);

INSERT INTO card (card_front, card_back, user_id) VALUES ('mkdir', 'make a new directory', 4); --1049
INSERT INTO card_deck (card_id, deck_id) VALUES (1049, 108);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1049);

INSERT INTO card (card_front, card_back, user_id) VALUES ('touch <filename>', 'create an empty file with the specified name', 4); --1050
INSERT INTO card_deck (card_id, deck_id) VALUES (1050, 108);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1050);

INSERT INTO card (card_front, card_back, user_id) VALUES ('git init', 'Initializes and new Git repository. Creates a .git subdirectory in the current
	directory, which contains all of the necessary metadata for the repo.', 4); --1051
INSERT INTO card_deck (card_id, deck_id) VALUES (1051, 108);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1051);

INSERT INTO card (card_front, card_back, user_id) VALUES ('git status', 'Displays the state of the working directory and the staging area.', 4); --1052
INSERT INTO card_deck (card_id, deck_id) VALUES (1052, 108);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1052);

INSERT INTO card (card_front, card_back, user_id) VALUES ('git add', 'Adds changes in the working directory to the staging area. It tells Git that you want to 
	include updates on the next commit.', 4); --1053
INSERT INTO card_deck (card_id, deck_id) VALUES (1053, 108);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1053);

INSERT INTO card (card_front, card_back, user_id) VALUES ('git commit -m "message"', 'Commits the staged snapshot to the project history. Also records the 
	commit message', 4); --1054
INSERT INTO card_deck (card_id, deck_id) VALUES (1054, 108);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1054);

INSERT INTO card (card_front, card_back, user_id) VALUES ('git clone <remote repo link>', 'Clone an existing repository.', 4); --1055
INSERT INTO card_deck (card_id, deck_id) VALUES (1055, 108);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1055);

INSERT INTO card (card_front, card_back, user_id) VALUES ('git push origin main', 'used to send changes made to the "main" branch', 4); --1056
INSERT INTO card_deck (card_id, deck_id) VALUES (1056, 108);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1056);

INSERT INTO card (card_front, card_back, user_id) VALUES ('origin', 'Default name of remote repository that has been cloned to local machine.', 4); --1057
INSERT INTO card_deck (card_id, deck_id) VALUES (1057, 108);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1057);


INSERT INTO card (card_front, card_back, user_id) VALUES ('main', 'Default name of primary branch on local repository. Used to be called master', 4); --1058
INSERT INTO card_deck (card_id, deck_id) VALUES (1058, 108);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1058);

--add data to Nick's profile user_id 5

INSERT INTO deck (user_id, deck_name, deck_description) VALUES (5, 'Object Oriented Programming', 'Cards related to OOP principles'); --109
INSERT INTO deck (user_id, deck_name, deck_description) VALUES (5, 'Data types, arrays, and collections in C#', ''); --110
INSERT INTO deck (user_id, deck_name, deck_description) VALUES (5, 'C# Coding basics', 'Basic coding terminology'); --111
INSERT INTO deck (user_id, deck_name, deck_description) VALUES (5, 'git and shell', 'git and shell definitions and commands'); --112

INSERT INTO card (card_front, card_back, user_id) VALUES ('What are the 3 principles of OOP?', 'Encapsulation, Inheritance, and Polymorphism', 5); --1059
INSERT INTO card_deck (card_id, deck_id) VALUES (1059, 109);
INSERT INTO card_tag (tag_id, card_id) VALUES (2001, 1059);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is encapsulation?', 'Bundling of data with the methods that operate on that data, 
	or restricting of direct access to some of an objects components.', 5); --1060
INSERT INTO card_deck (card_id, deck_id) VALUES (1060, 109);
INSERT INTO card_tag (tag_id, card_id) VALUES (2001, 1060);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is inheritance?', 'Allows a child class to take on the properties of and methods defined
	in a parent class.', 5); --1061
INSERT INTO card_deck (card_id, deck_id) VALUES (1061, 109);
INSERT INTO card_tag (tag_id, card_id) VALUES (2001, 1061);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is polymorphism?', 'Allows different types of objects to be treated as the same type of thing
	within a program.', 5); --1062
INSERT INTO card_deck (card_id, deck_id) VALUES (1062, 109);
INSERT INTO card_tag (tag_id, card_id) VALUES (2001, 1062);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is a class?', 'The blueprint of an object that defines the properties and methods. 
	They are the embodiment of an object oriented programming.', 5); --1063
INSERT INTO card_deck (card_id, deck_id) VALUES (1063, 109);
INSERT INTO card_tag (tag_id, card_id) VALUES (2001, 1063);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is a method?', 'A reusable unit of code that may return a value.', 5); --1064
INSERT INTO card_deck (card_id, deck_id) VALUES (1064, 111);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1064);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is the difference between a "for loop" and a "while loop"?', 'A "for loop" runs a 
	specific number of times. A "while loop" runs until a specified condition is false.', 5); --1065
INSERT INTO card_deck (card_id, deck_id) VALUES (1065, 110);
INSERT INTO card_deck (card_id, deck_id) VALUES (1065, 111);
INSERT INTO card_tag (tag_id, card_id) VALUES (2005, 1065);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1065);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is the difference between a "while loop" and a " do while loop"?', 'A "while loop" may never
	run if the conditional is false when it gets to the loop. A "do while loop" will always run at least once.', 5); --1066
INSERT INTO card_deck (card_id, deck_id) VALUES (1066, 110);
INSERT INTO card_deck (card_id, deck_id) VALUES (1066, 111);
INSERT INTO card_tag (tag_id, card_id) VALUES (2005, 1066);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1066);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is the difference between a value or primitive data type and a reference type?', 
	'A primitive type stores a value that consumes a fixed amount of memory. A reference type stores complex data and references a space on the heap 
	where the data is stored.', 5); --1067
INSERT INTO card_deck (card_id, deck_id) VALUES (1067, 110);
INSERT INTO card_deck (card_id, deck_id) VALUES (1067, 111);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1067);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is an object"?', 'An in-memory data structure that combines state and behavior into a 
	usable and useful abstraction. A collection of properties and methods.', 5); --1068
INSERT INTO card_deck (card_id, deck_id) VALUES (1068, 109);
INSERT INTO card_deck (card_id, deck_id) VALUES (1068, 110);
INSERT INTO card_deck (card_id, deck_id) VALUES (1068, 111);
INSERT INTO card_tag (tag_id, card_id) VALUES (2001, 1068);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1068);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is the difference between overloading a method and overriding a method?', 'Overloading is 
	when have methods with the same name that take in different number and/or type of parameters. Overriding is when a child class creates a new version of
	a method from the parent class.', 5); --1069
INSERT INTO card_deck (card_id, deck_id) VALUES (1069, 111);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1069);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is an array"?', 'A data structure consisting of elements that have the same type and is a 
	fixed size.', 5); --1070
INSERT INTO card_deck (card_id, deck_id) VALUES (1070, 110);
INSERT INTO card_deck (card_id, deck_id) VALUES (1070, 111);
INSERT INTO card_tag (tag_id, card_id) VALUES (2005, 1070);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1070);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is a shell?', 'A command line interface to the operating system that allows the user 
	to type commands, execute programs, and see responses as text.', 5); --1071
INSERT INTO card_deck (card_id, deck_id) VALUES (1071, 112);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1071);

INSERT INTO card (card_front, card_back, user_id) VALUES ('pwd', 'Command: print working directory. Shows the current directory', 5); --1072
INSERT INTO card_deck (card_id, deck_id) VALUES (1072, 112);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1072);

INSERT INTO card (card_front, card_back, user_id) VALUES ('ls -a', 'list all of the contents in current directory. (-a includes hidden files)', 5); --1073
INSERT INTO card_deck (card_id, deck_id) VALUES (1073, 112);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1073);

INSERT INTO card (card_front, card_back, user_id) VALUES ('cd', 'Change Directory: used to change the current working directory', 5); --1074
INSERT INTO card_deck (card_id, deck_id) VALUES (1074, 112);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1074);

INSERT INTO card (card_front, card_back, user_id) VALUES ('~ (tilde character)', 'designates the home directory', 5); --1075
INSERT INTO card_deck (card_id, deck_id) VALUES (1075, 112);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1075);

INSERT INTO card (card_front, card_back, user_id) VALUES ('.. (two dots)', 'reference to parent directory', 5); --1076
INSERT INTO card_deck (card_id, deck_id) VALUES (1076, 112);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1076);

INSERT INTO card (card_front, card_back, user_id) VALUES ('. (one dot)', 'self-reference to current directory', 5); --1077
INSERT INTO card_deck (card_id, deck_id) VALUES (1077, 112);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1077);

INSERT INTO card (card_front, card_back, user_id) VALUES ('mkdir', 'make a new directory', 5); --1078
INSERT INTO card_deck (card_id, deck_id) VALUES (1078, 112);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1078);

INSERT INTO card (card_front, card_back, user_id) VALUES ('touch <filename>', 'create an empty file with the specified name', 5); --1079
INSERT INTO card_deck (card_id, deck_id) VALUES (1079, 112);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1079);

INSERT INTO card (card_front, card_back, user_id) VALUES ('git init', 'Initializes and new Git repository. Creates a .git subdirectory in the current
	directory, which contains all of the necessary metadata for the repo.', 5); --1080
INSERT INTO card_deck (card_id, deck_id) VALUES (1080, 112);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1080);

INSERT INTO card (card_front, card_back, user_id) VALUES ('git status', 'Displays the state of the working directory and the staging area.', 5); --1081
INSERT INTO card_deck (card_id, deck_id) VALUES (1081, 112);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1081);

INSERT INTO card (card_front, card_back, user_id) VALUES ('git add', 'Adds changes in the working directory to the staging area. It tells Git that you want to 
	include updates on the next commit.', 5); --1082
INSERT INTO card_deck (card_id, deck_id) VALUES (1082, 112);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1082);

INSERT INTO card (card_front, card_back, user_id) VALUES ('git commit -m "message"', 'Commits the staged snapshot to the project history. Also records the 
	commit message', 5); --1083
INSERT INTO card_deck (card_id, deck_id) VALUES (1083, 112);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1083);

INSERT INTO card (card_front, card_back, user_id) VALUES ('git clone <remote repo link>', 'Clone an existing repository.', 5); --1084
INSERT INTO card_deck (card_id, deck_id) VALUES (1084, 112);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1084);

INSERT INTO card (card_front, card_back, user_id) VALUES ('git push origin main', 'used to send changes made to the "main" branch', 5); --1085
INSERT INTO card_deck (card_id, deck_id) VALUES (1085, 112);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1085);

INSERT INTO card (card_front, card_back, user_id) VALUES ('origin', 'Default name of remote repository that has been cloned to local machine.', 5); --1086
INSERT INTO card_deck (card_id, deck_id) VALUES (1086, 112);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1086);


INSERT INTO card (card_front, card_back, user_id) VALUES ('main', 'Default name of primary branch on local repository. Used to be called master', 5); --1087
INSERT INTO card_deck (card_id, deck_id) VALUES (1087, 112);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1087);

--add data to Sam's profile user_id 6

INSERT INTO deck (user_id, deck_name, deck_description) VALUES (6, 'Object Oriented Programming', 'Cards related to OOP principles'); --113
INSERT INTO deck (user_id, deck_name, deck_description) VALUES (6, 'Data types, arrays, and collections in C#', ''); --114
INSERT INTO deck (user_id, deck_name, deck_description) VALUES (6, 'C# Coding basics', 'Basic coding terminology'); --115
INSERT INTO deck (user_id, deck_name, deck_description) VALUES (6, 'git and shell', 'git and shell definitions and commands'); --116

INSERT INTO card (card_front, card_back, user_id) VALUES ('What are the 3 principles of OOP?', 'Encapsulation, Inheritance, and Polymorphism', 6); --1088
INSERT INTO card_deck (card_id, deck_id) VALUES (1088, 113);
INSERT INTO card_tag (tag_id, card_id) VALUES (2001, 1088);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is encapsulation?', 'Bundling of data with the methods that operate on that data, 
	or restricting of direct access to some of an objects components.', 6); --1089
INSERT INTO card_deck (card_id, deck_id) VALUES (1089, 113);
INSERT INTO card_tag (tag_id, card_id) VALUES (2001, 1089);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is inheritance?', 'Allows a child class to take on the properties of and methods defined
	in a parent class.', 6); --1090
INSERT INTO card_deck (card_id, deck_id) VALUES (1090, 113);
INSERT INTO card_tag (tag_id, card_id) VALUES (2001, 1090);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is polymorphism?', 'Allows different types of objects to be treated as the same type of thing
	within a program.', 6); --1091
INSERT INTO card_deck (card_id, deck_id) VALUES (1091, 113);
INSERT INTO card_tag (tag_id, card_id) VALUES (2001, 1091);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is a class?', 'The blueprint of an object that defines the properties and methods. 
	They are the embodiment of an object oriented programming.', 6); --1092
INSERT INTO card_deck (card_id, deck_id) VALUES (1092, 113);
INSERT INTO card_tag (tag_id, card_id) VALUES (2001, 1092);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is a method?', 'A reusable unit of code that may return a value.', 6); --1093
INSERT INTO card_deck (card_id, deck_id) VALUES (1093, 115);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1093);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is the difference between a "for loop" and a "while loop"?', 'A "for loop" runs a 
	specific number of times. A "while loop" runs until a specified condition is false.', 6); --1094
INSERT INTO card_deck (card_id, deck_id) VALUES (1094, 114);
INSERT INTO card_deck (card_id, deck_id) VALUES (1094, 115);
INSERT INTO card_tag (tag_id, card_id) VALUES (2005, 1094);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1094);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is the difference between a "while loop" and a " do while loop"?', 'A "while loop" may never
	run if the conditional is false when it gets to the loop. A "do while loop" will always run at least once.', 6); --1095
INSERT INTO card_deck (card_id, deck_id) VALUES (1095, 114);
INSERT INTO card_deck (card_id, deck_id) VALUES (1095, 115);
INSERT INTO card_tag (tag_id, card_id) VALUES (2005, 1095);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1095);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is the difference between a value or primitive data type and a reference type?', 
	'A primitive type stores a value that consumes a fixed amount of memory. A reference type stores complex data and references a space on the heap 
	where the data is stored.', 6); --1096
INSERT INTO card_deck (card_id, deck_id) VALUES (1096, 114);
INSERT INTO card_deck (card_id, deck_id) VALUES (1096, 115);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1096);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is an object"?', 'An in-memory data structure that combines state and behavior into a 
	usable and useful abstraction. A collection of properties and methods.', 6); --1097
INSERT INTO card_deck (card_id, deck_id) VALUES (1097, 113);
INSERT INTO card_deck (card_id, deck_id) VALUES (1097, 114);
INSERT INTO card_deck (card_id, deck_id) VALUES (1097, 115);
INSERT INTO card_tag (tag_id, card_id) VALUES (2001, 1097);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1097);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is the difference between overloading a method and overriding a method?', 'Overloading is 
	when have methods with the same name that take in different number and/or type of parameters. Overriding is when a child class creates a new version of
	a method from the parent class.', 6); --1098
INSERT INTO card_deck (card_id, deck_id) VALUES (1098, 115);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1098);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is an array"?', 'A data structure consisting of elements that have the same type and is a 
	fixed size.', 6); --1099
INSERT INTO card_deck (card_id, deck_id) VALUES (1099, 114);
INSERT INTO card_deck (card_id, deck_id) VALUES (1099, 115);
INSERT INTO card_tag (tag_id, card_id) VALUES (2005, 1099);
INSERT INTO card_tag (tag_id, card_id) VALUES (2012, 1099);

INSERT INTO card (card_front, card_back, user_id) VALUES ('What is a shell?', 'A command line interface to the operating system that allows the user 
	to type commands, execute programs, and see responses as text.', 6); --1100
INSERT INTO card_deck (card_id, deck_id) VALUES (1100, 116);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1100);

INSERT INTO card (card_front, card_back, user_id) VALUES ('pwd', 'Command: print working directory. Shows the current directory', 6); --1101
INSERT INTO card_deck (card_id, deck_id) VALUES (1101, 116);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1101);

INSERT INTO card (card_front, card_back, user_id) VALUES ('ls -a', 'list all of the contents in current directory. (-a includes hidden files)', 6); --1102
INSERT INTO card_deck (card_id, deck_id) VALUES (1102, 116);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1102);

INSERT INTO card (card_front, card_back, user_id) VALUES ('cd', 'Change Directory: used to change the current working directory', 6); --1103
INSERT INTO card_deck (card_id, deck_id) VALUES (1103, 116);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1103);

INSERT INTO card (card_front, card_back, user_id) VALUES ('~ (tilde character)', 'designates the home directory', 6); --1104
INSERT INTO card_deck (card_id, deck_id) VALUES (1104, 116);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1104);

INSERT INTO card (card_front, card_back, user_id) VALUES ('.. (two dots)', 'reference to parent directory', 6); --1105
INSERT INTO card_deck (card_id, deck_id) VALUES (1105, 116);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1105);

INSERT INTO card (card_front, card_back, user_id) VALUES ('. (one dot)', 'self-reference to current directory', 6); --1106
INSERT INTO card_deck (card_id, deck_id) VALUES (1106, 116);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1106);

INSERT INTO card (card_front, card_back, user_id) VALUES ('mkdir', 'make a new directory', 6); --1107
INSERT INTO card_deck (card_id, deck_id) VALUES (1107, 116);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1107);

INSERT INTO card (card_front, card_back, user_id) VALUES ('touch <filename>', 'create an empty file with the specified name', 6); --1108
INSERT INTO card_deck (card_id, deck_id) VALUES (1108, 116);
INSERT INTO card_tag (tag_id, card_id) VALUES (2014, 1108);

INSERT INTO card (card_front, card_back, user_id) VALUES ('git init', 'Initializes and new Git repository. Creates a .git subdirectory in the current
	directory, which contains all of the necessary metadata for the repo.', 6); --1109
INSERT INTO card_deck (card_id, deck_id) VALUES (1109, 116);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1109);

INSERT INTO card (card_front, card_back, user_id) VALUES ('git status', 'Displays the state of the working directory and the staging area.', 6); --1110
INSERT INTO card_deck (card_id, deck_id) VALUES (1110, 116);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1110);

INSERT INTO card (card_front, card_back, user_id) VALUES ('git add', 'Adds changes in the working directory to the staging area. It tells Git that you want to 
	include updates on the next commit.', 6); --1111
INSERT INTO card_deck (card_id, deck_id) VALUES (1111, 116);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1111);

INSERT INTO card (card_front, card_back, user_id) VALUES ('git commit -m "message"', 'Commits the staged snapshot to the project history. Also records the 
	commit message', 6); --1112
INSERT INTO card_deck (card_id, deck_id) VALUES (1112, 116);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1112);

INSERT INTO card (card_front, card_back, user_id) VALUES ('git clone <remote repo link>', 'Clone an existing repository.', 6); --1113
INSERT INTO card_deck (card_id, deck_id) VALUES (1113, 116);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1113);

INSERT INTO card (card_front, card_back, user_id) VALUES ('git push origin main', 'used to send changes made to the "main" branch', 6); --1114
INSERT INTO card_deck (card_id, deck_id) VALUES (1114, 116);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1114);

INSERT INTO card (card_front, card_back, user_id) VALUES ('origin', 'Default name of remote repository that has been cloned to local machine.', 6); --1115
INSERT INTO card_deck (card_id, deck_id) VALUES (1115, 116);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1115);


INSERT INTO card (card_front, card_back, user_id) VALUES ('main', 'Default name of primary branch on local repository. Used to be called master', 6); --1116
INSERT INTO card_deck (card_id, deck_id) VALUES (1116, 116);
INSERT INTO card_tag (tag_id, card_id) VALUES (2013, 1116);



--Additional added decks & cards

INSERT INTO deck (user_id, deck_name, deck_description, isPublic) VALUES (3, 'Bird Id','Identify birds by their images',1); --117
INSERT INTO deck (user_id, deck_name, deck_description, isPublic) VALUES (4, 'Bird Id','Identify birds by their images',0); --118
INSERT INTO deck (user_id, deck_name, deck_description, isPublic) VALUES (5, 'Bird Id','Identify birds by their images',0); --119
INSERT INTO deck (user_id, deck_name, deck_description, isPublic) VALUES (6, 'Bird Id','Identify birds by their images',0); --120

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the bird','cardinal, male',
	'https://images.unsplash.com/photo-1615146101981-cf25d1a1e6a1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80',
	3,1); --1117
INSERT INTO card_deck (card_id, deck_id) VALUES (1117, 117);
INSERT INTO card_tag (tag_id, card_id) VALUES (2015, 1117);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the bird','cardinal, male',
	'https://images.unsplash.com/photo-1615146101981-cf25d1a1e6a1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80',
	4,0); --1118
INSERT INTO card_deck (card_id, deck_id) VALUES (1118, 118);
INSERT INTO card_tag (tag_id, card_id) VALUES (2015, 1118);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the bird','cardinal, male',
	'https://images.unsplash.com/photo-1615146101981-cf25d1a1e6a1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80',
	5,0); --1119
INSERT INTO card_deck (card_id, deck_id) VALUES (1119, 119);
INSERT INTO card_tag (tag_id, card_id) VALUES (2015, 1119);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the bird','cardinal, male',
	'https://images.unsplash.com/photo-1615146101981-cf25d1a1e6a1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80',
	6,0); --1120
INSERT INTO card_deck (card_id, deck_id) VALUES (1120, 120);
INSERT INTO card_tag (tag_id, card_id) VALUES (2015, 1120);


INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the bird','cardinal, female',
	'https://images.unsplash.com/photo-1590183281296-62bb55255612?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
	3,1); --1121
INSERT INTO card_deck (card_id, deck_id) VALUES (1121, 117);
INSERT INTO card_tag (tag_id, card_id) VALUES (2015, 1121);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the bird','cardinal, female',
	'https://images.unsplash.com/photo-1590183281296-62bb55255612?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
	4,0); --1122
INSERT INTO card_deck (card_id, deck_id) VALUES (1122, 118);
INSERT INTO card_tag (tag_id, card_id) VALUES (2015, 1122);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the bird','cardinal, female',
	'https://images.unsplash.com/photo-1590183281296-62bb55255612?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
	5,0); --1123
INSERT INTO card_deck (card_id, deck_id) VALUES (1123, 119);
INSERT INTO card_tag (tag_id, card_id) VALUES (2015, 1123);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the bird','cardinal, female',
	'https://images.unsplash.com/photo-1590183281296-62bb55255612?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
	6,0); --1124
INSERT INTO card_deck (card_id, deck_id) VALUES (1124, 120);
INSERT INTO card_tag (tag_id, card_id) VALUES (2015, 1124);


--add admin decks/cards

INSERT INTO deck (user_id, deck_name, deck_description, isPublic) VALUES (2, 'Wild Cats','Identify wild felines by their images', 1); --121
-- tag 'big cats' 2016
-- tag 'small cats' 2017


INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the cat','Bengal tiger',
	'https://files.worldwildlife.org/wwfcmsprod/images/Tiger_resting_Bandhavgarh_National_Park_India/hero_small/6aofsvaglm_Medium_WW226365.jpg',
	2,1); --1125
INSERT INTO card_deck (card_id, deck_id) VALUES (1125, 121);
INSERT INTO card_tag (tag_id, card_id) VALUES (2016, 1125);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the cats','Lions, male(left) and female(right)',
	'https://cdn.mos.cms.futurecdn.net/J9KeYkEZf4HHD5LRGf799N.jpg',
	2,1); --1126
INSERT INTO card_deck (card_id, deck_id) VALUES (1126, 121);
INSERT INTO card_tag (tag_id, card_id) VALUES (2016, 1126);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the cat','Leopard',
	'https://540934-1733880-raikfcquaxqncofqfm.stackpathdns.com/wp-content/uploads/2020/01/leopard-walking-1024x683.jpg',
	2,1); --1127
INSERT INTO card_deck (card_id, deck_id) VALUES (1127, 121);
INSERT INTO card_tag (tag_id, card_id) VALUES (2016, 1127);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the cat','Jaguar',
	'https://www.awsfzoo.com/media/Screen-Shot-2021-01-24-at-9.20.25-AM-1024x677.png',
	2,1); --1128
INSERT INTO card_deck (card_id, deck_id) VALUES (1128, 121);
INSERT INTO card_tag (tag_id, card_id) VALUES (2016, 1128);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the cat','Serval',
	'https://www.awf.org/sites/default/files/styles/species_image/public/2020-04/Website_SpeciesPage_Serval02_Challenges.jpg?h=29c6c1f6&itok=7C1FoaPW',
	2,1); --1129
INSERT INTO card_deck (card_id, deck_id) VALUES (1129, 121);
INSERT INTO card_tag (tag_id, card_id) VALUES (2017, 1129);

INSERT INTO deck (user_id, deck_name, deck_description, isPublic) VALUES (2, 'Paintings','Identify the name and painter of famous paintings', 1); --122
-- tag 'paintings' 2018

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the painting and artist','Mona Lisa by Leonardo da Vinci',
	'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg/270px-Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg',
	2,1); --1130
INSERT INTO card_deck (card_id, deck_id) VALUES (1130, 122);
INSERT INTO card_tag (tag_id, card_id) VALUES (2018, 1130);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the painting and artist','The Starry Night by Vincent van Gogh',
	'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg/270px-Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg',
	2,1); --1131
INSERT INTO card_deck (card_id, deck_id) VALUES (1131, 122);
INSERT INTO card_tag (tag_id, card_id) VALUES (2018, 1131);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the painting and artist','Girl with a Pearl Earring by Johannes Vermeer',
	'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/1665_Girl_with_a_Pearl_Earring.jpg/270px-1665_Girl_with_a_Pearl_Earring.jpg',
	2,1); --1132
INSERT INTO card_deck (card_id, deck_id) VALUES (1132, 122);
INSERT INTO card_tag (tag_id, card_id) VALUES (2018, 1132);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the painting and artist','The Kiss by Gustav Klimt',
	'https://upload.wikimedia.org/wikipedia/commons/thumb/4/40/The_Kiss_-_Gustav_Klimt_-_Google_Cultural_Institute.jpg/300px-The_Kiss_-_Gustav_Klimt_-_Google_Cultural_Institute.jpg',
	2,1); --1133
INSERT INTO card_deck (card_id, deck_id) VALUES (1133, 122);
INSERT INTO card_tag (tag_id, card_id) VALUES (2018, 1133);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the painting and artist','The Last Supper by Leonardo da Vinci',
	'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/%C3%9Altima_Cena_-_Da_Vinci_5.jpg/350px-%C3%9Altima_Cena_-_Da_Vinci_5.jpg',
	2,1); --1134
INSERT INTO card_deck (card_id, deck_id) VALUES (1134, 122);
INSERT INTO card_tag (tag_id, card_id) VALUES (2018, 1134);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the painting and artist','American Gothic by Grant Wood',
	'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cc/Grant_Wood_-_American_Gothic_-_Google_Art_Project.jpg/240px-Grant_Wood_-_American_Gothic_-_Google_Art_Project.jpg',
	2,1); --1135
INSERT INTO card_deck (card_id, deck_id) VALUES (1135, 122);
INSERT INTO card_tag (tag_id, card_id) VALUES (2018, 1135);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the painting and artist', 'Whistler"s Mother (Arrangement in Grey and Black No. 1) by James McNeill Whistler',
	'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/Whistlers_Mother_high_res.jpg/270px-Whistlers_Mother_high_res.jpg',
	2,1); --1136
INSERT INTO card_deck (card_id, deck_id) VALUES (1136, 122);
INSERT INTO card_tag (tag_id, card_id) VALUES (2018, 1136);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the painting and artist', 'The Birth of Venus by Sandro Botticelli',
	'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Sandro_Botticelli_-_La_nascita_di_Venere_-_Google_Art_Project_-_edited.jpg/400px-Sandro_Botticelli_-_La_nascita_di_Venere_-_Google_Art_Project_-_edited.jpg',
	2,1); --1137
INSERT INTO card_deck (card_id, deck_id) VALUES (1137, 122);
INSERT INTO card_tag (tag_id, card_id) VALUES (2018, 1137);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the painting and artist', 'Las Meninas by Diego Velazquez',
	'https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/Las_Meninas%2C_by_Diego_Vel%C3%A1zquez%2C_from_Prado_in_Google_Earth.jpg/360px-Las_Meninas%2C_by_Diego_Vel%C3%A1zquez%2C_from_Prado_in_Google_Earth.jpg',
	2,1); --1138
INSERT INTO card_deck (card_id, deck_id) VALUES (1138, 122);
INSERT INTO card_tag (tag_id, card_id) VALUES (2018, 1138);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the painting and artist', 'Guernica by Pablo Picasso',
	'https://upload.wikimedia.org/wikipedia/en/thumb/7/74/PicassoGuernica.jpg/350px-PicassoGuernica.jpg',
	2,1); --1139
INSERT INTO card_deck (card_id, deck_id) VALUES (1139, 122);
INSERT INTO card_tag (tag_id, card_id) VALUES (2018, 1139);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the painting and artist', 'The Night Watch by Rembrandt van Rijn',
	'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/The_Night_Watch_-_HD.jpg/380px-The_Night_Watch_-_HD.jpg',
	2,1); --1140
INSERT INTO card_deck (card_id, deck_id) VALUES (1140, 122);
INSERT INTO card_tag (tag_id, card_id) VALUES (2018, 1140);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the painting and artist', 'The Arnolfini Portrait by Jan van Eyck',
	'https://upload.wikimedia.org/wikipedia/commons/thumb/3/33/Van_Eyck_-_Arnolfini_Portrait.jpg/270px-Van_Eyck_-_Arnolfini_Portrait.jpg',
	2,1); --1141
INSERT INTO card_deck (card_id, deck_id) VALUES (1141, 122);
INSERT INTO card_tag (tag_id, card_id) VALUES (2018, 1141);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the painting and artist', 'The Persistence of Memory by Salvador Dali',
	'https://upload.wikimedia.org/wikipedia/en/thumb/d/dd/The_Persistence_of_Memory.jpg/300px-The_Persistence_of_Memory.jpg',
	2,1); --1142
INSERT INTO card_deck (card_id, deck_id) VALUES (1142, 122);
INSERT INTO card_tag (tag_id, card_id) VALUES (2018, 1142);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the painting and artist', 'Impression, Sunrise by Claude Monet',
	'https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/Monet_-_Impression%2C_Sunrise.jpg/400px-Monet_-_Impression%2C_Sunrise.jpg',
	2,1); --1143
INSERT INTO card_deck (card_id, deck_id) VALUES (1143, 122);
INSERT INTO card_tag (tag_id, card_id) VALUES (2018, 1143);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the painting and artist', 'A Sunday Afternoon on the Island of La Grande Jatte',
	'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7d/A_Sunday_on_La_Grande_Jatte%2C_Georges_Seurat%2C_1884.jpg/350px-A_Sunday_on_La_Grande_Jatte%2C_Georges_Seurat%2C_1884.jpg',
	2,1); --1144
INSERT INTO card_deck (card_id, deck_id) VALUES (1144, 122);
INSERT INTO card_tag (tag_id, card_id) VALUES (2018, 1144);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the painting and artist', 'Liberty Leading the People by Eugene Delacroix',
	'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/Eug%C3%A8ne_Delacroix_-_Le_28_Juillet._La_Libert%C3%A9_guidant_le_peuple.jpg/300px-Eug%C3%A8ne_Delacroix_-_Le_28_Juillet._La_Libert%C3%A9_guidant_le_peuple.jpg',
	2,1); --1145
INSERT INTO card_deck (card_id, deck_id) VALUES (1145, 122);
INSERT INTO card_tag (tag_id, card_id) VALUES (2018, 1145);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the painting and artist', 'Cafe Terrace at Night by Vincent Van Gogh',
	'https://sep.yimg.com/ty/cdn/madisonartshop/most-famous-paintings-16.jpg?t=1628119938&',
	2,1); --1146
INSERT INTO card_deck (card_id, deck_id) VALUES (1146, 122);
INSERT INTO card_tag (tag_id, card_id) VALUES (2018, 1146);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the painting and artist', 'Les Menoiselles d"Avignon by Pablo Picasso',
	'https://upload.wikimedia.org/wikipedia/en/thumb/4/4c/Les_Demoiselles_d%27Avignon.jpg/350px-Les_Demoiselles_d%27Avignon.jpg',
	2,1); --1147
INSERT INTO card_deck (card_id, deck_id) VALUES (1147, 122);
INSERT INTO card_tag (tag_id, card_id) VALUES (2018, 1147);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the painting and artist', 'Bal du moulin de la Galette by Pierre-Auguste Renoir',
	'https://sep.yimg.com/ty/cdn/madisonartshop/most-famous-paintings-19.jpg?t=1628119938&',
	2,1); --1148
INSERT INTO card_deck (card_id, deck_id) VALUES (1148, 122);
INSERT INTO card_tag (tag_id, card_id) VALUES (2018, 1148);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the painting and artist', 'The Scream by Edvard Munch',
	'https://sep.yimg.com/ty/cdn/madisonartshop/most-famous-paintings-3.jpg?t=1628119938&',
	2,1); --1149
INSERT INTO card_deck (card_id, deck_id) VALUES (1149, 122);
INSERT INTO card_tag (tag_id, card_id) VALUES (2018, 1149);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the painting and artist', 'Three Musicians by Pablo Picasso',
	'https://sep.yimg.com/ty/cdn/madisonartshop/Picasso-3musicians?t=1628119938&',
	2,1); --1150
INSERT INTO card_deck (card_id, deck_id) VALUES (1150, 122);
INSERT INTO card_tag (tag_id, card_id) VALUES (2018, 1150);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the painting and artist', 'Water Lillies by Claude Monet',
	'https://sep.yimg.com/ty/cdn/madisonartshop/most-famous-paintings-13.jpg?t=1628119938&',
	2,1); --1151
INSERT INTO card_deck (card_id, deck_id) VALUES (1151, 122);
INSERT INTO card_tag (tag_id, card_id) VALUES (2018, 1151);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the painting and artist', 'The Flower Carrier by Diego Rivera',
	'https://sep.yimg.com/ty/cdn/madisonartshop/carrier?t=1628119938&',
	2,1); --1152
INSERT INTO card_deck (card_id, deck_id) VALUES (1152, 122);
INSERT INTO card_tag (tag_id, card_id) VALUES (2018, 1152);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the painting and artist', 'The Son of Man by Rene Magrittees',
	'https://sep.yimg.com/ty/cdn/madisonartshop/most-famous-paintings-17.jpg?t=1628119938&',
	2,1); --1153
INSERT INTO card_deck (card_id, deck_id) VALUES (1153, 122);
INSERT INTO card_tag (tag_id, card_id) VALUES (2018, 1153);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the painting and artist', 'Dogs Playing Poker by C.M. Coolidge',
	'https://sep.yimg.com/ty/cdn/madisonartshop/most-famous-paintings-20.jpg?t=1628119938&',
	2,1); --1154
INSERT INTO card_deck (card_id, deck_id) VALUES (1154, 122);
INSERT INTO card_tag (tag_id, card_id) VALUES (2018, 1154);

--big cats 2016
--small cats 2017
INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the cat','Snow Leopard',
	'https://540934-1733880-raikfcquaxqncofqfm.stackpathdns.com/wp-content/uploads/2019/05/Snow-leopard-AdobeStock_243151027-1024x683.jpg',
	2,1); --1155
INSERT INTO card_deck (card_id, deck_id) VALUES (1155, 121);
INSERT INTO card_tag (tag_id, card_id) VALUES (2016, 1155);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the cat','Clouded Leopard',
	'https://540934-1733880-raikfcquaxqncofqfm.stackpathdns.com/wp-content/uploads/2019/06/Clouded-leopard-AdobeStock_177858806-1024x683.jpg',
	2,1); --1156
INSERT INTO card_deck (card_id, deck_id) VALUES (1156, 121);
INSERT INTO card_tag (tag_id, card_id) VALUES (2016, 1156);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the cat','Asiatic Golden Cat',
	'https://540934-1733880-raikfcquaxqncofqfm.stackpathdns.com/wp-content/uploads/2020/05/Asiatic-golden-cat-Flikr-creative-commons-1024x683.jpg',
	2,1); --1157
INSERT INTO card_deck (card_id, deck_id) VALUES (1157, 121);
INSERT INTO card_tag (tag_id, card_id) VALUES (2017, 1157);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the cat','Caracal',
	'https://540934-1733880-raikfcquaxqncofqfm.stackpathdns.com/wp-content/uploads/2018/04/Caracal.jpg',
	2,1); --1158
INSERT INTO card_deck (card_id, deck_id) VALUES (1158, 121);
INSERT INTO card_tag (tag_id, card_id) VALUES (2017, 1158);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the cat','Ocelot',
	'https://540934-1733880-raikfcquaxqncofqfm.stackpathdns.com/wp-content/uploads/2018/05/DSC_0731-1024x683.jpg',
	2,1); --1159
INSERT INTO card_deck (card_id, deck_id) VALUES (1159, 121);
INSERT INTO card_tag (tag_id, card_id) VALUES (2017, 1159);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the cat','Margay',
	'https://540934-1733880-raikfcquaxqncofqfm.stackpathdns.com/wp-content/uploads/2019/04/Margay-AdobeStock_102591632-1024x683.jpg',
	2,1); --1160
INSERT INTO card_deck (card_id, deck_id) VALUES (1160, 121);
INSERT INTO card_tag (tag_id, card_id) VALUES (2017, 1160);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the cat','Colocolo',
	'https://540934-1733880-raikfcquaxqncofqfm.stackpathdns.com/wp-content/uploads/2021/07/Pampas-cat-1024x683.jpg',
	2,1); --1161
INSERT INTO card_deck (card_id, deck_id) VALUES (1161, 121);
INSERT INTO card_tag (tag_id, card_id) VALUES (2017, 1161);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the cat','Canada Lynx',
	'https://540934-1733880-raikfcquaxqncofqfm.stackpathdns.com/wp-content/uploads/2018/04/Bobcat-in-the-snow.jpg',
	2,1); --1162
INSERT INTO card_deck (card_id, deck_id) VALUES (1162, 121);
INSERT INTO card_tag (tag_id, card_id) VALUES (2017, 1162);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the cat','Bobcat',
	'https://540934-1733880-raikfcquaxqncofqfm.stackpathdns.com/wp-content/uploads/2020/05/Bobcat-AdobeStock_177846262-1024x683.jpg',
	2,1); --1163
INSERT INTO card_deck (card_id, deck_id) VALUES (1163, 121);
INSERT INTO card_tag (tag_id, card_id) VALUES (2017, 1163);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the cat','Puma',
	'https://540934-1733880-raikfcquaxqncofqfm.stackpathdns.com/wp-content/uploads/2018/04/Puma.jpg',
	2,1); --1164
INSERT INTO card_deck (card_id, deck_id) VALUES (1164, 121);
INSERT INTO card_tag (tag_id, card_id) VALUES (2017, 1164);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the cat','Cheetah',
	'https://540934-1733880-raikfcquaxqncofqfm.stackpathdns.com/wp-content/uploads/2020/01/two-cheetahs-1024x682.jpg',
	2,1); --1165
INSERT INTO card_deck (card_id, deck_id) VALUES (1165, 121);
INSERT INTO card_tag (tag_id, card_id) VALUES (2017, 1165);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the cat','Jungle Cat',
	'https://540934-1733880-raikfcquaxqncofqfm.stackpathdns.com/wp-content/uploads/2019/06/Jungle-cat-AdobeStock_134820657-1024x682.jpg',
	2,1); --1166
INSERT INTO card_deck (card_id, deck_id) VALUES (1166, 121);
INSERT INTO card_tag (tag_id, card_id) VALUES (2017, 1166);

INSERT INTO card (card_front, card_back	, card_image, user_id ,isPublic) VALUES ('Identify the cat','Sand Cat',
	'https://540934-1733880-raikfcquaxqncofqfm.stackpathdns.com/wp-content/uploads/2018/04/Sand-cat.jpg',
	2,1); --1167
INSERT INTO card_deck (card_id, deck_id) VALUES (1167, 121);
INSERT INTO card_tag (tag_id, card_id) VALUES (2017, 1167);

INSERT INTO submitted_deck (deck_id) VALUES (113);
INSERT INTO submitted_deck (deck_id) VALUES (103);
GO