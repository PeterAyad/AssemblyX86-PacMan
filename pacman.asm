RECTANGLE_DRAW MACRO	COLOR,X_START,X_END,Y_START,Y_END
	               LOCAL DRAW_PIXEL
	               LOCAL DRAW_ROW
	               MOV   AL,COLOR  	; COLOR OF RECTANLGE
	               MOV   CX,X_START	; X1 OF RECTANLGE
	               MOV   DI,X_START	; COPY OF X1
	               MOV   BX,X_END  	; X2 OF RECTANLGE
	               MOV   DX,Y_START	; Y1 OF RECTANLGE
	               MOV   BP,Y_END  	; Y2 OF RECTANLGE

	; IF X_START == X_END || Y_START == Y_END -> INFINITE LOOP
	; (IT JUST HAPPENS, TOO LAZY TO CHECK WHY :D )
	; NOTE: THE ENDS (X_END, Y_END) ARE NOT INCLUDED SO END CAN BE 620 OR 400
	; BUT START CAN START FROM 0

	DRAW_ROW:      
	DRAW_PIXEL:    
	               MOV   AH,0CH
	               INT   10H       	;DRAW
	               INC   CX        	;TAKE STEP TO THE RIGHT
	               CMP   CX, BX    	;CHECK THAT YOU DIDN'T REACH THE RIGHT END
	               JNE   DRAW_PIXEL	;REPEAT IF NO
				   
	               MOV   CX,DI     	;GO BACK TO THE START OF THE LINE (FAR LEFT)
	               INC   DX        	;TAKE STEP DOWN
	               CMP   DX,BP     	;CHECK THAT YOU DIDN'T REACH THE BOTTOM END
	               JNE   DRAW_ROW  	;REPEAT IF NO
ENDM

.MODEL SMALL
.STACK 64
.DATA

	; THIS MATRIX IS THE SCREEN DIVIDED INTO SMALL SQUARES EMPTY ONES ARE REPRESENTED BY 0
	MAZE_MATRIX                    DB 256 DUP(1)
	                               DB 1,1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,0
	                               DB 0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,1,1,1,1,1,1
	                               DB 1,1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,0
	                               DB 0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,1,1,1,1,1,1
	                               DB 1,1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	                               DB 0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1
	                               DB 1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0
	                               DB 0,0,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,0,0,0,0,1,1,1,1
	                               DB 1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0
	                               DB 0,0,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,0,0,0,0,1,1,1,1
	                               DB 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0
	                               DB 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1
	                               DB 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0
	                               DB 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1
	                               DB 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	                               DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1
	                               DB 1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	                               DB 0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1
	                               DB 1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	                               DB 0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1
	                               DB 1,1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,1,1,0,0,0,0,0
	                               DB 0,0,0,0,0,1,1,0,0,0,1,1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,1,1,1,1
	                               DB 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1,1,0,0,0,0,0
	                               DB 0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1,1,1,1
	                               DB 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1,1,0,0,0,0,0
	                               DB 0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1,1,1,1
	                               DB 1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1,1,1,1,1,1,1
	                               DB 1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1,1,1,1
	                               DB 1,1,0,0,0,0,0,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1
	                               DB 1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,0,0,0,1,1,1,1
	                               DB 1,1,1,1,0,0,0,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,0,0,0,1,1,0,0,0,0,0
	                               DB 0,0,0,0,0,1,1,0,0,0,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,0,0,0,1,1,1,1
	                               DB 1,1,1,1,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0
	                               DB 0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1
	                               DB 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0
	                               DB 0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1
	                               DB 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	                               DB 0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1
	                               DB 1,1,1,1,0,0,0,1,1,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1
	                               DB 1,1,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1
	                               DB 1,1,1,1,0,0,0,1,1,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1
	                               DB 1,1,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1
	                               DB 1,1,1,1,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1
	                               DB 1,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1
	                               DB 1,1,1,1,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1
	                               DB 1,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1
	                               DB 1,1,1,1,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1
	                               DB 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1
	                               DB 1,1,1,1,0,0,0,1,1,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1,1,0,0,0,1
	                               DB 1,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,1,1,1,1
	                               DB 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1,1,0,0,0,0
	                               DB 0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,1,1,1,1
	                               DB 1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,0,0,0,0
	                               DB 0,0,0,0,1,1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1
	                               DB 1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,0,0,0,0
	                               DB 0,0,0,0,1,1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,73 DUP(1)


	; MULTIPLIER IS HOW LARGE THE MATRIX CELL IS IN PIXELS
	MAZE_MATRIX_MULTIPLIER         DB 10

	; WIDTH IS HOW MANY MATRIX CELLS REPRESENT ONE ROW OF PIXELS
	MAZE_MATRIX_WIDTH              DW 64

	; MATRIX_ROW_LENGTH_IN_PIXELS = MAZE_MATRIX_MULTIPLIER * MAZE_MATRIX_WIDTH
	MATRIX_ROW_LENGTH_IN_PIXELS    DW 640

	; MATRIX_COLUMN_LENGTH_IN_PIXELS = MAZE_MATRIX_MULTIPLIER * MAZE_MATRIX_HEIGHT (33)
	MATRIX_COLUMN_LENGTH_IN_PIXELS DW 330

	; IT IS THE SAME MAZE MATRIX BUT EVERY CELL IS ZERO EXCEPT THE ONES WHERE THERE IS FOOD
	FOOD_MATRIX                    DB 326 DUP(0),2,0,2,0,2,0,2,0,0,0,0,0,2,0,2,0,2,0,0,0,0,0,0,0,0,0
	                               DB 2,0,0,0,0,2,0,2,0,2,0,2,0,2,0,2,0,0,0,0,2,0,2,0,2,0,0,0,0,0,0,0
	                               DB 0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,2,68 DUP(0),2,0,2,0,2,0,2,0,2
	                               DB 0,2,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,2,0,0,0,0
	                               DB 0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,2,76 DUP(0),2,0
	                               DB 0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0
	                               DB 0,0,0,0,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	                               DB 0,0,0,0,0,0,0,0,2,0,2,0,2,0,2,0,2,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0
	                               DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0
	                               DB 0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0
	                               DB 0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,2,0,2,0,2,0,2,0,2,0,2,0,0,0,0
	                               DB 0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,2,0,2,0,0,0,0,0
	                               DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0
	                               DB 2,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0
	                               DB 0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,2,0,0,0,0,0,0,0,0
	                               DB 0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0
	                               DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,2
	                               DB 0,2,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0
	                               DB 0,0,0,0,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,0,0,0,0,2,0,0,0,0,0,0,0,0
	                               DB 0,0,0,0,0,0,0,0,2,0,0,2,0,2,0,2,0,2,0,2,0,0,0,0,0,0,2,69 DUP(0)
	                               DB 0,0,0,0,0,2,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0
	                               DB 0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,2,69 DUP(0)
	                               DB 0,0,0,0,0,2,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,2,0,0,0,0,0,2,0,2
	                               DB 0,2,0,2,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0
	                               DB 0,0,0,0,0,0,0,2,0,2,0,0,0,0,0,0,2,0,2,0,2,0,0,0,0,0,0,0,0,0,0,0
	                               DB 0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,2,0,2,0,2,0,2,0,2,0,0,0,0,0,0,0
	                               DB 0,0,0,0,0,2,0,0,0,0,0,2,0,2,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,2,0,0
	                               DB 0,0,0,2,0,0,0,0,2,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	                               DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,2,0,0,0,0
	                               DB 0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0
	                               DB 0,0,0,0,0,2,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,2,0,0
	                               DB 0,0,0,2,0,0,0,0,2,0,0,0,0,0,0,2,48 DUP(0)
	                               DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0
	                               DB 0,0,0,0,0,2,0,0,0,0,0,0,0,2,0,2,0,2,0,2,0,2,0,2,0,0,0,0,0,2,0,0
	                               DB 0,0,2,0,2,0,2,0,2,0,0,0,0,0,0,2,0,2,0,2,0,2,0,2,0,2,70 DUP(0)
	                               DB 0,0,0,0,0,2,0,0,0,0,0,2,0,2,0,0,0,0,0,2,0,2,0,2,0,0,0,0,0,2,0,0
	                               DB 0,0,2,0,0,0,0,2,0,2,0,2,0,2,0,2,0,0,0,0,0,2,0,2,72 DUP(0)
	                               DB 0,0,0,0,0,2,0,2,0,2,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,2,0,2
	                               DB 0,2,0,0,0,0,0,2,0,2,0,0,0,0,0,0,0,0,0,0,0,2,138 DUP(0)


	; ANY SQUARE DRAWING IS AN OBJECT, OBJECTS ARE REPRESENTED AS FOLLOWS
	; OBJECT_NAME  DB SIZE_WORD,START_X_WORD,START_Y_WORD,DATA BYTES....
	; SO IF OBJECT HAS SIZE 10 WHICH IS 0010 THE FIRST TWO BYTES ARE 10,0 I.E LOWER_BYTE,HIGHER_BYTE
	; EXAMPLE OBJECT PACMAN OF SIZE 20 PIXEL, STARTING AT (20, 170), HAS 400 COLOR
	; PACMAN DB 20,00,20,0,170,0, 400 DUP(?)
	PACMAN                         DB 20,00,20,0,170,0
	                               DB 1,1,1,1,1,1,1,1,14,14,14,14,1,1,1,1,1,1,1,1
	                               DB 1,1,1,1,1,14,14,14,14,14,14,14,14,14,1,1,1,1,1,1
	                               DB 1,1,1,1,14,14,14,14,14,14,14,14,14,14,14,14,1,1,1,1
	                               DB 1,1,1,14,14,14,14,14,14,14,14,14,14,14,14,14,1,1,1,1
	                               DB 1,1,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,1,1,1
	                               DB 1,14,14,14,14,14,14,14,14,14,14,14,14,14,14,1,1,1,1,1
	                               DB 1,14,14,14,14,14,14,14,14,14,14,14,14,1,1,1,1,1,1,1
	                               DB 1,14,14,14,14,14,14,14,14,14,14,14,1,1,1,1,1,1,1,1
	                               DB 14,14,14,14,14,14,14,14,14,14,14,1,1,1,1,1,1,1,1,1
	                               DB 14,14,14,14,14,14,14,14,14,14,14,1,1,1,1,1,1,1,1,1
	                               DB 14,14,14,14,14,14,14,14,14,14,14,1,1,1,1,1,1,1,1,1
	                               DB 14,14,14,14,14,14,14,14,14,14,14,14,1,1,1,1,1,1,1,1
	                               DB 14,14,14,14,14,14,14,14,14,14,14,14,14,1,1,1,1,1,1,1
	                               DB 1,14,14,14,14,14,14,14,14,14,14,14,14,14,14,1,1,1,1,1
	                               DB 1,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,1,1,1
	                               DB 1,1,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,1,1,1
	                               DB 1,1,1,14,14,14,14,14,14,14,14,14,14,14,14,14,1,1,1,1
	                               DB 1,1,1,1,14,14,14,14,14,14,14,14,14,14,14,14,1,1,1,1
	                               DB 1,1,1,1,1,14,14,14,14,14,14,14,14,14,1,1,1,1,1,1
	                               DB 1,1,1,1,1,1,1,14,14,14,14,14,1,1,1,1,1,1,1,1

	; OBJECT REVERSE IS A BLACK SQUARE OF THE SAME SIZE OF THE ORIGINAL OBJECT
	PACMAN_REVERSE                 DB 20,00,20,0,170,0,400 DUP(0)

	GHOST                          DB 20,00,3CH,01,206,00
	                               DB 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	                               DB 1,1,1,1,1,1,15,15,15,15,15,15,15,15,1,1,1,1,1,1
	                               DB 1,1,1,1,1,15,15,15,15,15,15,15,15,15,15,1,1,1,1,1
	                               DB 1,1,1,1,15,15,15,15,15,15,15,15,15,15,15,15,1,1,1,1
	                               DB 1,1,1,15,15,15,15,15,15,15,15,15,15,15,15,15,15,1,1,1
	                               DB 1,1,1,15,15,15,15,15,15,15,15,15,15,15,15,15,15,1,1,1
	                               DB 1,1,15,15,15,15,1,1,15,15,15,15,1,1,15,15,15,15,1,1
	                               DB 1,1,15,15,15,15,1,1,15,15,15,15,1,1,15,15,15,15,1,1
	                               DB 1,1,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,1,1
	                               DB 1,1,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,1,1
	                               DB 1,1,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,1,1
	                               DB 1,1,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,1,1
	                               DB 1,1,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,1,1
	                               DB 1,1,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,1,1
	                               DB 1,1,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,1,1
	                               DB 1,1,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,1,1
	                               DB 1,1,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,1,1
	                               DB 1,1,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,1,1
	                               DB 1,1,15,15,15,1,15,15,15,15,15,15,15,15,1,15,15,15,1,1
	                               DB 1,1,15,15,1,1,1,15,15,15,15,15,15,1,1,1,15,15,1,1

	GHOST_REVERSE                  DB 20,00,3BH,01,206,00,400 DUP(0)

	; GHOST STATUS FLAGS (3 = UP, 2 = DOWN, 1 = LEFTM 0 = RIGHT)
	DIRECTIONS                     DW 2,1,3,0,3,0,2,0,3,1,3,2,1,2,3,1,0,3,1,2,1,2
	DIRECTIONS_SIZE                DW 22
	CURRENT_DIRECTION              DW 1
	CURRENT_INDEX                  DW 0
	SPEED_DIVISOR                  DW 3
	CURRENT_I                      DW 0


	GHOST2                         DB 20,00,4AH,01,120,00
	                               DB 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	                               DB 1,1,1,1,1,1,15,15,15,15,15,15,15,15,1,1,1,1,1,1
	                               DB 1,1,1,1,1,15,15,15,15,15,15,15,15,15,15,1,1,1,1,1
	                               DB 1,1,1,1,15,15,15,15,15,15,15,15,15,15,15,15,1,1,1,1
	                               DB 1,1,1,15,15,15,15,15,15,15,15,15,15,15,15,15,15,1,1,1
	                               DB 1,1,1,15,15,15,15,15,15,15,15,15,15,15,15,15,15,1,1,1
	                               DB 1,1,15,15,15,15,1,1,15,15,15,15,1,1,15,15,15,15,1,1
	                               DB 1,1,15,15,15,15,1,1,15,15,15,15,1,1,15,15,15,15,1,1
	                               DB 1,1,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,1,1
	                               DB 1,1,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,1,1
	                               DB 1,1,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,1,1
	                               DB 1,1,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,1,1
	                               DB 1,1,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,1,1
	                               DB 1,1,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,1,1
	                               DB 1,1,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,1,1
	                               DB 1,1,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,1,1
	                               DB 1,1,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,1,1
	                               DB 1,1,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,1,1
	                               DB 1,1,15,15,15,1,15,15,15,15,15,15,15,15,1,15,15,15,1,1
	                               DB 1,1,15,15,1,1,1,15,15,15,15,15,15,1,1,1,15,15,1,1

	GHOST_REVERSE2                 DB 20,00,4AH,01,120,00,400 DUP(0)

	; GHOST STATUS FLAGS (3 = UP, 2 = DOWN, 1 = LEFTM 0 = RIGHT)
	DIRECTIONS2                    DW 2,1,3,0,3,0,2,0,3,1,3,2,1,2,3,1,0,3,1,2,1,2
	DIRECTIONS_SIZE2               DW 22
	CURRENT_DIRECTION2             DW 1
	CURRENT_INDEX2                 DW 0
	SPEED_DIVISOR2                 DW 3
	CURRENT_I2                     DW 0



	FOOD_OBJECT                    DB 10,00,?,?,?,?
	                               DB 1,1,1,1,1,1,1,1,1,1
	                               DB 1,1,1,1,1,1,1,1,1,1
	                               DB 1,1,1,1,4,4,1,1,1,1
	                               DB 1,1,1,4,4,4,4,1,1,1
	                               DB 1,1,4,4,4,4,4,4,1,1
	                               DB 1,1,4,4,4,4,4,4,1,1
	                               DB 1,1,1,4,4,4,4,1,1,1
	                               DB 1,1,1,1,4,4,1,1,1,1
	                               DB 1,1,1,1,1,1,1,1,1,1
	                               DB 1,1,1,1,1,1,1,1,1,1

	FOOD_REVERSE                   DB 10,00,?,?,?,?,100 DUP(0)

	; DIRECTION BLOCKING FLAGS
	PREVENT_UP                     DB 0
	PREVENT_RIGHT                  DB 0
	PREVENT_DOWN                   DB 0
	PREVENT_LEFT                   DB 0

	; MOTION STEP SIZE
	STEP                           DW 2

	; HOW MANY FOOD DID YOU EAT
	SCORE                          DW 0

	; KEYBOARD KEYS SCANCODE (ASCII CAN BE USED AS WELL)
	UP                             DB 72
	DOWN                           DB 80
	RIGHT                          DB 77
	LEFT                           DB 75
	SPACE                          DB 57
	ESCAPE                         DB 01
	A                              DB 30
	W                              DB 17
	S                              DB 31
	D                              DB 32

.CODE
	
DRAW_MAZE PROC
	;	HERE WE DRAW THE MAZE AS COLLECTION OF RECTANGLES
	;	THE OUTER BORDERS:
	;	LEFT : 19
	;	RIGHT : 620
	;	TOP: 19
	;	BOTTOM: 340

	                  RECTANGLE_DRAW 1,19,620,19,40                    	;TOP
	                  RECTANGLE_DRAW 1,19,40,19,340                    	;LEFT
	                  RECTANGLE_DRAW 1,599,620,19,340                  	;RIGHT
	                  RECTANGLE_DRAW 1,19,620,320,340                  	;BOTTOM

	                  RECTANGLE_DRAW 15,19,620,19,20                   	;TOP WHITE LINE
	                  RECTANGLE_DRAW 15,19,20,19,340                   	;LEFT WHITE LINE
	                  RECTANGLE_DRAW 15,619,620,19,340                 	;RIGHT WHITE LINE
	                  RECTANGLE_DRAW 15,19,620,339,340                 	;BOTTOM WHITE LINE

	                  RECTANGLE_DRAW 0,20,40,171,190                   	;LEFT DOOR

	                  RECTANGLE_DRAW 15,0,640,359,360                  	;BOTTOM WHITE LONG LINE
	                  RECTANGLE_DRAW 200,0,640,360,400                 	;BOTTOM GREY RECTANGLE

	                  RECTANGLE_DRAW 6,140,160,40,70                   	;BLOCKS
	                  RECTANGLE_DRAW 6,240,310,40,60
	                  RECTANGLE_DRAW 6,340,360,40,110
	                  RECTANGLE_DRAW 6,320,340,90,110
	                  RECTANGLE_DRAW 6,490,510,40,90
	                  RECTANGLE_DRAW 6,390,490,70,90
	                  RECTANGLE_DRAW 6,580,600,40,60
	                  RECTANGLE_DRAW 6,190,210,70,110
	                  RECTANGLE_DRAW 6,210,290,90,110
	                  RECTANGLE_DRAW 6,200,220,140,200
	                  RECTANGLE_DRAW 6,160,200,180,200
	                  RECTANGLE_DRAW 6,150,220,230,250
	                  RECTANGLE_DRAW 6,150,180,280,320
	                  RECTANGLE_DRAW 6,120,150,300,320
	                  RECTANGLE_DRAW 6,70,160,70,90
	                  RECTANGLE_DRAW 6,70,160,120,140
	                  RECTANGLE_DRAW 6,140,160,140,150
	                  RECTANGLE_DRAW 6,70,130,180,200
	                  RECTANGLE_DRAW 6,110,130,200,210
	                  RECTANGLE_DRAW 6,70,90,230,290
	                  RECTANGLE_DRAW 6,90,120,250,270
	                  RECTANGLE_DRAW 6,250,270,140,220
	                  RECTANGLE_DRAW 6,270,370,170,190
	                  RECTANGLE_DRAW 6,370,390,140,250
	                  RECTANGLE_DRAW 6,310,340,230,250
	                  RECTANGLE_DRAW 6,310,330,250,290
	                  RECTANGLE_DRAW 6,260,280,250,320
	                  RECTANGLE_DRAW 6,210,260,300,320
	                  RECTANGLE_DRAW 6,360,380,280,320
	                  RECTANGLE_DRAW 6,540,560,70,110
	                  RECTANGLE_DRAW 6,560,600,90,110
	                  RECTANGLE_DRAW 6,420,510,120,150
	                  RECTANGLE_DRAW 0,450,490,140,150
	                  RECTANGLE_DRAW 6,420,480,180,200
	                  RECTANGLE_DRAW 6,440,460,200,250
	                  RECTANGLE_DRAW 6,420,460,250,270
	                  RECTANGLE_DRAW 6,510,570,180,200
	                  RECTANGLE_DRAW 6,550,570,140,200
	                  RECTANGLE_DRAW 6,490,550,230,250
	                  RECTANGLE_DRAW 6,580,600,230,250
	                  RECTANGLE_DRAW 6,580,600,280,320
	                  RECTANGLE_DRAW 6,550,600,300,320
	                  RECTANGLE_DRAW 6,500,520,280,320
	                  RECTANGLE_DRAW 6,430,520,300,320

	                  RET
DRAW_MAZE ENDP


	; ANY SQUARE OBJECT DRAWING FUNCTION
	; SI: OFFSET OF THE OBJECT TO BE DRAWN
	; ANY SQUARE DRAWING IS AN OBJECT, OBJECTS ARE REPRESENTED AS FOLLOWS
	; OBJECT_NAME  DB SIZE_WORD,START_X_WORD,START_Y_WORD,DATA BYTES....
	; SO IF OBJECT HAS SIZE 10 WHICH IS 0010 THE FIRST TWO BYTES ARE 10,0 I.E LOWER_BYTE,HIGHER_BYTE
	; EXAMPLE OBJECT PACMAN OF SIZE 20 PIXEL, STARTING AT (20, 170), HAS 400 COLOR
	; PACMAN DB 20,00,20,0,170,0, 400 DUP(?)
DRAW_OBJECT PROC
	                  PUSH           AX
	                  PUSH           BX
	                  PUSH           CX
	                  PUSH           DX
	                  PUSH           SI
	                  PUSH           DI
	                  PUSH           BP

	; GET SIZE -> BX, X -> CX, Y -> DX
	                  MOV            BX,WORD PTR [SI]
	                  INC            SI
	                  INC            SI
	                  MOV            CX,WORD PTR [SI]
	                  INC            SI
	                  INC            SI
	                  MOV            DX,WORD PTR [SI]
	                  INC            SI
	                  INC            SI
	; ADD THE SIZE TO THE STAARTING X AND Y OF THE OBJECT
	                  MOV            BP, BX
	                  ADD            BX, CX
	                  ADD            BP, DX
	                  MOV            DI, CX                            	; STORE THE START X POS
	DRAW_ROW:         
	DRAW_PIXEL:       

	                  LODSB                                            	; MOVES THE COLOR FROM DS:SI TO AL
	                  MOV            AH,0CH
	                  CMP            AL ,1                             	; IF THE PIXEL IS BLACK DON'T DRAW IT
	                  JE             SKIP_PIXEL
	                  INT            10H                               	;DRAW
	SKIP_PIXEL:       
	                  INC            CX                                	;TAKE STEP TO THE RIGHT
	                  CMP            CX, BX                            	;CHECK THAT YOU DIDN'T REACH THE RIGHT END
	                  JNE            DRAW_PIXEL                        	;REPEAT IF NO
	                 
	                  MOV            CX,DI                             	;GO BACK TO THE START OF THE LINE (FAR LEFT)
	                  INC            DX                                	;TAKE STEP DOWN
	                  CMP            DX,BP                             	;CHECK THAT YOU DIDN'T REACH THE BOTTOM END
	                  JNE            DRAW_ROW                          	;REPEAT IF NO
    
	                  POP            BP
	                  POP            DI
	                  POP            SI
	                  POP            DX
	                  POP            CX
	                  POP            BX
	                  POP            AX
	                  RET
DRAW_OBJECT ENDP


	; CHECKS THE MAZE_MATRIX TO SEE IF WE CAN MOVE THE OBJECT UP
	; BP: ADDRESS OF OBJECT
	; BL: RETURN VALUE
CHECK_UP PROC
	                  PUSH           AX
	                  PUSH           BX
	                  PUSH           CX
	                  PUSH           DX
	                  PUSH           DI
	                  PUSH           SI
	                  PUSH           BP

	; GET SIZE -> BP, X -> CX, Y -> DX
	                  MOV            DI,BP
	                  MOV            BP,WORD PTR [DI]
	                  ADD            DI,2
	                  MOV            CX,WORD PTR [DI]
	                  ADD            DI,2
	                  MOV            DX,WORD PTR [DI]

	; FIRST: GET MY CURRENT ROW & COLUMN IN THE MATRIX
	; DIVIDE THE X COORDINATE BY MATRIX_MULTIPLIER TO GET COLUMN NUMBER
	; STORE IT IN BH
	                  MOV            AX ,CX
	                  MOV            BL,MAZE_MATRIX_MULTIPLIER
	                  DIV            BL
	                  MOV            BH,AL

	; DIVIDE THE Y COORDINATE BY MATRIX_MULTIPLIER TO GET ROW NUMBER
	; THEN CHECK THAT IT IS A ROUND NUMBER WITH NO FRACTIONS
	; AS FRACTIONS MEAN THAT WE ARE AT THE CENTER OF A CELL SO SAFE TO MOVE
	                  MOV            AX,DX
	                  MOV            BL,MAZE_MATRIX_MULTIPLIER
	                  DIV            BL
	                  MOV            BL,0
	                  CMP            AH,0
	                  JNE            RETURN_1

	; SECOND: GET MY CURRENT CELL INDEX IN THE MATRIX
	; INDEX = (ROW NUMBER * MAZE_MATRIX_WIDTH) + COLUMN NUMBER
	                  MOV            BL,BYTE PTR MAZE_MATRIX_WIDTH
	                  IMUL           BL
	                  ADD            AL,BH
	
	; THIRD: GET THE CELL ABOVE ME
	; CELL ABOVE ME = CURRENT CELL - MATRIX WIDTH
	; THEN CHECK IF IT IS NOT EMPTY -> RETURN 1
	                  SUB            AX,MAZE_MATRIX_WIDTH
	                  LEA            SI,MAZE_MATRIX
	                  ADD            SI,AX
	                  MOV            BL,[SI]
	                  CMP            BL,1
	                  JE             RETURN_1

	; WHAT IF I AM STANDING ON TWO CELLS?
	; FOURTH: CHECK THE CELL NEXT TO THE ONE ABOVE ME
	; CHECKING THE CELL NEXT TO THE ONE ABOVE ME IS TRICKY BEC.
	; WHAT IF I AM ON ONE CELL ONLY?
	; SO, CHECK THE CELL ABOVE ME FROM MY OTHER SIDE
	; (FIRST WE CHECKED THE CELL ABOVE STARTING_X NOW WE CHECK THE ONE ABOVE ENDING_X)
	; IT CAN BE THE SAME ONE ABOVE ME OR ITS NEUGHBOUR


	; GET MY LEFT SIDE X
	; ADD WIDTH TO GET RIGHT SIDE X
	; DEC ONE BEC. COUNTING STARTS FROM 0
	                  MOV            AX ,CX
	                  ADD            AX,BP
	                  DEC            AX

	;  GET NEW COLUMN NUMBER
	                  MOV            BL,MAZE_MATRIX_MULTIPLIER
	                  DIV            BL
	                  MOV            BH,AL

	;  GET NEW CELL INDEX
	                  MOV            AX,DX
	                  MOV            BL,MAZE_MATRIX_MULTIPLIER
	                  DIV            BL
	                  MOV            BL,BYTE PTR MAZE_MATRIX_WIDTH
	                  IMUL           BL
	                  ADD            AL,BH

	; CHECK THE CELL ABOVE ME NOW
	                  SUB            AX,MAZE_MATRIX_WIDTH
	                  LEA            SI,MAZE_MATRIX
	                  ADD            SI,AX
	                  MOV            BL,[SI]

	RETURN_1:         MOV            PREVENT_UP,BL

	                  POP            BP
	                  POP            SI
	                  POP            DI
	                  POP            DX
	                  POP            CX
	                  POP            BX
	                  POP            AX
	                  RET
CHECK_UP ENDP

CHECK_DOWN PROC
	; THE ONLY DIFFERENCE BETWEEN CHECK UP AND DOWN
	; IS THAT UP USES THE TOP Y COORDINATES
	; IN DOWN WE USE THE BOTTOM Y COORDINATES
	; BOTTOM Y COORDINATES = TOP Y + OBJECT SIZE - MAZE_MATRIX_MULTIPLIER

	; ALSO INSTEAD OF CHECKING THE ABOVE CELL IN THE MATRIX
	; WE CHECK THE ONE BELOW
	                  PUSH           AX
	                  PUSH           BX
	                  PUSH           CX
	                  PUSH           DX
	                  PUSH           DI
	                  PUSH           SI
	                  PUSH           BP

	                  MOV            DI,BP
	                  MOV            BP,WORD PTR [DI]
	                  ADD            DI,2
	                  MOV            CX,WORD PTR [DI]
	                  ADD            DI,2
	                  MOV            DX,WORD PTR [DI]
	                  ADD            DX,BP
	                  MOV            AX,0
	                  MOV            AL,MAZE_MATRIX_MULTIPLIER
	                  SUB            DX,AX

	                  MOV            AX ,CX
	                  MOV            BL,MAZE_MATRIX_MULTIPLIER
	                  DIV            BL
	                  MOV            BH,AL

	                  MOV            AX,DX
	                  MOV            BL,MAZE_MATRIX_MULTIPLIER
	                  DIV            BL
	                  MOV            BL,0
	                  CMP            AH,0
	                  JNE            RETURN_3

	                  MOV            BL,BYTE PTR MAZE_MATRIX_WIDTH
	                  IMUL           BL
	                  ADD            AL,BH

	                  ADD            AX,MAZE_MATRIX_WIDTH
	                  LEA            SI,MAZE_MATRIX
	                  ADD            SI,AX
	                  MOV            BL,[SI]
	                  CMP            BL,1
	                  JE             RETURN_3

	                  MOV            AX ,CX
	                  ADD            AX ,BP
	                  DEC            AX

	                  MOV            BL,MAZE_MATRIX_MULTIPLIER
	                  DIV            BL
	                  MOV            BH,AL

	                  MOV            AX,DX
	                  MOV            BL,MAZE_MATRIX_MULTIPLIER
	                  DIV            BL
	                  MOV            BL,BYTE PTR MAZE_MATRIX_WIDTH
	                  IMUL           BL
	                  ADD            AL,BH

	                  ADD            AX,MAZE_MATRIX_WIDTH
	                  LEA            SI,MAZE_MATRIX
	                  ADD            SI,AX
	                  MOV            BL,[SI]

	RETURN_3:         MOV            PREVENT_DOWN,BL
	
	                  POP            BP
	                  POP            SI
	                  POP            DI
	                  POP            DX
	                  POP            CX
	                  POP            BX
	                  POP            AX
	                  RET
CHECK_DOWN ENDP

	; SIMILAR TO CHECK UP
CHECK_LEFT PROC
	                  PUSH           AX
	                  PUSH           BX
	                  PUSH           CX
	                  PUSH           DX
	                  PUSH           DI
	                  PUSH           SI
	                  PUSH           BP

	                  MOV            DI,BP
	                  MOV            BP,WORD PTR [DI]
	                  ADD            DI,2
	                  MOV            CX,WORD PTR [DI]
	                  ADD            DI,2
	                  MOV            DX,WORD PTR [DI]

	                  MOV            AX ,CX
	                  MOV            BL,MAZE_MATRIX_MULTIPLIER
	                  DIV            BL
	                  CMP            AH,0
	                  JNE            RETURN_4
	                  MOV            BH,AL
	                  MOV            AX,DX
	                  MOV            BL,MAZE_MATRIX_MULTIPLIER
	                  DIV            BL
	                  MOV            BL,BYTE PTR MAZE_MATRIX_WIDTH
	                  IMUL           BL
	                  ADD            AL,BH
	                  DEC            AX
	                  LEA            SI,MAZE_MATRIX
	                  ADD            SI,AX
	                  MOV            BL,[SI]
	                  CMP            BL,1
	                  JE             RETURN_4

	                  MOV            AX ,CX
	                  MOV            BL,MAZE_MATRIX_MULTIPLIER
	                  DIV            BL
	                  CMP            AH,0
	                  JNE            RETURN_4
	                  MOV            BH,AL
	                  MOV            AX,DX
	                  ADD            AX,BP
	                  DEC            AX
	                  MOV            BL,BYTE PTR MAZE_MATRIX_MULTIPLIER
	                  DIV            BL
	                  MOV            BL,BYTE PTR MAZE_MATRIX_WIDTH
	                  IMUL           BL
	                  ADD            AL,BH
	                  DEC            AX
	                  LEA            SI,MAZE_MATRIX
	                  ADD            SI,AX
	                  MOV            BL,[SI]
	RETURN_4:         MOV            PREVENT_LEFT,BL

	                  POP            BP
	                  POP            SI
	                  POP            DI
	                  POP            DX
	                  POP            CX
	                  POP            BX
	                  POP            AX
	                  RET
CHECK_LEFT ENDP

	; SIMILAR TO CHECK UP
CHECK_RIGHT PROC
	                  PUSH           AX
	                  PUSH           BX
	                  PUSH           CX
	                  PUSH           DX
	                  PUSH           DI
	                  PUSH           SI
	                  PUSH           BP

	                  MOV            DI,BP
	                  MOV            BP,WORD PTR [DI]
	                  ADD            DI,2
	                  MOV            CX,WORD PTR [DI]
	                  ADD            DI,2
	                  MOV            DX,WORD PTR [DI]
	                  ADD            CX,BP
	                  MOV            AX,0
	                  MOV            AL,MAZE_MATRIX_MULTIPLIER
	                  SUB            CX,AX

	                  MOV            AX ,CX
	                  MOV            BL,MAZE_MATRIX_MULTIPLIER
	                  DIV            BL
	                  CMP            AH,0
	                  JNE            RETURN_2
					 
	                  MOV            BH,AL
	                  MOV            AX,DX
	                  MOV            BL,MAZE_MATRIX_MULTIPLIER
	                  DIV            BL
	                  MOV            BL,BYTE PTR  MAZE_MATRIX_WIDTH
	                  IMUL           BL
	                  ADD            AL,BH
	                  INC            AX
	                  LEA            SI,MAZE_MATRIX
	                  ADD            SI,AX
	                  MOV            BL,[SI]
	                  CMP            BL,1
	                  JE             RETURN_2
							  	                         
	                  MOV            AX ,CX
	                  MOV            BL,MAZE_MATRIX_MULTIPLIER
	                  DIV            BL
	                  CMP            AH,0
	                  JNE            RETURN_2
	                  MOV            BH,AL
	                  MOV            AX,DX
	                  ADD            AX,BP
	                  DEC            AX
	                  MOV            BL,BYTE PTR MAZE_MATRIX_MULTIPLIER
	                  DIV            BL
	                  MOV            BL,BYTE PTR MAZE_MATRIX_WIDTH
	                  IMUL           BL
	                  ADD            AL,BH
	                  INC            AX
	                  LEA            SI,MAZE_MATRIX
	                  ADD            SI,AX
	                  MOV            BL,[SI]

	RETURN_2:         MOV            PREVENT_RIGHT,BL

	                  POP            BP
	                  POP            SI
	                  POP            DI
	                  POP            DX
	                  POP            CX
	                  POP            BX
	                  POP            AX
	                  RET
CHECK_RIGHT ENDP


	; CHECK IF BOTH OBJECTS OVERLAP
	; SI : OFFSET OF FIRST OBJECT
	; DI : OFFEST OF SECOND OBJECT
	; AX = 1 -> OVERLAPPING , AX = 0 -> NOT
CHECK_OVERLAPPING PROC
	; ANY OBJECTS A AND B ARE OVERLAPPING IF AND ONLY IF
	; 1. A TOP IS ABOVE B BOTTOM BY DISTANCE LESS THAN SUM OF THEIR SIZES
	; AND
	; 2. A RIGHT IS ON THE RIGHT OF B LEFT BY DISTANCE LESS THAN SUM OF THEIR SIZES

	                  PUSH           BX
	                  PUSH           CX
	                  PUSH           DX
	                  PUSH           DI
	                  PUSH           SI
	                  PUSH           BP

	; GET OBJECT COORDINATES AND SIZES

	                  MOV            AX, WORD PTR [SI]                 	; SIZE
	                  ADD            SI,2
	                  MOV            BX, WORD PTR [SI]                 	; X
	                  ADD            SI,2
	                  MOV            CX, WORD PTR [SI]                 	; Y

	                  MOV            DX, WORD PTR [DI]                 	; SIZE
	                  ADD            DI,2
	                  MOV            BP, WORD PTR [DI]                 	; X
	                  ADD            DI,2
	                  MOV            SI, WORD PTR [DI]
	                  XCHG           SI,DI                             	; Y

	                  MOV            SI,DX                             	; STORE SIZE BECAUSE WE WILL USE IT AGAIN

	; CHECK: TOP OF FIRST OBJECT ABOVE BOTTOM OF SECOND OBJECT BY DISTANCE LESS THAN BOTH SIZES

	                  ADD            DI,DX                             	; BOTTOM OF SECOND OBJECT = TOP + SIZE
	                  CMP            CX,DI                             	; IS THE TOP OF ONE ABOVE BOTTOM OF THE OTHER
	                  JA             FINE                              	; IF NO THEN NOT OVERLAPPING
	                  SUB            DI,CX                             	; IF YES CHECK THAT:
	                  ADD            DX,AX                             	; DIFFERENCE IS LESS THAN SUN OF SIZES
	                  CMP            DI,DX
	                  JA             FINE                              	; IF NO THEN NOT OVERLAPPING

	; CHECK: RIGHT OF FIRST OBJECT IS GREATER THAN LEFT OF SECOND OBJECT BY DISTANCE LESS THAN BOTH SIZES
	
	                  MOV            DX,SI                             	; GET SIZE OF SECOND OBJECT AGAIN
					  
	                  ADD            BX,AX                             	; RIGHT OF SECOND OBJECT = LEFT + SIZE
	                  CMP            BX,BP                             	; IS THE RIGHT OF ONE GREATER THAN LEFT OF THE OTHER
	                  JB             FINE                              	; IF NO THEN NOT OVERLAPPING
	                  SUB            BX,BP                             	; IF YES CHECK THAT:
	                  ADD            DX,AX                             	; DIFFERENCE IS LESS THAN SUN OF SIZES
	                  CMP            BX,DX
	                  JA             FINE                              	; THEN NOT OVERLAPPING
	                  JMP            NOT_FINE
	FINE:             
	                  MOV            AX,0
	                  JMP            FINISH
					  
	NOT_FINE:         MOV            AX , 1

	FINISH:           
	                  POP            BP
	                  POP            SI
	                  POP            DI
	                  POP            DX
	                  POP            CX
	                  POP            BX
	                  RET
CHECK_OVERLAPPING ENDP



HANDLE_INPUT PROC

	;CLEARS THE KEYBOARD TYPEHEAD BUFFER AND COLLECTS A SCANCODE

	;ALTERS BP

	                  PUSH           AX
	                  PUSH           ES

	                  MOV            AX, 40H
	                  MOV            ES, AX                            	;ACCESS KEYBOARD DATA AREA VIA SEGMENT 40H
	                  MOV            WORD PTR ES:[1AH], 1EH            	;SET THE KBD BUFF HEAD TO START OF BUFF
	                  MOV            WORD PTR ES:[1CH], 1EH            	;SET THE KBD BUFF TAIL TO SAME AS BUFF HEAD
	;THE KEYBOARD TYPEHEAD BUFFER IS NOW CLEARED
	                  XOR            AH, AH
	                  IN             AL, 60H                           	;AL -> SCANCODE
	                  MOV            BP, AX                            	;BP -> SCANCODE, ACCESSIBLE GLOBALLY

	                  POP            ES
	                  POP            AX
	                  RET


HANDLE_INPUT ENDP



	; THIS FUNCTION LOOPS ON THE FOOD MATRIZ TO DRAW FOOD IN ITS PLACE IN THE MATRIX
DRAW_FOOD PROC
	; LOOP FOR CX FROM ZERO TO MATRIX_ROW_LENGTH_IN_PIXELS
	; LOOP FOR DX FROM ZERO TO MATRIX_COLUMN_LENGTH_IN_PIXELS
	; CHECK ELEMENT IF NOT ZERO
	; DRAW IT IN (CX, DX)
						
	                  MOV            CX,0
	                  MOV            DX,0
	                  LEA            SI,FOOD_MATRIX
	                  MOV            BL,MAZE_MATRIX_MULTIPLIER
	                  MOV            BH,0                              	; BX = MAZE_MATRIX_MULTIPLIER

	NEXT_COLL:        LODSB                                            	; GET MATRIX CELL [SI] INTO AL

	; AL = 0 => CONTINUE
	; AL = 1 => DRAW BLACK
	; AL = 2 => DRAW FOOD

	                  CMP            AL,2                              	; IF EMPTY CONTINUE
	                  JE             THERE_IS_FOOD

	; CHECK IF THERE WAS FOOD AND DELETED
	                  CMP            AL,0
	                  JE             CONTINUE
	; IF YES : DRAW FOOD_REVERSE

	                  LEA            DI,FOOD_REVERSE                   	; IF NOT EMPTY UPDATE FOOD OBJECT X,Y
	                  ADD            DI,2
	                  MOV            [DI],CX
	                  ADD            DI,2
	                  MOV            [DI],DX

	                  PUSH           SI                                	; DRAW FOOD OBJECT
	                  LEA            SI,FOOD_REVERSE                   	; BUT FIRST CHECK:

	                  LEA            DI,GHOST                          	; IF THIS FOOD REVERSE AND GHOST OVERLAP
	                  CALL           CHECK_OVERLAPPING                 	; DON'T DRAW
	                  CMP            AX,0
	                  JNZ            NEXT_FOOD

	                  LEA            DI,GHOST2                         	; IF THIS FOOD REVERSE AND GHOST2 OVERLAP
	                  CALL           CHECK_OVERLAPPING                 	; DON'T DRAW
	                  CMP            AX,0
	                  JNZ            NEXT_FOOD

	                  LEA            DI,PACMAN                         	; IF THIS FOOD REVERSE AND PACMAN OVERLAP
	                  CALL           CHECK_OVERLAPPING                 	; DON'T DRAW
	                  CMP            AX,0
	                  JNZ            NEXT_FOOD

	                  CALL           DRAW_OBJECT
	NEXT_FOOD:        POP            SI
	                  JMP            CONTINUE

	THERE_IS_FOOD:    
	                  LEA            DI,FOOD_OBJECT                    	; IF NOT EMPTY UPDATE FOOD OBJECT X,Y
	                  ADD            DI,2
	                  MOV            [DI],CX
	                  ADD            DI,2
	                  MOV            [DI],DX

	                  PUSH           SI                                	; DRAW FOOD OBJECT
	                  LEA            SI,FOOD_OBJECT                    	; BUT FIRST CHECK:

	                  LEA            DI,GHOST                          	; IF THIS FOOD OBJECT AND GHOST OVERLAP
	                  CALL           CHECK_OVERLAPPING                 	; DON'T DRAW
	                  CMP            AX,0
	                  JNZ            NEXT_FOOD2

	                  LEA            DI,GHOST2                         	; IF THIS FOOD OBJECT AND GHOST OVERLAP
	                  CALL           CHECK_OVERLAPPING                 	; DON'T DRAW
	                  CMP            AX,0
	                  JNZ            NEXT_FOOD2
					  
	                  CALL           DRAW_OBJECT
	NEXT_FOOD2:       POP            SI
	                  JMP            CONTINUE
	INTERMEDIATE_JMP: 
	                  JMP            NEXT_COLL                         	; TO SOLVE JMP OUT OF RANGE PROBLEM

	CONTINUE:         
	                  ADD            CX,BX                             	; TAKE A STEP RIGHT
	                  CMP            CX,MATRIX_ROW_LENGTH_IN_PIXELS    	; CHECK IF REACHED END
	                  JE             NEXT_ROW
	                  JMP            INTERMEDIATE_JMP

	NEXT_ROW:         MOV            CX,0                              	; RESET CX

	                  ADD            DX,BX                             	; TAKE A STEP DOWN
	                  CMP            DX,MATRIX_COLUMN_LENGTH_IN_PIXELS 	; CHECK IF REACHED END
	                  JNE            INTERMEDIATE_JMP
	                  RET
DRAW_FOOD ENDP

EAT PROC
	; TO EAT CHECK IF THERE IS FOOD IN MY CURRENT CELLS
	; IN THE FOOD MATRIX
	; TOP RIGHT , TOP LEFT, BOTTOM RIGHT, BOTTOM LEFT

	; THIS FIRST PART TO CALCULATE CURRENT CELL (TOP LEFT)
	; IS TAKEN FROM CHECK_UP
	; START
	                  PUSH           AX
	                  PUSH           BX
	                  PUSH           CX
	                  PUSH           DX
	                  PUSH           DI
	                  PUSH           SI
	                  PUSH           BP

	                  LEA            DI,PACMAN
	                  MOV            BP,WORD PTR [DI]
	                  ADD            DI,2
	                  MOV            CX,WORD PTR [DI]
	                  ADD            DI,2
	                  MOV            DX,WORD PTR [DI]
					 
	                  MOV            AX ,CX
	                  MOV            BL,MAZE_MATRIX_MULTIPLIER
	                  DIV            BL
	                  MOV            BH,AL
	                  MOV            AX,DX
	                  MOV            BL,MAZE_MATRIX_MULTIPLIER
	                  DIV            BL
	                  MOV            BL,BYTE PTR  MAZE_MATRIX_WIDTH
	                  IMUL           BL
	                  ADD            AL,BH
	                  LEA            SI,FOOD_MATRIX                    	; THE ONLY DIFFERENT LINE
	                  ADD            SI,AX
	; END
	; CHECK TOP LEFT CELL -> SI
	                  MOV            BL,[SI]
	                  CMP            BL,2
	                  JNE            EAT_CMP2

	                  MOV            BL,1
	                  MOV            [SI],BL
	                  MOV            BX,SCORE
	                  INC            BX
	                  MOV            SCORE,BX
	                  JMP            SCORE_DRAW

	; CHECK TOP RIGHT CELL -> SI + 1
	EAT_CMP2:         
	                  INC            SI
	                  MOV            BL,[SI]
	                  CMP            BL,2
	                  JNE            EAT_CMP3

	                  MOV            BL,1
	                  MOV            [SI],BL
	                  MOV            BX,SCORE
	                  INC            BX
	                  MOV            SCORE,BX
	                  JMP            SCORE_DRAW

	; CHECK BOTTOM LEFT CELL -> SI + MAZE_MATRIX_WIDTH
	EAT_CMP3:         
	                  DEC            SI
	                  ADD            SI,MAZE_MATRIX_WIDTH
	                  MOV            BL,[SI]
	                  CMP            BL,2
	                  JNE            EAT_CMP4

	                  MOV            BL,1
	                  MOV            [SI],BL
	                  MOV            BX,SCORE
	                  INC            BX
	                  MOV            SCORE,BX
	                  JMP            SCORE_DRAW

	; CHECK BOTTOM RIGHT CELL -> SI + MAZE_MATRIX_WIDTH + 1
	EAT_CMP4:         
	                  INC            SI
	                  MOV            BL,[SI]
	                  CMP            BL,2
	                  JNE            EAT_RETURN

	                  MOV            BL,1
	                  MOV            [SI],BL
	                  MOV            BX,SCORE
	                  INC            BX
	                  MOV            SCORE,BX

	SCORE_DRAW:       
	; DRAWING SCORE
	; TO DRAW SCORE XYZ SPLIT IT TO THREE PARTS
	; XYZ % 10 = Z , XY
	; XY % 10 = Y, X
	                  MOV            AX,SCORE
	                  MOV            BX,10
	                  MOV            DX,0
	                  DIV            BX
	; RESULT IN AL
	; REMAINDER IN DL
	                  MOV            CL,AL
	                  ADD            DL,'0'
	                  MOV            CH,DL

	                  MOV            DL, 10                            	;COLUMN
	                  MOV            DH, 23                            	;ROW
	                  MOV            BH, 0                             	;DISPLAY PAGE
	                  MOV            AH, 02H                           	;SET CURSOR POSITION
	                  INT            10H

	                  MOV            AL,CH
	                  MOV            BL, 0CH                           	;COLOR IS RED
	                  MOV            BH, 0                             	;DISPLAY PAGE
	                  MOV            AH, 0EH                           	;TELETYPE
	                  INT            10H

	                  MOV            AH,0
	                  MOV            AL,CL
	                  MOV            BX,10
	                  MOV            DX,0
	                  DIV            BX

	                  MOV            CH,AL
	                  MOV            CL,DL

	                  ADD            CL,'0'
	                  ADD            CH,'0'

	                  MOV            DL, 8                             	;COLUMN
	                  MOV            DH, 23                            	;ROW
	                  MOV            BH, 0                             	;DISPLAY PAGE
	                  MOV            AH, 02H                           	;SET CURSOR POSITION
	                  INT            10H

	                  MOV            AL, CH
	                  MOV            BL, 0CH                           	;COLOR IS RED
	                  MOV            BH, 0                             	;DISPLAY PAGE
	                  MOV            AH, 0EH                           	;TELETYPE
	                  INT            10H

	                  MOV            DL, 9                             	;COLUMN
	                  MOV            DH, 23                            	;ROW
	                  MOV            BH, 0                             	;DISPLAY PAGE
	                  MOV            AH, 02H                           	;SET CURSOR POSITION
	                  INT            10H
							  
	                  MOV            AL, CL
	                  MOV            BL, 0CH                           	;COLOR IS RED
	                  MOV            BH, 0                             	;DISPLAY PAGE
	                  MOV            AH, 0EH                           	;TELETYPE
	                  INT            10H
	EAT_RETURN:       
	
	                  POP            BP
	                  POP            SI
	                  POP            DI
	                  POP            DX
	                  POP            CX
	                  POP            BX
	                  POP            AX
	                  RET
EAT ENDP


	; CHECK BUTTON PRESS AND DO MOTION FOR PACMAN
DO_MOTION_PACMAN PROC
	; CLEAR ALL PREVENT FLAGS
	                  MOV            BL,0
	                  MOV            PREVENT_UP,BL
	                  MOV            PREVENT_DOWN,BL
	                  MOV            PREVENT_LEFT,BL
	                  MOV            PREVENT_RIGHT,BL
	
	; GET PACMAN -> SI (FOR DOING MOTION), BP FOR CHECKING MOTION
	; GET PACMAN_REVERSE -> DI (FOR DELETING PREVIOUS PACMAN THEN UPDATING COORDINATES)
	; NOW SI, DI ARE POINTING TO X COORINATE
	                  LEA            SI, PACMAN
	                  LEA            DI, PACMAN_REVERSE
	                  LEA            BP, PACMAN
	                  ADD            SI,2
	                  ADD            DI,2
	                  MOV            BX, WORD PTR [SI]
	                  ADD            SI,2
	                  ADD            DI,2
	                  MOV            DX, WORD PTR [SI]
					
	; CHECK UP KEY
	                  CMP            AH,UP
	                  JNZ            NEXTCMP
	; CHECK MOTION DIRECTION
	                  CALL           CHECK_UP
	                  CMP            PREVENT_UP,1
	                  JE             DRAW
	; DRAW REVERSE
	                  PUSH           SI
	                  LEA            SI,PACMAN_REVERSE
	                  CALL           DRAW_OBJECT
	                  POP            SI
	; UPDATE REVERSE AND ORIGINAL
	                  SUB            DX,STEP
	                  MOV            [SI],DX
	                  MOV            [DI],DX
	; DRAW
	                  JMP            DRAW
	; CHECK DOWN KEY
	NEXTCMP:          
	                  CMP            AH,DOWN
	                  JNZ            NEXTCMP2
	; CHECK MOTION DIRECTION
	                  CALL           CHECK_DOWN
	                  CMP            PREVENT_DOWN,1
	                  JE             DRAW
	; DRAW REVERSE
	                  PUSH           SI
	                  LEA            SI,PACMAN_REVERSE
	                  CALL           DRAW_OBJECT
	                  POP            SI
	; UPDATE REVERSE AND ORIGINAL
	                  ADD            DX,STEP
	                  MOV            [SI],DX
	                  MOV            [DI],DX
	; DRAW
	                  JMP            DRAW
	NEXTCMP2:         
	; MAKE SI, DI POINT TO Y COORINATE
	                  SUB            SI,2
	                  SUB            DI,2
	; CHECK RIGHT KEY
	                  CMP            AH,RIGHT
	                  JNZ            NEXTCMP3
	; CHECK MOTION DIRECTION
	                  CALL           CHECK_RIGHT
	                  CMP            PREVENT_RIGHT,1
	                  JE             DRAW
	; DRAW REVERSE
	                  PUSH           SI
	                  LEA            SI,PACMAN_REVERSE
	                  CALL           DRAW_OBJECT
	                  POP            SI
	; UPDATE REVERSE AND ORIGINAL
	                  ADD            BX,STEP
	                  MOV            [SI],BX
	                  MOV            [DI],BX
	; DRAW
	                  JMP            DRAW
	; CHECK LEFT KEY
	NEXTCMP3:         
	                  CMP            AH,LEFT
	                  JNZ            DRAW
	; CHECK MOTION DIRECTION
	                  CALL           CHECK_LEFT
	                  CMP            PREVENT_LEFT,1
	                  JE             DRAW
	; DRAW REVERSE
	                  PUSH           SI
	                  LEA            SI,PACMAN_REVERSE
	                  CALL           DRAW_OBJECT
	                  POP            SI
	; UPDATE REVERSE AND ORIGINAL
	                  SUB            BX,STEP
	                  MOV            [SI],BX
	                  MOV            [DI],BX
	; DRAW
	DRAW:             
	                  LEA            SI,PACMAN
	                  CALL           DRAW_OBJECT
	                  RET
DO_MOTION_PACMAN ENDP


	; THIS FUNCTION JUST CHANGES THE CURRENT_DIRECTION BASED ON THE DIRECTIONS ARRAY
CHANGE PROC
	                  PUSH           AX
	                  PUSH           BX
	                  LEA            BX, DIRECTIONS
	                  MOV            AX, CURRENT_INDEX
	                  CMP            AX,DIRECTIONS_SIZE
	                  JNE            N
	                  MOV            AX,0
	                  MOV            CURRENT_INDEX,AX
	N:                ADD            BX,AX
	                  INC            AX
	                  INC            AX
	                  MOV            CURRENT_INDEX,AX
	                  MOV            AX,[BX]
	                  MOV            CURRENT_DIRECTION,AX
	                  POP            BX
	                  POP            AX
	                  RET
CHANGE ENDP


	; THIS FUNCTION JUST CHANGES THE CURRENT_DIRECTION BASED ON THE DIRECTIONS ARRAY
CHANGE2 PROC
	                  PUSH           AX
	                  PUSH           BX
	                  LEA            BX, DIRECTIONS2
	                  MOV            AX, CURRENT_INDEX2
	                  CMP            AX,DIRECTIONS_SIZE2
	                  JNE            N2
	                  MOV            AX,0
	                  MOV            CURRENT_INDEX2,AX
	N2:               ADD            BX,AX
	                  INC            AX
	                  INC            AX
	                  MOV            CURRENT_INDEX2,AX
	                  MOV            AX,[BX]
	                  MOV            CURRENT_DIRECTION2,AX
	                  POP            BX
	                  POP            AX
	                  RET
CHANGE2 ENDP

	; THIS FUNCTION HANDLES GHOST MOTION ACCORDING TO
	; 1. COUNTER_I : WHICH IS A COUNTER TO MAKE A DELAY
	; 2. DIRECTIONS ARRAY: WHICH IA AN ARRAY OF RANDOM DIRECTIONS
DO_MOTION_GHOST PROC
	; CLEAR ALL PREVENT VARIABLES
	                  MOV            BL,0
	                  MOV            PREVENT_UP,BL
	                  MOV            PREVENT_DOWN,BL
	                  MOV            PREVENT_LEFT,BL
	                  MOV            PREVENT_RIGHT,BL

	; CHECK THAT THE DELAY IS OVER
	                  MOV            AX,CURRENT_I
	                  CMP            AX, SPEED_DIVISOR
	                  JE             MOVE
	                  MOV            AX, CURRENT_I
	                  INC            AX
	                  MOV            CURRENT_I,AX
	                  RET
	MOVE:             
	; RESET DELAY
	                  MOV            AX, 0
	                  MOV            CURRENT_I,AX
	; GET THE NEW DIRECTION
	                  MOV            AX, CURRENT_DIRECTION

	; GET GHOST -> SI (FOR DOING MOTION), BP FOR CHECKING MOTION
	; GET GHOST_REVERSE -> DI (FOR DELETING PREVIOUS GHOST THEN UPDATING COORDINATES)
	; NOW SI, DI ARE POINTING TO X COORINATE
	                  LEA            SI, GHOST
	                  LEA            DI, GHOST_REVERSE
	                  LEA            BP, GHOST
	                  ADD            SI,2
	                  ADD            DI,2
	                  MOV            BX, WORD PTR [SI]
	                  ADD            SI,2
	                  ADD            DI,2
	                  MOV            DX, WORD PTR [SI]

	; IF IT IS UP
	                  CMP            AL,3
	                  JNE            NEXT_CMP

	                  CALL           CHECK_UP                          	;CHECK IF THERE IF BARRIER ABOVE
	                  CMP            PREVENT_UP,1
	                  JNE            C1
	                  CALL           CHANGE
	                  JMP            MOVE
	C1:               
	; DRAW REVERSE
	                  PUSH           SI
	                  LEA            SI,GHOST_REVERSE
	                  CALL           DRAW_OBJECT
	                  POP            SI

	; UPDATE REVERSE AND ORIGINAL
	                  SUB            DX,STEP
	                  MOV            [SI],DX
	                  MOV            [DI],DX
	                  JMP            DRAW_GHOST
	; IF IT IS DOWN
	NEXT_CMP:         
	                  CMP            AL,2
	                  JNE            NEXT_CMP2

	                  CALL           CHECK_DOWN
	                  CMP            PREVENT_DOWN,1
	                  JNE            C2
	                  CALL           CHANGE
	                  JMP            MOVE
	C2:               
	; DRAW REVERSE
	                  PUSH           SI
	                  LEA            SI,GHOST_REVERSE
	                  CALL           DRAW_OBJECT
	                  POP            SI
	; UPDATE REVERSE AND ORIGINAL
	                  ADD            DX,STEP
	                  MOV            [SI],DX
	                  MOV            [DI],DX
	                  JMP            DRAW_GHOST
	; IF IT IS RIGHT
	NEXT_CMP2:        
	; MAKE SI, DI POINT TO Y COORINATE
	                  SUB            SI,2
	                  SUB            DI,2

	                  CMP            AL,0
	                  JNE            NEXT_CMP3

	                  CALL           CHECK_RIGHT
	                  CMP            PREVENT_RIGHT,1
	                  JNE            C3
	                  CALL           CHANGE
	                  JMP            MOVE
	C3:               
	; DRAW REVERSE
	                  PUSH           SI
	                  LEA            SI,GHOST_REVERSE
	                  CALL           DRAW_OBJECT
	                  POP            SI
	; UPDATE REVERSE AND ORIGINAL
	                  ADD            BX,STEP
	                  MOV            [SI],BX
	                  MOV            [DI],BX
	; DRAW
	                  JMP            DRAW_GHOST
	; IF IT IS LEFT
	NEXT_CMP3:        
	                  CMP            AL,1
	                  JNE            DRAW_GHOST

	                  CALL           CHECK_LEFT
	                  CMP            PREVENT_LEFT,1
	                  JNE            C4
					 
	                  CALL           CHANGE
	                  JMP            MOVE
	C4:               
	; DRAW REVERSE
	                  PUSH           SI
	                  LEA            SI,GHOST_REVERSE
	                  CALL           DRAW_OBJECT
	                  POP            SI
	; UPDATE REVERSE AND ORIGINAL
	                  SUB            BX,STEP
	                  MOV            [SI],BX
	                  MOV            [DI],BX
	DRAW_GHOST:       
	                  LEA            SI,GHOST
	                  CALL           DRAW_OBJECT
	                  RET
DO_MOTION_GHOST ENDP



	               
	; THIS FUNCTION HANDLES GHOST MOTION ACCORDING TO
	; 1. COUNTER_I : WHICH IS A COUNTER TO MAKE A DELAY
	; 2. DIRECTIONS ARRAY: WHICH IA AN ARRAY OF RANDOM DIRECTIONS
DO_MOTION_GHOST2 PROC
	; CLEAR ALL PREVENT VARIABLES
	                  MOV            BL,0
	                  MOV            PREVENT_UP,BL
	                  MOV            PREVENT_DOWN,BL
	                  MOV            PREVENT_LEFT,BL
	                  MOV            PREVENT_RIGHT,BL

	; CHECK THAT THE DELAY IS OVER
	                  MOV            AX,CURRENT_I2
	                  CMP            AX, SPEED_DIVISOR2
	                  JE             MOVE2
	                  MOV            AX, CURRENT_I2
	                  INC            AX
	                  MOV            CURRENT_I2,AX
	                  RET
	MOVE2:            
	; RESET DELAY
	                  MOV            AX, 0
	                  MOV            CURRENT_I2,AX
	; GET THE NEW DIRECTION
	                  MOV            AX, CURRENT_DIRECTION2

	; GET GHOST -> SI (FOR DOING MOTION), BP FOR CHECKING MOTION
	; GET GHOST_REVERSE -> DI (FOR DELETING PREVIOUS GHOST THEN UPDATING COORDINATES)
	; NOW SI, DI ARE POINTING TO X COORINATE
	                  LEA            SI, GHOST2
	                  LEA            DI, GHOST_REVERSE2
	                  LEA            BP, GHOST2
	                  ADD            SI,2
	                  ADD            DI,2
	                  MOV            BX, WORD PTR [SI]
	                  ADD            SI,2
	                  ADD            DI,2
	                  MOV            DX, WORD PTR [SI]

	; IF IT IS UP
	                  CMP            AL,3
	                  JNE            NEXT_CMP12

	                  CALL           CHECK_UP                          	;CHECK IF THERE IF BARRIER ABOVE
	                  CMP            PREVENT_UP,1
	                  JNE            C12
	                  CALL           CHANGE2
	                  JMP            MOVE2
	C12:              
	; DRAW REVERSE
	                  PUSH           SI
	                  LEA            SI,GHOST_REVERSE2
	                  CALL           DRAW_OBJECT
	                  POP            SI

	; UPDATE REVERSE AND ORIGINAL
	                  SUB            DX,STEP
	                  MOV            [SI],DX
	                  MOV            [DI],DX
	                  JMP            DRAW_GHOST2
	; IF IT IS DOWN
	NEXT_CMP12:       
	                  CMP            AL,2
	                  JNE            NEXT_CMP22

	                  CALL           CHECK_DOWN
	                  CMP            PREVENT_DOWN,1
	                  JNE            C22
	                  CALL           CHANGE2
	                  JMP            MOVE2
	C22:              
	; DRAW REVERSE
	                  PUSH           SI
	                  LEA            SI,GHOST_REVERSE2
	                  CALL           DRAW_OBJECT
	                  POP            SI
	; UPDATE REVERSE AND ORIGINAL
	                  ADD            DX,STEP
	                  MOV            [SI],DX
	                  MOV            [DI],DX
	                  JMP            DRAW_GHOST2
	; IF IT IS RIGHT
	NEXT_CMP22:       
	; MAKE SI, DI POINT TO Y COORINATE
	                  SUB            SI,2
	                  SUB            DI,2

	                  CMP            AL,0
	                  JNE            NEXT_CMP32

	                  CALL           CHECK_RIGHT
	                  CMP            PREVENT_RIGHT,1
	                  JNE            C32
	                  CALL           CHANGE2
	                  JMP            MOVE2
	C32:              
	; DRAW REVERSE
	                  PUSH           SI
	                  LEA            SI,GHOST_REVERSE2
	                  CALL           DRAW_OBJECT
	                  POP            SI
	; UPDATE REVERSE AND ORIGINAL
	                  ADD            BX,STEP
	                  MOV            [SI],BX
	                  MOV            [DI],BX
	; DRAW
	                  JMP            DRAW_GHOST2
	; IF IT IS LEFT
	NEXT_CMP32:       
	                  CMP            AL,1
	                  JNE            DRAW_GHOST2

	                  CALL           CHECK_LEFT
	                  CMP            PREVENT_LEFT,1
	                  JNE            C42
					 
	                  CALL           CHANGE2
	                  JMP            MOVE2
	C42:              
	; DRAW REVERSE
	                  PUSH           SI
	                  LEA            SI,GHOST_REVERSE2
	                  CALL           DRAW_OBJECT
	                  POP            SI
	; UPDATE REVERSE AND ORIGINAL
	                  SUB            BX,STEP
	                  MOV            [SI],BX
	                  MOV            [DI],BX
	DRAW_GHOST2:      
	                  LEA            SI,GHOST2
	                  CALL           DRAW_OBJECT
	                  RET
DO_MOTION_GHOST2 ENDP




MAIN PROC FAR
	                  MOV            AX,@DATA
	                  MOV            DS,AX

	; ENTER 600X400 GRAPHICS MODE
	                  MOV            AX, 4F02H
	                  MOV            BX, 0100H
	                  INT            10H

	; DRAW MAZE AND PACMAN
	                  CALL           DRAW_MAZE
	                  CALL           DRAW_FOOD
	                  LEA            SI,PACMAN
	                  CALL           DRAW_OBJECT
	                  LEA            SI,GHOST
	                  CALL           DRAW_OBJECT
	                  LEA            SI,GHOST2
	                  CALL           DRAW_OBJECT


	; START GAME LOOP
	MAIN_LOOP:        
	; IF KEY PRESSED, GET IT
	;
	;  MOV            AH, 1                             	; PEEK
	;  INT            16H
	;  JZ             NOKEY
	;  MOV            AH, 0                             	; GET
	;  INT            16H
	                  CALL           HANDLE_INPUT
	                  MOV            AX,BP
	                  XCHG           AH,AL
	; IF ESCAPE PRESSED EXIT LOOP
	                  CMP            AH,ESCAPE
	                  JZ             EXIT
	; ELSE DO MOTION
	                  CALL           DO_MOTION_PACMAN

	NOKEY:            
	; CALL MAIN FUNCTIONS
	                  CALL           EAT
	                  CALL           DO_MOTION_GHOST
	                  CALL           DO_MOTION_GHOST2
	                  CALL           DRAW_FOOD

	; CHECK IF GHOST AND PACMAN OVERLAPPED
	                  LEA            SI,GHOST
	                  LEA            DI,PACMAN
	                  CALL           CHECK_OVERLAPPING
	                  CMP            AX,1
	                  JE             EXIT
	; CHECK IF GHOST2 AND PACMAN OVERLAPPED
	                  LEA            SI,GHOST2
	                  LEA            DI,PACMAN
	                  CALL           CHECK_OVERLAPPING
	                  CMP            AX,1
	                  JE             EXIT

	                  JMP            MAIN_LOOP
	EXIT:             
	                  MOV            AH,4CH
	                  INT            21H
MAIN ENDP
END MAIN
