fileName$="locations.dat"
' working loop
do 
    print "Choose action:"
    print "1. List locations"
    print "2. add new location"
    print "3. edit location"
    print "4. delete location"
    input "Choose action:"; action
    select case action
        case 1
            call List fileName$
        case 2
            call Add fileName$
        case 3
            call Edit fileName$
        case 4 
            call Delete fileName$
        case else
            exit do
    end select
loop until true
end
' main subroutines
sub List aFileName$
    print "List locations:"
    OPEN aFileName$ FOR RANDOM AS #file LEN=100
    FIELD #file, 50 AS description$, 5 AS north, 5 AS south, 5 as west, 5 AS east, 5 AS endRow
        index=1
        while eof(#file) = 0
            GETTRIM #file, index
            print index; ". "; chr$(34); description$; chr$(34); 
            print " north: "; north ; " south: "; south; " west: "; west; " east: "; east;
            print " endRow: "; endRow
            index = index + 1
        wend
        if (index = 1) then
            print "<The file is empty>"
        end if
    close #file
    print
end sub
sub Add aFileName$
    print "Adding new location"
    OPEN aFileName$ FOR RANDOM AS #file LEN=100
    FIELD #file, 50 AS description$, 5 AS north, 5 AS south, 5 as west, 5 AS east, 5 AS endRow
        ' fast forward to the end of file
        index=1
        while eof(#file) = 0
            GETTRIM #file, index
            index = index + 1
        wend
        input "description$ >"; description$
        input "north >"; north
        input "south >"; south
        input "west >"; west
        input "east >"; east
        input "endRow >"; endRow
        put #file, index
    close #file
    print
end sub
sub Edit aFileName$
    OPEN aFileName$ FOR RANDOM AS #file LEN=100
    FIELD #file, 50 AS description$, 5 AS north, 5 AS south, 5 as west, 5 AS east, 5 AS endRow
        print "Edit location"
        input "location index >"; index
        input "description$ >"; description$
        input "north >"; north
        input "south >"; south
        input "west >"; west
        input "east >"; east
        put #file, index
    close #file
    print
end sub
sub Delete aFileName$
    print "delete location"
    input "location index >"; indexToDelete
    tempFileName$="_"
    tempFileName$ = tempFileName$ + aFileName$
    OPEN aFileName$ FOR RANDOM AS #file LEN=100
    FIELD #file, 50 AS description$, 5 AS north, 5 AS south, 5 as west, 5 AS east, 5 AS endRow
        OPEN tempFileName$ FOR RANDOM AS #file2 LEN=100
        FIELD #file2, 50 AS description2$, 5 AS north2, 5 AS south2, 5 as west2, 5 AS east2, 5 AS endRow2
            index2=1
            index=1
            while eof(#file) = 0
                GETTRIM #file, index
                if (index2 <> indexToDelete) then
                    description2$ = description$
                    locationsIndexes2$ = locationsIndexes$
                    north2 = north
                    south2 = south
                    west2 = west
                    east2 = east
                    endRow2 = endRow
                    put #file2, index2
                    index2 = index2+1
                end if
                index = index + 1
            wend
        close #file2
    close #file
    print
'    kill aFileName$
'    name tempFileName$ as aFileName$
end sub
