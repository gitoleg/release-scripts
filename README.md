

## Usage
Just copy all scripts to opam-repository/ in order to update packages
or set up REPO env variable

## Scripts

### Change-version
Changes a version of opam packages in opam file.
Examples:
```
./pack.sh change-version old_version new_version
./pack.sh change-version old_version new_version package1,package2,...
./pack.sh change-version old_version new_version exclude package1,package2,...
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
./pack.sh set-url url version
./pack.sh set-url url version package1,package2,...
./pack.sh set-url url version exclude package1,package2,...
```
If url is an archive, then appropriate url file will be generated:
with an `archive` and `md5sum` fields.

### Release
Creates a new package from master version. Setup url and package version
in opam file as it should be.
Examples:
```
./pack.sh release url new_version
./pack.sh release url new_version package1,package2,...
./pack.sh release url new_version exclude package1,package2,...
```
One can release package (packages) based on any other than master version:
```
BASE=desired-version ./pack.sh release url version
```
### Remove
Removes a specified version of opam packages from repository.
Examples:
```
./pack.sh remove version
./pack.sh remove version package1,package2,...
./pack.sh remove version exclude package1,package2,...
```
