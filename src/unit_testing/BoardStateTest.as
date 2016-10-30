package src.unit_testing
{
	import flash.display.MovieClip;
	import src.model.Board;
	
	public class BoardStateTest extends MovieClip
	{
		var board:Board = new Board();
		public function BoardStateTest()
		{
			
			/*var arrState = board.getBoardState();
			
			board.updateState(10,11);
			arrState = board.getBoardState();
			trace("Initial Board State :");
			for(var i:int = 0 ; i<14 ; i++)
			{
				trace(arrState[i]);
			}
			
			board.amazonMoved(5,0, 5, 2);
			
			trace("After amazon moved :");
			for(i = 0 ; i<14 ; i++)
			{
				trace(arrState[i]);
			}
			
			board.obstaclePlaced(5,0);
			trace("After obstacle placed :");
			for(i = 0 ; i<14 ; i++)
			{
				trace(arrState[i]);
			}
			
			trace("Current turn : " + board.getCurrentTurn());*/
			
			//TestMove
			/*board.amazonMoved(13,5,7,2);
			var arr:Array = board.getAmazonLoc();
			for(var i:int = 0 ; i< 4 ; i++)
			{
				for(var j:int = 0 ; j<4 ; j++)
				{
					trace("Player : " + (i+1));
					trace(arr[i][j].row + "," + arr[i][j].col);
				}
			}*/
			
			//Test Placing Obstacle
			board.updateState(0,7); board.updateState(1,7);
			board.updateState(1,8); board.updateState(1,9);
			board.updateState(0,9); board.updateState(0,10);
			board.updateState(1,10); board.updateState(1,11);
			board.updateState(0,12); board.updateState(1,12);
			board.updateState(1,13); board.updateState(2,12);
			board.updateState(3,12); board.updateState(3,13);
			board.updateState(4,12); board.updateState(4,13);
			board.updateState(5,12); board.updateState(6,12);
			board.updateState(6,13);
			
			
			
			for(var i:int = 0 ; i<14 ; i++)
			{
				board.updateState(i,1);
			}
			
			for(i = 2 ; i<7 ; i++)
				board.updateState(1,i);
				
			board.updateState(0,3); board.updateState(0,4); board.updateState(0,6);
			board.updateState(3,0); board.updateState(4,0); board.updateState(6,0);
			
			for(i = 2 ; i<14 ; i++)
				board.updateState(12,i);
				
			for(i = 7 ; i<12 ; i++)
				board.updateState(i,12);
				
			board.updateState(7,0); board.updateState(9,0); board.updateState(10,0);
			board.updateState(12,0);
			board.updateState(13,3); board.updateState(13,4); board.updateState(13,6);
			board.updateState(13,7); board.updateState(13,9); board.updateState(13,10);
			board.updateState(13,12); board.updateState(7,13); board.updateState(9,13);
			board.updateState(10,13); 
			
			board.obstaclePlaced(1,0);
			board.obstaclePlaced(9,8);
			board.obstaclePlaced(9,9);
			board.obstaclePlaced(9,10);
			board.obstaclePlaced(9,11);
			board.obstaclePlaced(9,12);
			
			//test avail
			var avail:Array = board.getAvailabilityStat();
			
			for(var i:int = 0 ; i< avail.length ; i++)
				trace(avail[i]);
		
		}
	}
}