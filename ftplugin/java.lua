local ol = vim.opt_local

ol.tabstop = 4
ol.shiftwidth = 4
ol.softtabstop = 4
ol.expandtab = true
ol.autoindent = true
ol.smartindent = true

local ok, jdtls = pcall(require, 'jdtls')

if not ok then
  return
end

local config = {
  cmd = { 'jdtls' },
  root_dir = vim.fs.dirname(vim.fs.find({
    'gradlew',
    '.git',
    'mvnw',
    'pom.xml',
    'build.gradle',
  }, { upward = true })[1]),
}

jdtls.start_or_attach(config)
