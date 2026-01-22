-- File path copy commands

-- Copy absolute path
vim.api.nvim_create_user_command('CopyPath', function()
	local path = vim.fn.expand('%:p')
	vim.fn.setreg('+', path)
	vim.notify('Copied absolute path: ' .. path)
end, { desc = 'Copy absolute file path to clipboard' })

-- Copy relative path
vim.api.nvim_create_user_command('CopyRelativePath', function()
	local path = vim.fn.expand('%:.')
	vim.fn.setreg('+', path)
	vim.notify('Copied relative path: ' .. path)
end, { desc = 'Copy relative file path to clipboard' })

-- Copy filename only
vim.api.nvim_create_user_command('CopyFilename', function()
	local filename = vim.fn.expand('%:t')
	vim.fn.setreg('+', filename)
	vim.notify('Copied filename: ' .. filename)
end, { desc = 'Copy filename to clipboard' })

-- Copy directory path
vim.api.nvim_create_user_command('CopyDirPath', function()
	local dir = vim.fn.expand('%:p:h')
	vim.fn.setreg('+', dir)
	vim.notify('Copied directory: ' .. dir)
end, { desc = 'Copy directory path to clipboard' })
