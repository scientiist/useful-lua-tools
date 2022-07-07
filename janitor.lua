local Janitor = {}
Janitor.__index = Janitor;

function Janitor.new()
	local self = setmetatable({}, Janitor);
	self.Signals = {};
	self.ReturnCalls = {};
	self.Objects = {};
	return self;
end

function Janitor:AddSignal(signal: RBXScriptSignal): number
	table.insert(self.Signals, signal);
	return table.find(self.Signals, signal) :: number; -- signal ID for remove;
end

function Janitor:AddCallback(callback: (any)->nil) : number
	table.insert(self.ReturnCalls, callback);
	return table.find(self.ReturnCalls, callback) :: number;
end

function Janitor:AddObject(instance) : number
	table.insert(self.Objects, instance);
	return table.find(self.Objects, instance) :: number;
end

function Janitor:RemoveSignal(signalID: number)
	table.remove(self.Signals, signalID);
end

function Janitor:RemoveCallback(callbackID: number)
	table.remove(self.ReturnCalls, callbackID);
end

function Janitor:RemoveObject(objectID: number)
	table.remove(self.Objects, objectID);
end

function Janitor:ClearSignals() 
	for index, signal in self.Signals do
		signal:Disconnect();
	end
	self.Signals = {}; 
end
function Janitor:ClearCallbacks() 
	for index, callback in self.Callbacks do
		callback();
	end
	self.ReturnCalls = {}; 
end
function Janitor:ClearObjects() 
	for index, instance in pairs(self.Objects) do
		instance:Destroy();
	end
	self.Objects = {}; end

-- Removes all connected signals;
function Janitor:Clear()
	self:ClearSignals();
	self:ClearCallbacks();
	self:ClearObjects();
end

-- Destroys the Janitor;
function Janitor:Destroy()
	self:Clear();
	setmetatable(self, nil);
end
Janitor.__call = Janitor.Destroy;
return Janitor;