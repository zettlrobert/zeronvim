return {
  settings = {
    yaml = {
      schemas = {
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "/docker-compose.*.yaml",
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/**.yaml",
        ["https://json.schemastore.org/github-action.json"] = "/action.[yml|yaml]"
      }
    }
  }
}
