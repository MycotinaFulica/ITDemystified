package src.unit_testing
{
	import flash.display.Sprite;
	import src.controller.PossMoveGenerator;
	import src.model.Board;
	
	public class PossMoveGeneratorTest extends Sprite
	{
		var board:Board = new Board();
		
		public function PossMoveGeneratorTest()
		{
			board.updateState(3,3);
			board.updateState(6,4);
			board.updateState(9,3);
			//board.updateState(9,5);
			var state:Array = board.getBoardState();
			var moves:Array = PossMoveGenerator.generateMove(state,6,0);
			for(var i:int = 0 ; i<14 ; i++)
			{
				trace(state[i]);
			}
			
			for(var i:int = 0 ; i< moves.length; i++)
			{
				trace("(" + moves[i].row + "," + moves[i].col + ")");
			}
		}
	}
}