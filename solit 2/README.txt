I used the flyweight programming pattern with the cards and state pattern to implement the undo feature. The tables that contain card data 
rely on the games "state" which is a metatable I made that contains all the games essiental data aka the current containers of the games cards.
This made the undo feature incredibly easy as all I had to do was make a table called "history" which contained every games state and to 
make undo all I had to do is set the state to history[#history-1]. This is probably a resource inefficent way but this is the only way 
I could think of doing the undo feature without breaking my mind. I then used the flyweight pattern for cards as you just have to set variables
for the card rather than creating a new object for each card. This flyweight pattern is supported by findCardPosition which supports
the card class by setting position the table that contains the card.

Drew Whitmer
Drew in my first section made comments on my original code
https://github.com/DrewWhitmer/Code-Review
Overall I really wasnt proud of my initial submission, this is mainly due to it being a prototype and he pointed out mainly that
I didnt use enough comments or name things properly which made the code incredibly hard to understand how the logic worked. 
To fix this I made more functions and added comments for all logic that cant be easily understood on first glance.

Ayush
We had a conversation about our code, however at the time I started the reformatting of my code but didnt have access to it and neither did he.
Overall we talked about how to best store the cards information and how to handle the tables. At the time I had a general idea of what to
do, but this conversation reinforced my ideas and made me incredibly confident in them. Mainly my idea for the "state" data type that would
allow the undo button to be implemented with a minimal headache.

Wyatt
I showed him my code 2 days before finishing so I had all of the logic from the initial turn in done but hadnt implemented the new stuff.
Overall he pointed out that I needed to turn more logic into functions as it write stuff out multiple times so if I made them into functions
the code would be a lot more readible. My main change from this discussion was moving the bloat of draw into its own file and made in into a function
called drawUi() which made the main file more readable.

Overall my main issues with my initial solitare project were a lack of functions and reduduncy. I had wayyyy too many for loops and wayy too
few functions which made the code overall prototype slop. Overall my goal from the start was to make a table that contained all card containers
and use the lua magic to call tables by their table name instead of finding which table contains a card by finding it and returning its table.
I would consider this refactor a complete success, this is easily my best code that I've ever written and the first project that I can say
Im proud of and would gladly show the code to others. The prototype allowed me to find what logic would be needed so I was able to properly 
future proof my code as I refactored it and my initial logic with the refactor stayed strong as nothing suprised me. 


card front assets 
https://mreliptik.itch.io/playing-cards-packs-52-cards

card back asset
https://www.pikpng.com/pngvi/howwmho_purple-playing-card-back-png-download-playing-card-back-transparent-clipart/

I didn’t make any of the assets in this project.