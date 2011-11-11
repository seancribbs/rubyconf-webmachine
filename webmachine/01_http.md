!SLIDE 

# We have a problem.

!SLIDE

# CGI/WEBrick

![Almost as cool as my Perl from 1998.](perl.jpg)

!SLIDE

# Rails

![HTTP? That's so last decade. I use HTML5 and Websockets](railskitty2.jpg)

!SLIDE

# Sinatra/Rack

![I don't always use HTTP, but when I do, it's different every time.](rackman.jpg)

!SLIDE

# What can we do <br/>to make this better?

!SLIDE

# HTTP is Hard

<img src="http-headers-status-v3.png"
 style="max-width:100%;max-height:75%"
 alt="http decision diagram" />

!SLIDE bullets

# Hard HTTP Questions

* Is the request method allowed?
* What media-type to return?
* Is the response cacheable?
* Did the resource move?

!SLIDE

# Does your framework help you answer those questions?

!SLIDE

# HTTP doesn't change, only your resources.

!SLIDE

# Encapsulate those hard decisions and reuse them.

!SLIDE

# Let's shape our <br/>applications like HTTP,<br/> with Resources.

!SLIDE bullets incremental

# A Resource is: (RFC 2616)

* Data or Service
* Identified by URI
* Representations
* Other Variances/Properties
