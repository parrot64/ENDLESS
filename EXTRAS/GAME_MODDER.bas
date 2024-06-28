PRINT "Welocome to the beta game manager!"
PRINT "If you don't know what is this then ill explain!"
PRINT "This is a tool for modifying hame values"
PRINT "For example:enemy stats,item stats and save files!"
PRINT "So what do you want to modify?"
PRINT ""
PRINT "DISCLAMER:YOU HAVE TO HAVE A SAVE FILE"
PRINT "IN ORDER FOR THIS TO WORK"
PRINT ""
PRINT "1. Save file"
PRINT "2. Enemy stats"
PRINT "3. Item stats"
PRINT "0. Exit"
DO
INPUT "choice: "; choice
    SELECT CASE choice
        CASE 1
CALL SAVEFILE
        CASE 2
CALL ENEMYFILES
        CASE 3
CALL ITEMSTATS
        CASE 0
            END
        CASE ELSE
            PRINT "Invalid choice. Please enter a number from the menu."
    END SELECT
LOOP UNTIL TRUE


SUB SAVEFILE
PRINT "SAVE_FILE"
END SUB

SUB ENEMYFILES
PRINT "ENEMY_FILES"
END SUB

SUB ITEMSTATS
PRINT "ITEM_STATS"
END SUB
