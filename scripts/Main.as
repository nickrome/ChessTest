package scripts {
	
	import flash.display.MovieClip;
	import flash.display.Graphics; 
    import flash.display.Shape;
    import flash.display.Sprite;
	import scripts.*; 
	import flash.events.*; 
	import flash.text.*;
	
	
	public final class Main extends MovieClip {
		
		var vertAxe = new Array();
		var pieces = new Array();
		var cellColor = 0xfbcd9c;
		var boardStartX = 40;
		var boardStartY = 40;
		var inputBox = new TextField; 
		var infoBox = new TextField; 
		var f = new TextFormat();
			
		public function Main() {			
			populateArrays();
			displayBoard();
			displayPrompt();
		} 

		//Create the input box as well as the text boxes. The instructions should always be on the top, untouched.
		function displayPrompt(){
			
			f.size = 20; 
			f.color = 0x000000; 
			
			inputBox.text =  "B7 to G8";
			inputBox.selectable = true;   
			inputBox.setTextFormat(f); 			
			inputBox.type = TextFieldType.INPUT;

			inputBox.x = 400;
			inputBox.y = 320;
			inputBox.width = 200;
			inputBox.height = 40;
			inputBox.border = true;
 			inputBox.addEventListener(KeyboardEvent.KEY_DOWN,handler);

			this.addChild(inputBox);
			
			var topInfoBox = new TextField;
			topInfoBox.text =  "Welcome! Please enter the coordinates of the piece you want moved, then the coordinates of the space you want to move too. \n Ex: B7 to G8"; 
			topInfoBox.setTextFormat(f); 			 

			topInfoBox.x = 400;
			topInfoBox.y = 40;
			topInfoBox.width = 380;
			topInfoBox.height = 100; 
			topInfoBox.multiline = true; 
			topInfoBox.wordWrap = true; 
			topInfoBox.selectable = false;   

			this.addChild(topInfoBox);
			
			infoBox.text =  " "; 
			infoBox.setTextFormat(f); 			 

			infoBox.x = 400;
			infoBox.y = 140;
			infoBox.width = 380;
			infoBox.height = 140; 
			infoBox.multiline = true; 
			infoBox.wordWrap = true; 
			infoBox.selectable = false;   

			this.addChild(infoBox);
			
		}
		
		//Check if they press enter while using the text box
		function handler(event:KeyboardEvent){
		   if(event.charCode == 13){
			   checkUserInput();
		   }
		}
		
		//Check to see if what the user typed is valid.
		function checkUserInput(){
			var userText = inputBox.text;

			var cor1 = userText.toLowerCase().substr(0, 2);
			var cor2;
			if(userText.lastIndexOf(" ") == -1){
				cor2 = userText.toLowerCase().substr(userText.lastIndexOf("o")+1, 7)
			}else{
				cor2 = userText.toLowerCase().substr(userText.lastIndexOf(" ")+1, 7)
			}
			
			//check to see if they put the coordinates in backwards.
			if(isNaN(cor1.substr(0, 1)) == false){
				cor1 = cor1.substr(1, 2) + cor1.substr(0, 1);
			}
			if(isNaN(cor2.substr(0, 1)) == false){
				cor2 = cor2.substr(1, 2) + cor2.substr(0, 1);
			}
			
			trace("Coordinate 1:" + cor1);
			trace("Coordinate 2:" + cor2);
			
			var text;
			
			//nested if to check if the move is valid. Custom warning if it is not.
			if(this.getChildByName(cor1) != null){
				if(Cell(this.getChildByName(cor1)).piece != null){
					if(this.getChildByName(cor2) != null){ 
							text = "Good job! Please go again!"
							var holdPiece = Cell(this.getChildByName(cor1)).piece;
							Cell(this.getChildByName(cor1)).swapPieces();
							Cell(this.getChildByName(cor2)).swapPieces(holdPiece);
							
					}else{
						text = "Coordinate Two (2) is incorrect. It is not a valid space. Please input a letter between a and h and a number between 1 and 8. Thank you."
					}
				}else{
					text = "Coordinate One (1) is incorrect. There is not piece at the location: " + cor1 + "\nPlease input a space that has a piece. Thank you."
				}
			}else{
				text = "Coordinate One (1) is incorrect. It is not a valid space. Please input a letter between a and h and a number between 1 and 8. Thank you."
			}
			
			inputBox.text = "";
			infoBox.text = text
			infoBox.setTextFormat(f); 			 

		}
		
		//create and display the board. Create and name each cell as well as assign it a piece.
		function displayBoard(){
			
			var f = new TextFormat();
			f.size = 20; 
			f.color = 0x000000; 
			 
			var x = boardStartX;
			var y = boardStartY;
			for(var h:int=0; h < vertAxe.length; h++){ 
				var horizontalText = new TextField; 
				horizontalText.text = vertAxe[h];
				horizontalText.selectable = false;   
				horizontalText.setTextFormat(f); 
				horizontalText.x = x + 10;
				horizontalText.y = boardStartY - 30;
				
				this.addChild(horizontalText);
				x+=40;
			}
			
			for(var v:int=8; v > 0; v--){ 
				var verticalText = new TextField; 
				verticalText.text = v;
				verticalText.selectable = false;   
				verticalText.setTextFormat(f); 
				verticalText.x = boardStartX - 30;
				verticalText.y = y + 10;
				
				this.addChild(verticalText);
				y+=40;
			}

						
			x = boardStartX;
			y = boardStartY;
			var p = 0;
			for(var c:int=8; c > 0; c--){ 
				for(var r:int=0; r < 8; r++){    
					var cell = new Cell(pieces[p], cellColor);
					this.addChild(cell);
					this.getChildAt(this.numChildren-1).name = vertAxe[r] + "" + c;
 					cell.x = x;
					cell.y = y;
					x += 40;
					p++
					swapColor();
				}
		
				swapColor();
				x = boardStartX;
				y += 40;
			
			}

		}
		
		//swap the color of the board.
		function swapColor(){
			if(cellColor == 0xfbcd9c){
				cellColor = 0xd38d47;
			}else{
				cellColor = 0xfbcd9c;
			}
		}
		
		function populateArrays(){
			vertAxe.push("a");
			vertAxe.push("b");
			vertAxe.push("c");
			vertAxe.push("d");
			vertAxe.push("e");
			vertAxe.push("f");
			vertAxe.push("g");
			vertAxe.push("h");
			pieces.push(new mcBlackRook);
			pieces.push(new mcBlackKnight);
			pieces.push(new mcBlackBishop);
			pieces.push(new mcBlackQueen);
			pieces.push(new mcBlackKing);
			pieces.push(new mcBlackBishop);
			pieces.push(new mcBlackKnight);
			pieces.push(new mcBlackRook);
			pieces.push(new mcBlackPawn);pieces.push(new mcBlackPawn);pieces.push(new mcBlackPawn);pieces.push(new mcBlackPawn);pieces.push(new mcBlackPawn);pieces.push(new mcBlackPawn);pieces.push(new mcBlackPawn);pieces.push(new mcBlackPawn);
			for(var n:int=0; n < 32; n++){ 
				pieces.push(null);
			}
			pieces.push(new mcWhitePawn);pieces.push(new mcWhitePawn);pieces.push(new mcWhitePawn);pieces.push(new mcWhitePawn);pieces.push(new mcWhitePawn);pieces.push(new mcWhitePawn);pieces.push(new mcWhitePawn);pieces.push(new mcWhitePawn);
			pieces.push(new mcWhiteRook);
			pieces.push(new mcWhiteKnight);
			pieces.push(new mcWhiteBishop);
			pieces.push(new mcWhiteQueen);
			pieces.push(new mcWhiteKing);
			pieces.push(new mcWhiteBishop);
			pieces.push(new mcWhiteKnight);
			pieces.push(new mcWhiteRook);
		}
		
		
		
	}
	
}
