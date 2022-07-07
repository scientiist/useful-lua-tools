local StateMachine = {}
StateMachine.__index = StateMachine;

function StateMachine.new(class)
	local self = setmetatable({}, StateMachine);

	self.AttachedToClass = class;
	self.States = {};
	self.CurrentState= nil;
	self.PreviousState = nil;
	self.CurrentStateID = "undefined";
	self.StateTransitioned = false;


	return self;
end



function StateMachine:Define(name, state)

end

function StateMachine:GetState() : string
	return self.CurrentStateID;
end

function StateMachine:SetState(nextStateID)
	self.StateTransitioned = false;
	self.CurrentState = self.States[nextStateID];
	self.CurrentStateID = nextStateID;
	return self.PreviousState;

end

function StateMachine:Update(delta)
	if self.StateTransitioned == false then
		self.StateTransitioned = true;
		if self.PreviousState then
			self.PreviousState.Stop(self.AttachedToClass);
		end
		if self.CurrentState then
			self.CurrentState.Start(self.AttachedToClass);
		end
	end

	if self.CurrentState then
		self.CurrentState.Step(self.AttachedToClass);
	end

end

return StateMachine;