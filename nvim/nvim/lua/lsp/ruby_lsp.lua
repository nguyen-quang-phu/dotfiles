return {
  mason = false,
  init_options = {
    enabledFeatures= {
      codeActions= true,
      codeLens= true,
      completion= true,
      definition= true,
      diagnostics= true,
      documentHighlights= true,
      documentLink= true,
      documentSymbols= true,
      foldingRanges= true,
      formatting= true,
      hover= true,
      inlayHint= true,
      onTypeFormatting= true,
      selectionRanges= true,
      semanticHighlighting= true,
      signatureHelp= true,
      typeHierarchy= true,
      workspaceSymbol= true
    },
    featuresConfiguration= {
      inlayHint= {
        implicitHashValue= true,
        implicitRescue= true
      },
    },
    addonSettings = {
      ["Ruby LSP Rails"] = {
        enablePendingMigrationsPrompt = false,
      },
    },
  },
}
