some additions

defstart(foo): # Do stuff with foo and when done call the next functionstuff(callback=next_step, data=foo); defnext_step(bar): # Call more_stuff to parse barmore_stuff(callback=last_step, data=bar); deflast_step(baz): # Send the responsesend_response(baz) # Let our handler know we are donefinish()
Callback Passing Style

