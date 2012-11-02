-- Project: GGCredit
--
-- Date: November 2, 2012
--
-- Version: 0.1
--
-- File name: GGCredit.lua
--
-- Author: Graham Ranson of Glitch Games - www.glitchgames.co.uk
--
-- Update History:
--
-- 0.1 - Initial release
--
-- Comments: 
--
--		GGCredit makes it easy to include a form of currency in your game.	
--
-- Copyright (C) 2012 Graham Ranson, Glitch Games Ltd.
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of this 
-- software and associated documentation files (the "Software"), to deal in the Software 
-- without restriction, including without limitation the rights to use, copy, modify, merge, 
-- publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons 
-- to whom the Software is furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all copies or 
-- substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
-- INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
-- PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
-- FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
-- OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
-- DEALINGS IN THE SOFTWARE.
--
----------------------------------------------------------------------------------------------------

local GGCredit = {}
local GGCredit_mt = { __index = GGCredit }

local json = require( "json" )

local time = os.time
local date = os.date
local sort = table.sort

--- Initiates a new GGCredit object.
-- @return The new object.
function GGCredit:new()
    
    local self = {}
    
    setmetatable( self, GGCredit_mt )

	self.balance = 0
	
	self:load()
	
    return self
    
end

--- Adds some credits to the current balance.
-- @param amount The amount of credits to earn.
function GGCredit:earn( amount )
	self.balance = self.balance + amount
	self:save()
end

--- Removes some credits to the current balance.
-- @param spends The amount of credits to spend.
function GGCredit:spend( amount )
	if self:canAfford( amount ) then
		self.balance = self.balance - amount
	end
	self:save()
end

--- Gets the current balance.
-- @return The credit balance.
function GGCredit:currentBalance()
	return self.balance
end

--- Checks if the player has enough credits to spend.
-- @return True if the player can afford it, false otherwise.
function GGCredit:canAfford( amount )
	return self:currentBalance() - amount >= 0
end

--- Saves the current balance to disk.
function GGCredit:save()

	local path = system.pathForFile( "credit.dat", system.DocumentsDirectory )
	local file = io.open( path, "w" )
		
	if not file then
		return
	end	
	
	local data = { balance = self:currentBalance() }
	file:write( json.encode( data ) )
	io.close( file )
	file = nil
		
end

--- Loads the current balance from disk.
function GGCredit:load()
	
	local path = system.pathForFile( "credit.dat", system.DocumentsDirectory )
	local file = io.open( path, "r" )
	
	if not file then
		return
	end
	
	local data = json.decode( file:read( "*a" ) )
	
	self.balance = data.balance
	
	io.close( file )
	
	return self
	
end

--- Resets this GGCredit object.
function GGCredit:reset()
	self.balance = 0
	os.remove( system.pathForFile( "credit.dat", system.DocumentsDirectory ) )
end

--- Destroys this GGCredit object.
function GGCredit:destroy()
	self.balance = nil
end

return GGCredit