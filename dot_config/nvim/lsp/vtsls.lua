-- https://github.com/yioneko/vtsls/blob/main/packages/service/configuration.schema.json
return {
  mason = false,
  settings = {
    typescript = {
      referencesCodeLens = {
        enabled = true;
        showOnAllFunctions = true;
      },
      implementationsCodeLens = {
        enabled = true;
        showOnInterfaceMethods = true;
      },
      preferGoToSourceDefinition = true;
      suggest = {
        completeFunctionCalls = true;
      }
    },
    javascript = {
      referencesCodeLens = {
        enabled = true;
        showOnAllFunctions = true;
      },
      preferGoToSourceDefinition = true;
      suggest = {
        completeFunctionCalls = true;
      }
    },
  },
}
