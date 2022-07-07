local function makeclass(super)
	super = super or {}

	local newclass = {};
	local classmeta = {__index = newclass};
	function newclass:class()        return newclass; end
	function newclass:superclass() return super;     end
	function newclass:instanceof(targetclass) 
		local b_isa = false;
		local cur_class = newclass;
		while ( nil ~= cur_class ) and ( false == b_isa ) do
			if cur_class == targetclass then
				b_isa = true;
			else
				cur_class = cur_class:superclass();
			end
		end
		return b_isa; 
	end
	function newclass:inherit() return makeclass(newclass) end;
	function newclass.new(...)
		local self = setmetatable({}, classmeta);
		self:_construct(...);
		return self;
	end
	function newclass:dispose()
		self:_destructo();
		
	end

	function newclass:_construct() end -- overwrite;
	function newclass:_destruct()  end -- overwrite;
	-- The following is the key to implementing inheritance:
	-- The __index member of the new class's metatable references the
	-- base class.  This implies that all methods of the base class will
	-- be exposed to the sub-class, and that the sub-class can override
	-- any of these methods.
	setmetatable( newclass, { __index = super } );
	return newclass;
end



return makeclass;