package src.model
{
	import src.model.BoardPoint;
	import src.controller.PossMoveGenerator;
	
	public class Board
	{
		private var boardState:Array = new Array();
		//Variable range : [0,3], blue, yellow, green, red respectively
		private var currentTurn:int = 0;
		//Variable range : [1,2], phase1 and phase2 respectively
		private var currentPhase:int = 1;
		//index 0,1,2,3 contains locations of blue, yellow, green and red amazons respectively
		private var amazonLoc:Array = new Array(4);
		//each entry represents each team (blue, yellow, green red) sequentially
		private var hasAvailMove:Array = [true, true, true, true];
		
		public function Board()
		{ setInit(); }
		
		public function setInit():void
		{
			//boardState represents the availability of each square of the board. Value 1 means the board is square is available and pieces can freely move
			//there, while 0 means the square is occupied either by an amazon or an obstacle.
			for(var i:int = 0 ; i<14 ; i++)
			{	
				boardState[i] = [1,1,1,1,1,1,1,1,1,1,1,1,1,1];
			}
			//blue
			boardState[5][0] = 0;  boardState[2][0] = 0; boardState[0][2] = 0; boardState[0][5] = 0;
			amazonLoc[0] = new Array();
			amazonLoc[0].push(new BoardPoint(5,0)); amazonLoc[0].push(new BoardPoint(2,0));
			amazonLoc[0].push(new BoardPoint(0,2)); amazonLoc[0].push(new BoardPoint(0,5));
			//yellow
			boardState[0][8] = 0;  boardState[0][11] = 0; boardState[2][13] = 0; boardState[5][13] = 0;
			amazonLoc[1] = new Array();
			amazonLoc[1].push(new BoardPoint(0,8)); amazonLoc[1].push(new BoardPoint(0,11));
			amazonLoc[1].push(new BoardPoint(2,13)); amazonLoc[1].push(new BoardPoint(5,13));
			//green
			boardState[8][13] = 0;  boardState[11][13] = 0; boardState[13][11] = 0; boardState[13][8] = 0;
			amazonLoc[2] = new Array();
			amazonLoc[2].push(new BoardPoint(8,13)); amazonLoc[2].push(new BoardPoint(11,13));
			amazonLoc[2].push(new BoardPoint(13,11)); amazonLoc[2].push(new BoardPoint(13,8));
			//red
			boardState[13][5] = 0;  boardState[13][2] = 0; boardState[11][0] = 0; boardState[8][0] = 0;
			amazonLoc[3] = new Array();
			amazonLoc[3].push(new BoardPoint(13,5)); amazonLoc[3].push(new BoardPoint(13,2));
			amazonLoc[3].push(new BoardPoint(11,0)); amazonLoc[3].push(new BoardPoint(8,0));
			
			currentTurn = 0; //blue player takes the first move
		}
		
		public function updateState(row:int, col:int):void
		{
			if(boardState[row][col] == 0)
				boardState[row][col] = 1;
			else
				boardState[row][col] = 0;
		}
		
		public function getCellState(row:int, col:int):int
		{ return boardState[row][col]; }
		
		public function getBoardState():Array
		{  
			var cloneState:Array = new Array();
			for(var i:int = 0 ; i<14  ; i++)
			{
				cloneState[i] = boardState[i];
			}
			
			return cloneState;
		}
		
		public function amazonMoved(rowFrom:int, colFrom:int, rowDest:int, colDest:int):void
		{
			//updating amazonLoc
			for(var i:int = 0 ; i<4 ; i++)
			{
				for(var j:int = 0 ; j<4 ; j++)
				{
					if(rowFrom == amazonLoc[i][j].row && colFrom == amazonLoc[i][j].col)
					{
						amazonLoc[i][j].row = rowDest;
						amazonLoc[i][j].col = colDest;
						i = 5;
						break;
					}
				}
			}
			
			currentPhase = 2;
			updateState(rowFrom, colFrom);
			updateState(rowDest, colDest);
		}		
		
		public function obstaclePlaced(row:int, col:int):void
		{
			updateState(row, col);
			updateMoveAvailability();
			determineNextTurnTaker();
			currentPhase = 1;
			trace("Current Turn : " + currentTurn);
		}
		
		private function determineNextTurnTaker():void
		{
			var nonAvailTeam:int=0;
			for(var i:int = 0 ; i<hasAvailMove.length ; i++)
			{
				if(hasAvailMove[i] == false)
					nonAvailTeam++;
			}
			
			if(nonAvailTeam == hasAvailMove.length) //if all teams can't move
				currentTurn = -1;
			else
			{
				do
				{
					currentTurn = (currentTurn+1)%4;
				}while(hasAvailMove[currentTurn] == false);
			}
		}
		
		private function updateMoveAvailability():void
		{
			var possMove:Array;
			for(var i:int = 0 ; i<4 ; i++)
			{
				for(var j:int = 0 ; j<4 ; j++)
				{
					possMove = PossMoveGenerator.generateMove(getBoardState(), amazonLoc[i][j].row, amazonLoc[i][j].col);
					if(possMove.length != 0)
						break; //if still have move, then no need to check for other team members
				}
				
				//if the 'if' block on the 'j' loop never reached, then team has no move left. The checking of length0 is necessary
				//because whether the team has move or not, this line will be reached. So conditional is needed.
				if(possMove.length == 0)
					hasAvailMove[i] = false; 
			}
		}
		
		public function getCurrentTurn():int
		{ return currentTurn; }
		
		public function getCurrentPhase():int
		{ return currentPhase; }
		
		public function getAvailabilityStat():Array
		{
			var clone:Array = new Array();
			for(var i:int = 0 ; i<hasAvailMove.length ; i++)
				clone[i] = hasAvailMove[i];
			
			return clone;
		}
		
		/*public function getAmazonLoc():Array //for testing purpose only
		{ return amazonLoc; }*/
	}
}