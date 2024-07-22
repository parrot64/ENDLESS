fileName$="test.dat"
REM working loop
do 
    print "Choose action:"
    print "1. List records"
    print "2. add new record"
    print "3. edit record"
    print "4. delete record"
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
    print "List items:"
    OPEN aFileName$ FOR RANDOM AS #file LEN=56
    FIELD #file, 50 AS testString$, 6 AS testNumber
        index=1
        while eof(#file) = 0
            GETTRIM #file, index
            print index; ". "; testString$; " "; testNumber
            index = index + 1
        wend
        if (index = 0) then
            print "<The file is empty>"
        end if
    close #file
    print
end sub
sub Add aFileName$
    print "Adding new record"
    OPEN aFileName$ FOR RANDOM AS #file LEN=56
    FIELD #file, 50 AS testString$, 6 AS testNumber
        ' fast forward to the end of file
        index=1
        while eof(#file) = 0
            GETTRIM #file, index
            index = index + 1
        wend
        input "testString$ >"; testString$
        input "testNumber >"; testNumber
        put #file, index
    close #file
    print
end sub
sub Edit aFileName$
    OPEN aFileName$ FOR RANDOM AS #file LEN=56
    FIELD #file, 50 AS testString$, 6 AS testNumber
        print "Edit record"
        input "record index >"; index
        input "testString$ >"; testString$
        input "testNumber >"; testNumber
        put #file, index
    close #file
    print
end sub
sub Delete aFileName$
    print "delete record"
    input "record index >"; indexToDelete
    tempFileName$="_"
    tempFileName$ = tempFileName$ + aFileName$
    OPEN aFileName$ FOR RANDOM AS #file LEN=56
    FIELD #file, 50 AS testString$, 6 AS testNumber
        OPEN tempFileName$ FOR RANDOM AS #file2 LEN=56
        FIELD #file2, 50 AS testString2$, 6 AS testNumber2
            index2=1
            index=1
            while eof(#file) = 0
                GETTRIM #file, index
                if (index2 <> indexToDelete) then
                    testString2$ = testString$
                    testNumber2 = testNumber
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
