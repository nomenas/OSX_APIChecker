## APIChecker

APIChecker is unix batch script used for searching of usage of certain APIs in libraries located in some folder or bundle (in case of MacOS). Needed APIs may be specified in text file or one API may be passed as command line argument.

Additionally in this repository you can find file with MacOS APIs which are reported as private by Apple. Developers who will discover more MacOS private APIs are welcomed to update this list.

#### Usage

> APIChecker.sh api bundle
* api - text file with list of APIs which are searched in library or name of the required API
* bundle - path to the folder/bundle where specified APIs should be searched


#### EXAMPLES

>./APIChecker.sh svn_xml_free_parser /usr/local/lib

Finds all libraries from /usr/local/lib which use svn_xml_free_parser API.

> ./APIChecker.sh MacPrivateAPIs.in MyApp.app

Find all libraries from MyApp.app bundle which use some APIs specified in MacPrivateAPIs.in file.
