local executablePath

return {
    {
        'mfussenegger/nvim-dap',
        lazy = true,
        event = 'VeryLazy',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'nvim-neotest/nvim-nio',
            'theHamsta/nvim-dap-virtual-text',
        },
        config = function(_, _)
            local dap = require 'dap'
            local dap_virtual_text = require 'nvim-dap-virtual-text'
            local ui = require 'dapui'

            ui.setup()

            -- Dap Virtual Text
            dap_virtual_text.setup()

            -- Configurations
            local c_debugger = vim.fn.exepath 'lldb-dap'
            if c_debugger ~= nil then
                dap.adapters.lldb = {
                    type = 'executable',
                    command = c_debugger,
                    name = 'lldb',
                }

                local c_config = {
                    {
                        name = 'Launch file',
                        type = 'lldb',
                        request = 'launch',
                        program = function()
                            return executablePath
                        end,
                        cwd = '${workspaceFolder}',
                        stopAtEntry = false,
                        args = {},
                        initCommands = { 'breakpoint set -n main' },
                    },
                }

                dap.configurations.c = c_config
                dap.configurations.cpp = c_config
            end

            -- Dap UI
            dap.listeners.before.attach.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                ui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                ui.close()
            end

            dap.listeners.after.event_exited.cleanup_breakpoints = function()
                local breakpoints = dap.list_breakpoints()
                if breakpoints == nil then
                    return
                end

                for _, bp in ipairs(breakpoints) do
                    dap.clear_breakpoints(bp.file)
                end
            end

            -- Keybinds
            vim.keymap.set('n', '<F5>', function()
                executablePath = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                if vim.fn.filereadable(executablePath) == 0 then
                    vim.print 'Could not open executable.'
                    return
                end
                dap.continue()
            end)
            vim.keymap.set('n', '<F10>', function()
                dap.step_into()
            end)
            vim.keymap.set('n', '<F11>', function()
                dap.step_over()
            end)
            vim.keymap.set('n', '<F12>', function()
                dap.step_out()
            end)

            vim.keymap.set('n', '<leader>du', function()
                dap.up()
            end)
            vim.keymap.set('n', '<leader>dd', function()
                dap.down()
            end)

            vim.keymap.set('n', '<leader>db', function()
                dap.toggle_breakpoint()
            end)
            vim.keymap.set('n', '<leader>dB', function()
                dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
            end)
            vim.keymap.set('n', '<leader>dc', function()
                dap.clear_breakpoints()
            end)

            vim.keymap.set('n', '<leader>d?', function()
                ui.eval(nil, { enter = true })
            end)

            vim.keymap.set('n', '<leader>dr', function()
                dap.restart()
            end)
            vim.keymap.set('n', '<leader>dt', function()
                dap.terminate()
            end)
        end,
    },
}
