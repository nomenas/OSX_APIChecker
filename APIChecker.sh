if [ "$1" = "" ] || [ "$2" = "" ] || [ ! -d $2 ]; then
    echo "Usage:" 
    echo "APIChecker.sh <api> <bundle>"
    echo "    <api>    - text file with list of APIs which are searched in library or name of the required API"
    echo "    <bundle> - path to the folder/bundle where specified APIs should be searched" 
else
    rm -rf .APIChecker
    mkdir .APIChecker
    find $2 -perm -111 -type f | awk '{print "LIB_FILE=$(basename "$1") && nm -u "$1" 2>/dev/null | sed s/.*\ // >.APIChecker/$LIB_FILE.dat"}' | sh

    INPUTFILE=$1
    if [ ! -f $INPUTFILE ]; then
        echo $1 > .APIChecker/symbols.in
        INPUTFILE=.APIChecker/symbols.in
    fi

    cat $INPUTFILE | awk '{print "grep "$1" .APIChecker/*.dat"}' | sh | sed s/.APIChecker\\/// | sed s/.dat:/\ / | awk '{print "echo \"    \""$2" >> .APIChecker/"$1".out"}' | sh
    find .APIChecker -type f -size -1 -exec rm {} \;
    
    FILTER=$(find .APIChecker -maxdepth 1 -name *.out | wc -l)
    if [ ${FILTER} != 0 ]; then
        ls -l .APIChecker/*.out | awk '{print "basename "$9" .out && cat "$9}' | sh
    else
	    echo $2 "doesn't contains libraries which use specified APIs"
    fi

    rm -rf .APIChecker
fi
