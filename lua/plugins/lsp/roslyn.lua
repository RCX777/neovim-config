return {
  'seblyng/roslyn.nvim',
  ft = 'cs',
  opts = {
    config = {
      settings = {
        ['csharp|background_analysis'] = {
          dotnet_compiler_diagnostics_scope = 'fullSolution',
        },
        ['csharp|symbol_search'] = {
          dotnet_search_reference_assemblies = true,
        },
        ['csharp|code_lens'] = {
          dotnet_enable_references_code_lens = true,
        },
      },
    },
    broad_search = true,
  },
}

