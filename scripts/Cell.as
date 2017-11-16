package scripts {
	
	import flash.display.MovieClip;
	import flash.display.Graphics; 
    import flash.display.Shape;
    import flash.display.Sprite;
	import scripts.*;
	
	public class Cell extends MovieClip {
		 
		public var colorFill;
		public var piece;
		public function Cell(piece, colorFill) {						
			this.colorFill = colorFill;
			this.piece = piece;
			init();

		}
		
		public function init():void {
			
			var child:Shape = new Shape(); 
			child.graphics.beginFill(colorFill);
            child.graphics.lineStyle(1, 0x000000);
            child.graphics.drawRect(0, 0, 40, 40);
            child.graphics.endFill();
            addChild(child);
			
			if(piece != null){
				piece.width = piece.height = 20;
				piece.x = piece.y = 10;
				addChild(piece);
			}
		
		}
		
		public function swapPieces(newPiece=null){
			if(piece != null){
				removeChild(piece);
			}
			if(newPiece != null){
				piece = newPiece;
				addChild(newPiece);
			}else{
				piece = null;
			}

		}
		
		
 
	}
	
}
