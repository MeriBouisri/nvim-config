local utils = require("utils.functions")

local _json, cjson = pcall(require,'cjson')

if not _json then
	print("json not found")
end

local M = {}

-- Keywords in json file
M.todo = "todo"
M.completed = "completed"
M.due_date = "due"
M.task_description = "task"

M.file = "/root/.todo.json"
M.tasks = {}

M.debug_mode = false
M.dummy_tasks = { 'null1', 'null2', 'null3' }

--- Return text contents of json from filename
M.read_tasks = function(filename)
	return table.concat(utils.lines_from(filename))
end

----- Return decoded json contents from filename
M.decode_tasks = function(filename)
	return cjson.decode(M.read_tasks(filename))
end

-- --
-- GETTERS
-- --

----- Get completion status of a task
-----@param json table json table
-----@param ntask string task number, as ordered in the table
----- @return true if task completed
M.is_completed = function(json, ntask)
	return json[ntask]["completed"]
end

----- Get description of a task
-----@param json table json table
-----@param ntask string task number, as ordered in the table
----- @return string description
M.get_task_description = function(json, ntask)
	return json[ntask]["task"]
end

--- Get due date of a task
---@param json table json table
---@param ntask string task number, as ordered in the table
--- @return string due_date due date of the task
M.get_due_date = function(json, ntask)
	return json[ntask]["due"]
end

-- --
-- SETTERS
-- --

---Set the description of a task 
---@param json table list of tasks
---@param ntask integer index of task
---@param description string the new description 
---@return table task the task at ntask that was modified. empty table if task index not larger than number of items in json
M.set_description = function(json, ntask, description)
	if ntask > #json then
		return {}
	end

	json[ntask]["task"] = description

	return json[ntask]
end
---Set a task as completed or uncompleted
---@param json table list of tasks
---@param ntask integer index of task
---@param completed boolean true if completed, false if not
---@return table task the task at ntask that was modified. empty table if task index not larger than number of items in json
M.set_completed = function(json, ntask, completed)
	if ntask > #json then 
		return {} 
	end

	json[ntask]["completed"] = completed

	return json
end

---Set the due date of a task 
---@param json table list of tasks
---@param ntask integer index of task
---@param due_date string the new due date
---@return table task the task at ntask that was modified. empty table if task index not larger than number of items in json
M.set_due_date = function(json, ntask, due_date)
	if ntask > #json then
		return {}
	end

	json[ntask]["due"] = due_date

	return json[ntask]
end

-- --
-- LIST MANIPULATION
-- --

--- Add task at the end of list
---@param json table json that contains list of tasks
---@param description string description of task
---@param due_date string Due date of task
---@return table tasks modified list passed in parameters
M.append_task = function(json, description, due_date)
	new_task = {
		description = description,
		completed = false,
		due = due_date
	}

	json[#json + 1] = new_task

	return json
end

--- Remove task at index
---@param json table json that contain list of tasks
---@param ntask integer index of the task
---@return table task table containing data of removed task
M.remove_task = function(json, ntask)
	return table.remove(json, ntask)
end

---Format single task to appear on screen
---
M.format_task = function(task)
	-- dont know why cant put keyword in variables
	local str_completed = task["completed"] and 'y' or 'n'
	local str_due_date = task["due"]
	local str_description = task["task"]

	local formatted = '[' .. str_completed .. '] ' .. str_description .. ' - ' .. str_due_date

	return formatted
end

--- Format task data to appear on the screen
---@param json table the json file that contains task data 
---@return table formatted table containing formatted strings for each task
M.format_all_tasks = function(json)

	local formatted_tasks = {}

	for i, v in ipairs(json) do
		formatted_tasks[i] = M.format_task(v)
	end

	return formatted_tasks
end


--- Function to call to setup the program.
---@return boolean success true if setup successful, false if not
M.setup = function()
	--TODO change to actual param filename
	if M.debug_mode then
		M.test()
		return false
	end

	local json = M.decode_tasks(M.file)
	M.tasks = M.format_all_tasks(json[M.todo])

	return true
end

--- Function for tests. M.tasks not initialized yet
M.test = function()

	-- initialize tasks for dependencies
	M.tasks = M.dummy_tasks

	local tasks = {}
	local json = M.decode_tasks(M.file)
	local task = json[M.todo][1]
	
	local formatted_tasks = M.format_all_tasks(json[M.todo])
	for i, v in ipairs(formatted_tasks) do
		print(v)
	end
end


return M

