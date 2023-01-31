# 4D Report Manager Component

Bruno Di Gleria, <https://www.mixagesoftware.com>

### HISTORY
This component is a porting to 4D v18 of the QR Editor Source, TN 05-13 by Kent Wilbur <https://kb.4d.com/assetid=36757>.   
The Header/Footer section is based on TN 28-09 by Luis Pineiros <https://kb.4d.com/assetid=75840>.  
The border and manager sections are my own work, therefore are subject to a lot of improvements :)  
This porting was done some time ago, before all that amazing v18 OOP stuff, so you won't find fresh coding style here :(

### LICENSE
Not sure which license to apply here, but thanks to whoever wants to let me know!!

### TESTING
You can test the component in place  by running these methods without arguments:  

* `TEST_QuickReport`  
* `TEST_ReportManager`   

...or by choosing the corresponding menu in the "Test Application" mode.   

The "4D Report Manager.4DD" data file contains some sample data.  
The "Sample" folder contains a couple of sample reports.

### COMPONENT INSTALLATION:
Install the component as usual (you may want to take a look here: <https://kb.4d.com/assetid=78446>)


##### AFTER INSTALLATION:
The following 2 Methods are presented in the host database:

* `QR_QuickReport ( {->aTable {; document {; hierarchical {; wizard {; search }}}}})`  
	Same as standard QR REPORT with the vintage style look, including the wizard. 
	
	Parameters:
	1. aTable - Pointer to the report master table (optional: using default table if omitted)  
	2. QR document to load (not handled at this time)  
	3. Boolean - Allow automatic relations (optional: defaults to True)  
	4. Boolean - Enable wizard (optional: defaults to True)  
	5. Boolean - Allow changing table and queries (optional: defaults to False)  

* `QR_ReportManager ( ->aTable {; hierarchical {; wizard {; search }}})`  
Allows to manage/store the reports inside the host database. Very useful in a multiuser environment. The first time you call this method, you must confirm the creation of the "Report Manager" table which is used by the component to store its data.

	Parameters:
	1. aTable - Pointer to the report master table
	2. Boolean - Allow automatic relations (optional: defaults to True)  
	3. Boolean - Enable wizard (optional: defaults to True)  
	4. Boolean - Allow changing table and queries (optional: defaults to False)  


### NOTES

Notes / bugs inside the NOTES AND BUGS project method.

![4D Report Manager Screenshot](4D%20Report%20Screenshot.png)