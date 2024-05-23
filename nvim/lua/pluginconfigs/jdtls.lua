local config = {}
local cache_vars = {}

local root_files = {
  '.git',
  'mvnw',
  'gradlew',
  'pom.xml',
  'build.gradle',
}


local function get_jdtls_paths()
  if cache_vars.paths then
    return cache_vars.paths
  end

  local path = {}

  path.data_dir = vim.fn.stdpath('cache') .. '/nvim-jdtls'

  local jdtls_install = require('mason-registry')
      .get_package('jdtls')
      :get_install_path()

  local lombok_install = require('mason-registry')
      .get_package('lombok-nightly')
      :get_install_path()

  path.lombok_jar = lombok_install .. '/lombok.jar'
  path.launcher_jar = vim.fn.glob(jdtls_install .. '/plugins/org.eclipse.equinox.launcher_*.jar')

  if vim.fn.has('mac') == 1 then
    path.platform_config = jdtls_install .. '/config_mac'
  elseif vim.fn.has('unix') == 1 then
    path.platform_config = jdtls_install .. '/config_linux'
  elseif vim.fn.has('win32') == 1 then
    path.platform_config = jdtls_install .. '/config_win'
  end

  ---
  -- Useful if you're starting jdtls with a Java version that's
  -- different from the one the project uses.
  ---
  path.runtimes = {
    -- Note: the field `name` must be a valid `ExecutionEnvironment`,
    -- you can find the list here:
    -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    --
    -- This example assume you are using sdkman: https://sdkman.io
    -- {
    --   name = 'JavaSE-17',
    --   path = vim.fn.expand('~/.sdkman/candidates/java/17.0.6-tem'),
    -- },
    -- {
    --   name = 'JavaSE-18',
    --   path = vim.fn.expand('~/.sdkman/candidates/java/18.0.2-amzn'),
    -- },
  }

  cache_vars.paths = path

  return path
end

local on_attach = function(client, bufnr)

			end

local function get_jdtls_config()
  -- local jdtls = require('jdtls')

  local path = get_jdtls_paths()
  local data_dir = path.data_dir .. '/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  local cmd = {
    -- 💀
    'java',

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-javaagent:' .. path.lombok_jar,
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    -- 💀
    '-jar',
    path.launcher_jar,

    -- 💀
    '-configuration',
    path.platform_config,

    -- 💀
    '-data',
    data_dir,
  }

  local lsp_settings = {
    java = {
      -- jdt = {
      --   ls = {
      --     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx4G -Xms256m"
      --   }
      -- },
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = 'interactive',
        runtimes = path.runtimes,
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      -- inlayHints = {
      --   parameterNames = {
      --     enabled = 'all' -- literals, all, none
      --   }
      -- },
      format = {
        enabled = true,
        -- settings = {
        --   profile = 'asdf'
        -- },
      }
    },
    signatureHelp = {
      enabled = true,
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
    },
    contentProvider = {
      preferred = 'fernflower',
    },
    -- extendedClientCapabilities = jdtls.extendedClientCapabilities,
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      }
    },
    codeGeneration = {
      toString = {
        template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
      },
      useBlocks = true,
    },
  }

  config.cmd = cmd
  config.setting = lsp_settings
  return config
end

return get_jdtls_config()
