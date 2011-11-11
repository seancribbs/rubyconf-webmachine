!SLIDE title

# Introducing Webmachine
## Doing HTTP Better

!SLIDE bullets

# Webmachine is 

* a toolkit 
* for easily creating 
* well-behaved 
* HTTP applications.

!SLIDE

# Webmachine is an executable model of HTTP.

!SLIDE

<img src="http-headers-status-v3.png" style="max-width: 100%;
max-height: 100%" alt="decision diagram" />

!SLIDE bullets incremental

# Webmachine:<br/>Shaped like HTTP

* Declare resources, don't perform actions
* Negotiate hard decisions transparently
* Respond with the right status code
* Use sensible default behaviors

!SLIDE bullets

# Not a framework!

* No ORM
* No template system
* No "plugins"
* No "asset pipeline"

!SLIDE bullets incremental

# Resource-focused

* Resources are the core building block
* Classes define "resource families"
* Well-defined interface to HTTP logic
* URIs map to resource families

!SLIDE

# 36 Resource "Callbacks"

<table>
<tr>
<td>
<pre>
allow_missing_post?
allowed_methods
base_uri
charsets_provided
content_types_accepted
content_types_provided
create_path
delete_completed?
delete_resource
encodings_provided
expires
finish_request
</pre>
</td>
<td>
<pre>
forbidden
generate_etag
is_authorized?
is_conflict?
known_content_type?
known_methods
language_chosen
languages_provided
last_modified
malformed_request?
moved_permanently?
moved_temporarily?
</pre>    
</td>
<td>
<pre>
multiple_choices?
options
post_is_create?
previously_existed?
process_post
resource_exists?
service_available?
uri_too_long?
valid_content_headers?
valid_entity_length?
validate_content_checksum
variances
</pre>
</td>
</tr>
</table>
