
global fileName$
fileName$="locations.dat"
global currentLocation
currentLocation=1
print "Maze quest"
while currentLocation<>0
    call processLocation
wend
print "Finish"
end
sub processLocation
    OPEN fileName$ FOR RANDOM AS #file LEN=100
    FIELD #file, 50 AS description$, 50 AS locationsIndexes$
        gettrim #file, currentLocation
    close #file
    print "Location:"
    print description$
    print "Possible locations to go: "; locationsIndexes$
    locationIndex = 0
    do
        input "Enter location number to go: ";index
        newString$=locationsIndexes$
        intVal=-1
        while len(newString$)<>0
            text$ = upto$(newString$,",")
            intVal = val(text$)
            if intVal = index then
                exit while
            end if
            newString$ = after$(newString$,",")
        wend
        if intVal = index then
            locationIndex = index
            exit do
        end if
    loop until true
    currentLocation = locationIndex
    print
end sub
