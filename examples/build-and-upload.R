### Get tag and increment package version
ref_name <- "0.0.99" #Sys.getenv("GITHUB_REF_NAME")

semver_regex <- "^(0|[1-9]\\d*)\\.(0|[1-9]\\d*)\\.(0|[1-9]\\d*)(?:-((?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\\.(?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\\+([0-9a-zA-Z-]+(?:\\.[0-9a-zA-Z-]+)*))?$"
if(!grepl(pattern = semver_regex, ref_name)) stop("Invalid semantic version.")

desc <- readLines("./DESCRIPTION")
desc2 <- gsub(pattern = "Version:.*", replace = paste0("Version: ", ref_name), x = desc)
desc3 <- gsub(pattern = "Date:.*", replace = paste0("Date: ", Sys.Date()), x = desc2)
writeLines(desc3, con = "./DESCRIPTION")

message(getwd())

### Build package
pkg_path <- pkgbuild::build(path = ".", dest_path = ".")
message(pkg_path)

### Upload to Tercen
