### Get tag and increment package version
ref_name <- Sys.getenv("GITHUB_REF_NAME")
usethis:::use_description_field(
  name = "Version",
  value = ref_name,
  overwrite = TRUE,
  base_path = "."
)

### Build package
pkg_path <- pkgbuild::build(path = ".", dest_path = ".")
message(pkg_path)

### Upload to Tercen
