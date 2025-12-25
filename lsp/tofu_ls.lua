return {
  cmd = { "tofu-ls", "--stdio" },
  filetypes = { "tf", "opentofu", "openapi", "terraform", "tofu", "opentofu-vars" },
  root_markers = { ".terraform", ".git", "main.tf" },
}
