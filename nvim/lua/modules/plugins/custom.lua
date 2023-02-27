local custom = {}

custom["EdenEast/nightfox.nvim"] = {
  lazy = true,
  -- event = "BufRead",
}

custom["nyoom-engineering/oxocarbon.nvim"] = {
  lazy = true,
  -- event = "BufRead",
}

custom["mfussenegger/nvim-jdtls"] = {
  lazy = true,
  ft = "java",
}

custom["mfussenegger/nvim-dap"] = {
  lazy = true,
  ft = "java",
}

custom["Pocco81/DAPInstall.nvim"] = {
  lazy = true,
  ft = "java",
}

custom["Mofiqul/vscode.nvim"] = {
  lazy = false,
  -- event = "BufRead",
}


return custom
