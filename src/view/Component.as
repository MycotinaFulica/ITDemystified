package src.view
{
	import flash.display.MovieClip;
	
	//All displayable objects on the board will extends this class(Pieces, poss move hint and obstacle)
	
	public class Component extends MovieClip
	{
		private var boardRow:int;
		private var boardCol:int;
		private var active:Boolean = false;
		
		public function Component()
		{
			this.buttonMode = true;
		}
		
		public function setRow(rowVal:int):void
		{ boardRow = rowVal; }
		
		public function setCol(colVal:int):void
		{ boardCol = colVal; }
		
		public function activate():void
		{ active = true; }
		
		public function deactivate():void
		{ active = false; }
		
		public function getRow():int
		{ return boardRow; }
		
		public function getCol():int
		{ return boardCol; }
		
		public function getActiveStatus():Boolean
		{ return active; }
	}
}