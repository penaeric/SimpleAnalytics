Simple Analytics
===========================

Simple Analytics is a set of classes for recording events generated in an application.  These events can be analytics or any other type of user/application event you want to report to your servers. It is a reusable component that can be plugged into any application.  

![Alt text](screenshot-sm.png?raw=true "Simple Analytics")

Details
-------

* It sends the events no more than once every 5 seconds. 
* It doesn't send events when they are added to the queue, unless it is within the 5 second backoff time.
* When the backoff time is reached, any events in the queue are sent.
* All events are bundled into one API call.
* All the events have a name and a date.
* A sample event the server can expect:

```
  {
    "name" : "The Event Name",
    "date" : "2013-12-31 23:59:59 +0000",
    "payload" : {
      "key" : "value",
      "key02" : "val02"
    }
  }
```

* Events can optionally include a payload with an arbitrary dictionary of key/value pairs.
* The state of the events are: "Waiting" if they are waiting to be uploaded, "Sending" if they are sending", "Sent" if they are sent successfully and "Error" if they were not uploaded. (It is possible to have some events in the table with a "Sending" or "Error" status while others are "Waiting".
* Even if the server is slow and could take several seconds to return a success/failure response, new events can be recorded and are accounted for. 
* The user interface includes a button for generating a sample event and a table view for displaying the current and past events.
* The table cells display the current state of the events.
* The endpoint for this application randomly returns an error (400 status), which is helpful for debugging purposes.



Todos
-----

* Persist the events to disk so no events are lost even if the user quits.
* Delete the events that have been successfully sent (this application keeps all the events so that they all can be displayed in a Table View).
* Optionally, make the endpoint's URL and the backoff time configurable.
