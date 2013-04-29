Detail Analysis of BBB Source Code 
==================================

.. contents::
.. section-numbering::
.. footer::

	Page: ###Page###/###Total###, Source Code analysis, IIT Bombay



**Source Code Directoires details** [#]_

.. [#] 


Total Directories
-----------------

There are total 15 directoires in the source code of bbb in which 13 directories we have to explore, As most of the works is dependent on these directories. 
	
List of the Directories
~~~~~~~~~~~~~~~~~~~~~~~

#. BBB-api-demo
#. bbb-common-message
#. bbb-video
#. bbb-voice
#. bbb-voice-conference
#. bigbluebutton-apps
#. bigbluebutton-client
#. bigbluebutton-config
#. bigbluebutton-web
#. deskshare
#. esl-client-bbb
#. labs
#. record-and-play 
 
Platform used
-------------

The project used different platform for language,build process,frame work and database.

Programing language used
~~~~~~~~~~~~~~~~~~~~~~~~	

Most of the development in bbb is based on java. But it has also used some other languages for the development of other modules and all the languages are java platform based.

* Java_ 
* Groovy_ 
* Scala_ 
* ActionScript_
 

.. _Java:

Java
^^^^
Almost every module contain Java code.

.. _Groovy:

Groovy
^^^^^^
 Its Oops java platform based language,It can be used as scripting language for java platform. In bbb most of the work of groovy is on bbb-web and bbb-common-message.In bbb-common-message it has used for the program to initiate the task of ``room``, ``participant``, ``Iroomlistner``. ``Groovy 1.6.5`` version is used in bbb.

::


	room.groovy= Methods for user id join id etc
	participant.groovy= Methods are called which are define in above program
	IRoomparticipant.groovy= Interface of methods are define
	To add new api one of the changes we need to do is in this .groovy files.	
	location in bbb--> /dev/bigbluebutton/bbb-common-message/src/../conference

::


	In bbb-web it contains the program file for generate slie,api-controler,presentation controler.
	Groovyc is used to compile groovy script. 

	
.. _Scala:

Scala
^^^^^
 Its a object-functional programing and scripting language for general software application.In bbb Scala is use for deskshare application. ``Scala version 2.9.2`` is use in bbb. For more info visit site_.

.. _site: http://www.scala-lang.org/ 

::	
	
	Location of scala in bbb ~/dev/bigbluebutton/deskshare/app/src/main/scala/org/bigbluebutton/deskshare/server$

.. _ActionScript:

ActionScript
^^^^^^^^^^^^

::
	
	Mainly used in bigbluebutton client development.

Framework used
~~~~~~~~~~~~~~
Different frame work is used by bbb for various platform.

* Grails_
* FlexSDK_
* Zoolu_

.. _Grails: 

Grails
^^^^^^
Its an open source web application frame work. It takes the advantage of groovy programing language.Most of the server components are based on the grails (groovy).

.. _FlexSDK:

FlexSDK
^^^^^^^
Its a software development kit based on adobe flash, It is donated to Apache software foundation.Most of the work  is on bbb-client as the bigbluebutton client is written in ``action script`` . Flex 4.5.0 is used in bbb. At the time of complation for the bigbluebutton-client  using ANT,Flex is used to convert .as file in swf.  


.. _Zoolu:

Zoolu
^^^^^
Its a content managment system (cms) for creating, editing and publishing of content in a website.It is use for ``bbb-voice`` in bigbluebutton.

::

	Location for the Zoolu files /dev/bigbluebutton/bbb-voice/src/main/java/org/zoolu/ 
	this is location is for development environement. Which mostly contain network related java files.

::	

	Compiled version has files inside /usr/share/red5/webapps/sip/WEB-INF/classes/org/zoolu/

Compilation Build tools
~~~~~~~~~~~~~~~~~~~~~~~

Compilation is the process to convert the source code files(.as,.java,.groovy) into compiled executable files (swf, class).Build tools used in bbb are.

* ANT_
* Gradle_
* POM_
* Maven_

.. _ANT:

ANT
^^^
Another neat tool (ANT)  a build tool, and provide special support for java programing language.Its a platform independent and
has the instruction in the form of xml. Its use to automate the repeatitive task. This can be compiling the
source code,running software test and creating files and documentation for the software development. ``ANT version 1.7.1`` is used in bbb. ANT compilation is used by *bigbluebutton-client*, *bigbluebutton-web*, *deskshare-applet.*

::
	
	swf files genrated by the ANT are store in /bigbluebutton-client/bin directory




.. _Gradle:

Gradle
^^^^^^
It is a project automation tool, it is build upon the concept of ANT and Maven. It uses groovy based DSL ``domain specific language`` 

::

	Comiplation using gradle is used in the bbb-api-demo,bbb-common-message,bbb-video,voice,
	bigbluebutton-apps,bigbluebutton-web,deskshare/app/applet,els-client,labs. 

::

	Gradle version 0.8 is used in bbb


.. _POM:

POM
^^^
Its a fundamental unit to work with Maven. Its an xml file contain the information about the project and configuration detials used by Maven to build the project.

::

	pom.xml file is inside bbb-api-demo,bigbluebutton-web,esl-client-bbb. In the compile version 
	it is inside /usr/share/maven-repo/ 

.. _Maven:

Maven
^^^^^

Apache Maven is a software project managment and comprehension tool. It is based on Pom.Maven can manage project build,reporting and documentation. 

Datastore tool
~~~~~~~~~~~~~~

BBB do not manage lots of data to store, So there is no mysql database tools.Most of the data it manages are in for of meeting id some other value which it needed to communicate between the bbb-web and bbb-apps.

Redis
^^^^^

Redis stand for REmote DIctionary Sever . It is a key-value store, offten reffred as a NoSQL database. Key-value store the data called value inside a key. The data can be retrived with help of keys only.It is also term as in-memory [#]_  system. 

.. [#]
	In memory database system (IMDB) is the database management system which primarily relay on the main memory.

::

	BBB depends has two feature dependent on the Redis.
	1. From the flex client a user upload a presentation via Presentation API, the presentation converts 
	and all the events that happens in the conversion process are published in the redis pubsub.

	2. Updates in the meeting when a user join,user left is maintain by Redis.Red5 and api communicate using the Redis 

.. image:: images/bbb-upload.png
		:width: 62% 

Main Components
---------------
BBB has 5 main components on which whole architecture of BBB works. All the five components use languages and frame work explain above. 

* bbb-client
* bbb-web
* bbb-app
* deskshare
* bbb-api

bbb-client
~~~~~~~~~~

This component is use creating the client environment,When it join the conference room. bbb-client use application api like chat,participation,voice and ppt.

::
	
	These application are located in directory 
	/bigbluebutton-apps/src/main/java/org/bigbluebutton/conference/service$ 
	

Development Environment for bbb-client
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 
Language used
_____________

::
	
	ActionScript

Location of dir in dev environment & swf files
______________________________________________

::

	/dev/bigbluebutton/bigbluebutton-client/

	After the compilation the swf executable file generated is store in ../../../bin 

Compilation tool
________________
::

	Ant is used for the compilation. Which contains build.xml file, which has the details of the project.		

Example for Compilation
_______________________

In the example I will change the css and the copy-right logo of bigblue button.

* Example 1. Changing the footer

1. Step: Change the environment to the development environment, using bbb-conf command.


::
	
	bbb-conf --setup-dev client

2. Step: Change the directory to bigbluebutton-client inside the dev.

::

	$ cd ../../src/org/bigbluebutton/main/views$ 

3. Step: Open the file MainApplicationShell.mxml


::
	
	$ vim MainApplicationShell.mxml
	edit the line 311 

::

	 <mx:Label text="{ResourceUtil.getInstance().getString('bbb.mainshell.copyrightLabel2',[appVersion]) + ' India--  Rocks!'}" id="copyrightLabel2"/>


4. Step: Compile the code using Ant

::
	
	$ cd bigbluebutton-client
	$ ant

It will take 3-4 min to compile the code. 

5. Step: Type the url in  browser and you will the change at the footer of the client. 

* Example 2. Changing the copyright

1. Step: Change the directory and open the file bbbResource.properties

::
	
	$ cd bigbluebutton-client/locale/en_US$ 
	$ vim bbbResource.properties

2. Step: Make changes in line 6

::
	
	which the variable for copyrightLable2 
	and save the file

3. Step: move to the bigbluebutton-client directory and compile the code

::
	
	new swf will be created in bin/ 
	open the browser and you will find the changes.2. Step: Make changes in line 6

::
	
	which the variable for copyrightLable2 
	and save the file

3. Step: move to the bigbluebutton-client directory and compile the code

::
	
	$ ant locales 	
	new swf will be created in bin/ 
	open the browser and you will find the changes.

* Example 3. Changing the CSS

1. Step: Change the directory

:: 
	
	$ cd src/branding/css

2. Step: open the file theme.css

::
	
	$ vim theme.css
	and change the color code as per your requirement. 

3. Step: Compile the code using ant [#]_

::
		
	ant branding -DthemeFile=theme.css 

.. [#] while compiling dir should be bigbluebutton-client/ 

4. Step: Deploying the swf file to production server.

::
	
	Create a directory  in /var/www/bigbluebutton/client
	$ mkdir branding/css 

::

	Copy the swf file which is in bin/ on dev directories to new created directory 

::

	enable the branding in config file.
	$ vim /var/www/bigbluebutton/client/conf/config.xml
	
	<skinning enabled="true" url="branding/css/theme.css.swf" />

Directory structure details of bbb-client
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

It contains 3 type of directories.

* Compiled directories for production server
* Build process directory 
* Source code file of ActionScript

Compiled directory
__________________

* ``bin``: It contains the swf file after compilation
* ``client``: Contain BigBlueButton.html and swf files
* ``libs``: libraries 
* ``locale``: Contain the languages 
* ``resource``:

Build Process
_____________

* ``build``: Contain jar file library for build.
* ``build.xml``: Details of project.

Source code
___________

src
***
Contain all the source code file in ActionScript,mxml.

*Directory inside src*

Assets
+++++++
js script to check the flash player. 

branding
++++++++
contain css to change the theme.

conf	
++++
Contain .xml file to add the modules.

org
+++
Contain ActionScript and many dir
	 
test	
++++


.. image:: images/SourceCode8.jpeg
		:width: 100% 



bbb-web
~~~~~~~
