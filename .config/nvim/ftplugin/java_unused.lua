local home = os.getenv 'HOME'
local workspace_path = home .. '/.local/share/nvim/jdtls-workspace/'
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = workspace_path .. project_name

local status, jdtls = pcall(require, 'jdtls')
if not status then
    return
end

-- Function that is executed on attachment
local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set('n', '<A-o>', "<cmd>lua require('jdtls').organize_imports()<cr>", opts)
    vim.keymap.set('n', 'crv', "<cmd>lua require('jdtls').extract_variable()<cr>", opts)
    vim.keymap.set('x', 'crv', "<esc><cmd>lua require('jdtls').extract_variable(true)<cr>", opts)
    vim.keymap.set('n', 'crc', "<cmd>lua require('jdtls').extract_constant()<cr>", opts)
    vim.keymap.set('x', 'crc', "<esc><cmd>lua require('jdtls').extract_constant(true)<cr>", opts)
    vim.keymap.set('x', 'crm', "<esc><Cmd>lua require('jdtls').extract_method(true)<cr>", opts)
end

-- JDTLS capabilities
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- Merge vim.lsp capabilities with cmp_nvim_lsp capabilities
local capabilities = vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), require('cmp_nvim_lsp').default_capabilities())
capabilities.workspace.configuration = true

-- The command that starts the language server
-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
local cmd = {
    'java',

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    --'-javaagent:/Users/oskar/.language_servers/jdt-language-server/lombok.jar',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',

    '-jar',
    --'/Users/oskar/.language_servers/jdt-language-server/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    '/Users/oskar/.language_servers/jdt-language-server/plugins/org.eclipse.equinox.launcher_1.6.500.v20230622-2056.jar',
    --'/Users/oskar/.language_servers/jdt-language-server/plugins/org.eclipse.equinox.launcher_1.6.600.v20231012-1237',
    '-configuration',
    '/Users/oskar/.language_servers/jdt-language-server/config_mac',
    '-data',
    '/Users/oskar/local/share/nvim/java',
    --workspace_dir,
}

-- Setting for the language server
local settings = {
    java = {
        home = '/Library/Java/JavaVirtualMachines/jdk-21.0.2.jdk/Contents/Home',
        server = { launchMode = 'Hybrid' },
        eclipse = {
            downloadSources = true,
        },
        signatureHelp = {
            enabled = true,
            description = { enabled = true },
        },
        configuration = {
            updateBuildConfiguration = 'interactive',
        },
        extendedClientCapabilities = extendedClientCapabilities,
        import = { enabled = true },
        rename = { enabled = true },
        maven = { downloadSources = true },
        implementationsCodeLens = {
            enabled = true,
        },
        referencesCodeLens = { enabled = true },
        references = { includeDecompiledSources = true },
        inlayHints = {
            parameterNames = {
                enabled = 'all', -- literals, all, none
            },
        },
        format = {
            settings = {
                -- Use Google Java style guidelines for formatting
                url = '/.config/nvim/formatter/eclipse-java-google-style.xml',
                profile = 'GoogleStyle',
            },
        },
        completion = {
            favoriteStaticMembers = {
                'org.hamcrest.MatcherAssert.assertThat',
                'org.hamcrest.Matchers.*',
                'org.hamcrest.CoreMatchers.*',
                'org.junit.jupiter.api.Assertions.*',
                'java.util.Objects.requireNonNull',
                'java.util.Objects.requireNonNullElse',
                'org.mockito.Mockito.*',
            },
            filteredTypes = {
                'com.sun.*',
                'io.micrometer.shaded.*',
                'java.awt.*',
                'jdk.*',
                'sun.*',
            },
            importOrder = {
                'java',
                'javax',
                'com',
                'org',
            },
        },
        contentProvider = {
            preferred = 'fernflower',
        },
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
        codeGeneration = {
            toString = {
                template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
            },
            hashCodeEquals = {
                useJava7Objects = true,
            },
            useBlocks = true,
        },
    },
}

local config = {
    --cmd = { vim.fn.expand 'jdtls' },
    --cmd = { vim.fn.expand '~/.local/share/nvim/mason/bin/jdtls' },
    cmd = cmd,
    on_attach = on_attach,
    root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew' },
    capabilities = capabilities,
    settings = settings,
    init_options = { bundles = {}, extendedClientCapabilities = extendedClientCapabilities },
    flags = {
        allow_incremental_sync = true,
    },
}

require('jdtls').start_or_attach(config)

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    pattern = { '*.java' },
    callback = function()
        local _, _ = pcall(vim.lsp.codelens.refresh)
    end,
})
