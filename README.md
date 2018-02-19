

## Usage
Just copy all scripts to opam-repository/ in order to update packages

## Scripts

### Change-version
Changes a version of opam packages in opam file.
Examples:
```
./change-version.sh old_version new_version
./change-version.sh old_version new_version package1,package2,...
./change-version.sh old_version new_version exclude package1,package2,...
```
Note, that version must be either `master` or string with dot-separated digits:
`1.3`, `1.4.0`.

### Set-url
Changes url file for opam packages. Doesn't create it if file not exists (e.g. for conf packages).
Set up url for either:
 - all packages with specified version;
 - for specified packages and specified version;
 - for all packages of specified version except exluded.
Examples:
```
./set-url.sh url version
./set-url.sh url version package1,package2,...
./set-url.sh url version exclude package1,package2,...
```
If url is an archive, then appropriate url file will be generated:
with an `archive` and `md5sum` fields.

### Release
Creates a new package from master version. Setup url and package version
in opam file as it should be.
Examples:
```
./release.sh url new_version
./release.sh url new_version package1,package2,...
./release.sh url new_version exclude package1,package2,...
```
