GGCredit
============

GGCredit makes it easy to include a form of currency in your game.

Basic Usage
-------------------------

##### Require The Code
```lua
local GGCredit = require( "GGCredit" )
```

##### Create or load a credit object
```lua
local credit = GGCredit:new()
```

##### Earn some credits
```lua
credit:earn( 100 )
```

##### Spend some credits
```lua
credit:spend( 60 )
```

##### Get the current balance
```lua
local current = credit:currentBalance()
```

##### Check if the player has enough to spend some credits
```lua
if credit:canAfford( 40 ) then

end
```

##### Reset the credit object
```lua
credit:reset()
```

##### Destroy this GGCredit object
```lua
credit:destroy()
```

Update History
-------------------------

##### 0.1
Initial release