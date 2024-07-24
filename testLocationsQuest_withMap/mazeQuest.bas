global currentLocation
currentLocation=1
print "Maze quest"
print "1. new game"
print "2. continue"
do
    input "action: "; action
    SELECT CASE action
        CASE 1
            call INITGAMESTATE
            exit do
        CASE 2
            exit do
        CASE ELSE
            PRINT "Invalid choice. Please enter a number from the menu."
    END SELECT
loop until true
while currentLocation<>0
    call processLocation
wend
print "Finish"
end
sub processLocation
    OPEN "locations.dat" FOR RANDOM AS #file LEN=100
    FIELD #file, 50 AS description$, 5 AS north, 5 AS south, 5 as west, 5 AS east, 5 AS endRow
        gettrim #file, currentLocation
    close #file
    print "Location: "; chr$(34); description$; chr$(34)
    print "Choose action: "
    print "1. move"
    print "2. map"
    do
        input "action: "; action
        SELECT CASE action
            CASE 1
                call MOVE north, south, west, east
                if currentLocation > 0 then
                    call SAVE currentLocation
                end if
                exit do
            CASE 2
                call MAP
            CASE ELSE
                PRINT "Invalid choice. Please enter a number from the menu."
        END SELECT
    loop until true
    print
end sub
sub INITGAMESTATE
    OPEN "gameState.dat" FOR RANDOM AS #fileGameState LEN=5
    FIELD #fileGameState, 5 AS visited
        OPEN "locations.dat" FOR RANDOM AS #file LEN=100
        FIELD #file, 50 AS description$, 5 AS north, 5 AS south, 5 as west, 5 AS east, 5 AS endRow
            index=1
            while eof(#file) = 0
                GETTRIM #file, index
                visited = 0
                put #fileGameState, index
                index = index + 1
            wend
        close #file
    close #fileGameState
end sub
sub MOVE aNorth, aSouth, aWest, anEast
    if aNorth = 0 then 
        print "1. Finish"
    end if
    if aNorth > 0 then 
        print "1. North"
    end if
    if aSouth = 0 then 
        print "2. Finish"
    end if
    if aSouth > 0 then 
        print "2. South"
    end if
    if aWest = 0 then 
        print "3. Finish"
    end if
    if aWest > 0 then 
        print "3. West"
    end if
    if anEast = 0 then 
        print "4. Finish"
    end if
    if anEast > 0 then 
        print "4. East"
    end if
    do
        input "direction: "; direction
        SELECT CASE direction
            CASE 1
                if aNorth > -1 then
                    currentLocation = aNorth
                    exit do
                end if
            CASE 2
                if aSouth > -1 then
                    currentLocation = aSouth
                    exit do
                end if
            CASE 3
                if aWest > -1 then
                    currentLocation = aWest
                    exit do
                end if
            CASE 4
                if anEast > -1 then
                    currentLocation = anEast
                    exit do
                end if
            CASE ELSE
                PRINT "Invalid choice. Please enter a number from the menu."
        END SELECT
    loop until true
end sub
sub SAVE aLocation
    OPEN "gameState.dat" FOR RANDOM AS #fileGameState LEN=5
    FIELD #fileGameState, 5 AS visited
        visited = 1
        put #fileGameState, aLocation
    close #fileGameState
end sub
sub MAP
' print first row
    OPEN "gameState.dat" FOR RANDOM AS #fileGameState LEN=5
    FIELD #fileGameState, 5 AS visited
        OPEN "locations.dat" FOR RANDOM AS #file LEN=100
        FIELD #file, 50 AS description$, 5 AS north, 5 AS south, 5 as west, 5 AS east, 5 AS endRow
            index=1
            while eof(#file) = 0
                GETTRIM #file, index
                get #fileGameState, index
                if index = 1 then
                    print "+-";
                else
                    if endRow > 0 then
                        print "-+"
                        exit while
                    else
                        print "--";
                    end if
                end if
                index = index + 1
            wend
        close #file
    close #fileGameState

    OPEN "gameState.dat" FOR RANDOM AS #fileGameState LEN=5
    FIELD #fileGameState, 5 AS visited
        OPEN "locations.dat" FOR RANDOM AS #file LEN=100
        FIELD #file, 50 AS description$, 5 AS north, 5 AS south, 5 as west, 5 AS east, 5 AS endRow
            index=1
            nextLine$="+"
            while eof(#file) = 0
                GETTRIM #file, index
                if nextLine$ = "+" then
                    print "|";
                end if
                get #fileGameState, index
                if visited > 0 then
                    if currentLocation = index then
                        print "@";
                    else
                        print " ";
                    end if
                    if east < 0 then
                        print "|";
                    else
                        print " ";
                    end if
                    if south < 0 then 
                        nextLine$ = nextLine$ + "-+"
                    else
                        nextLine$ = nextLine$ + " +"
                    end if
                else
                    print "..";
                    nextLine$ = nextLine$ + ".."
                end if
                if endRow > 0 then
                    print
                    print nextLine$
                    nextLine$ = "+"
                end if
                index = index + 1
            wend
        close #file
    close #fileGameState
end sub