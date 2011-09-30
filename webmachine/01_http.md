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

!SLIDE bullets

# Hard HTTP Questions

* Can your middleware answer those questions?
* Your "app"?
* Where does that logic live?

!SLIDE

# HTTP doesn't change, only your resources.

!SLIDE

# Encapsulate those hard decisions and reuse them.

!SLIDE

# Let's shape our <br/>applications like HTTP,<br/> with Resources.

!SLIDE bullets incremental

# A Resource is:

* Data or Service
* Identified by URI
* Representations
* Other Variances/Properties
