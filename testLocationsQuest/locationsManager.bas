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
    FIELD #file, 50 AS description$, 50 AS locationsIndexes$
        index=1
        while eof(#file) = 0
            GETTRIM #file, index
            print index; ". "; description$; ": "; locationsIndexes$
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
    FIELD #file, 50 AS description$, 50 AS locationsIndexes$
        ' fast forward to the end of file
        index=1
        while eof(#file) = 0
            GETTRIM #file, index
            index = index + 1
        wend
        input "description$ >"; description$
        line input "locationsIndexes$ >"; locationsIndexes$
        put #file, index
    close #file
    print
end sub
sub Edit aFileName$
    OPEN aFileName$ FOR RANDOM AS #file LEN=100
    FIELD #file, 50 AS description$, 50 AS locationsIndexes$
        print "Edit location"
        input "location index >"; index
        input "description$ >"; description$
        input "locationsIndexes$ >"; locationsIndexes$
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
    FIELD #file, 50 AS description$, 50 AS locationsIndexes$
        OPEN tempFileName$ FOR RANDOM AS #file2 LEN=100
        FIELD #file2, 50 AS description2$, 50 AS locationsIndexes2$
            index2=1
            index=1
            while eof(#file) = 0
                GETTRIM #file, index
                if (index2 <> indexToDelete) then
                    description2$ = description$
                    locationsIndexes2$ = locationsIndexes$
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
