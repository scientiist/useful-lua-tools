return function()
	local event = {}
	event.Bindings = {};
	function event:Connect(callbk)
		table.insert(self.Bindings, callbk)
	end
	function event:Call(...)
		for _, func in pairs(self.Bindings) do
			func(...);
		end
	end
	
	return event;
end