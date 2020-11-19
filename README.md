# character-lister
Sinatra Web Application used to store a user's favorite characters and why they like them.

USE

To use this web application you must either signup for an account or login to your account if you have one already.
The usernames and passwords are case-sensitive so be sure to type in your username and password exactly how you want it.
Once logged in, you can add a character to your list, search for another user's list, or view your own list.
When adding a new character, the only required field is the name, everything else you can leave blank, but if a rank is not entered the character will be put on the bottom.
To edit a character's rank and/or information, navigate to your list and click on the character's name. You will then see a button to edit the character.

Currently this application is not hosted anywhere but you can test it on your local machine(instructions below).

INSTALLTION INSTRUCTIONS

1. Be sure to fork and clone the character-lister repo from github and make sure you have ruby installed on your device.
2. Change current directory to character-lister/ in the terminal and then run bundle install.
3. The application uses Shotgun to run the server, so to start it all you need to do is type 'shotgun' in the terminal and hit enter.
4. Once the server is up, copy the numbers (where it says 'listening on 000.0.0.0:0000' numbers will be different) and paste that into your browser.
5. You will be able to use the application from there and when you are finished go back to the terminal and hit ctrl+c to stop the server.

Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nicholas-wilson/character-lister. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the Contributor Covenant code of conduct.


License

The gem is available as open source under the terms of the MIT License. (https://opensource.org/licenses/MIT)
