package src.controller
{
	import src.model.BoardPoint;
	
	public class PossMoveGenerator
	{
		public function PossMoveGenerator()
		{ }
		
		public static function generateMove(boardState:Array, initRow:int, initCol:int):Array
		{
			var moves:Array = new Array();
			var moveRow;
			var moveCol;
			
			//move north
			moveRow = initRow - 1; moveCol = initCol;
			while(moveRow >= 0)
			{
				if(boardState[moveRow][moveCol] == 1)
					moves.push(new BoardPoint(moveRow, moveCol));
				else
					moveRow = -1;
					
				moveRow--;
			}
			
			//move north east
			moveRow = initRow - 1; moveCol = initCol + 1;
			while(moveRow>=0 && moveCol<=13)
			{
				if(boardState[moveRow][moveCol] == 1)
					moves.push(new BoardPoint(moveRow, moveCol));
				else
					moveRow = -1;
					
				moveRow--;
				moveCol++;
			}
			
			//move east
			moveRow = initRow; moveCol = initCol + 1;
			while(moveCol<=13)
			{
				if(boardState[moveRow][moveCol] == 1)
					moves.push(new BoardPoint(moveRow, moveCol));
				else
					moveCol = 14;
					
				moveCol++;
			}
			
			//move south east
			moveRow = initRow + 1; moveCol = initCol + 1;
			while(moveRow<=13 && moveCol<=13)
			{
				if(boardState[moveRow][moveCol] == 1)
					moves.push(new BoardPoint(moveRow, moveCol));
				else
					moveCol = 14;
				
				moveRow++;
				moveCol++;
			}
			
			//move south
			moveRow = initRow + 1; moveCol = initCol;
			while(moveRow<=13)
			{
				if(boardState[moveRow][moveCol] == 1)
					moves.push(new BoardPoint(moveRow, moveCol));
				else
					moveRow = 14;
				
				moveRow++;
			}
			
			//move south west
			moveRow = initRow + 1; moveCol = initCol - 1;
			while(moveRow<=13 && moveCol >= 0)
			{
				if(boardState[moveRow][moveCol] == 1)
					moves.push(new BoardPoint(moveRow, moveCol));
				else
					moveRow = 14;
				
				moveRow++;
				moveCol--;
			}
			
			//move west
			moveRow = initRow; moveCol = initCol - 1;
			while(moveCol >= 0)
			{
				if(boardState[moveRow][moveCol] == 1)
					moves.push(new BoardPoint(moveRow, moveCol));
				else
					moveCol = -1;
				
				moveCol--;
			}
			
			//move north west
			moveRow = initRow - 1; moveCol = initCol - 1;
			while(moveRow>=0 && moveCol >= 0)
			{
				if(boardState[moveRow][moveCol] == 1)
					moves.push(new BoardPoint(moveRow, moveCol));
				else
					moveCol = -1;
				
				moveRow--;
				moveCol--;
			}
			
			return moves;
		}
	}
}
