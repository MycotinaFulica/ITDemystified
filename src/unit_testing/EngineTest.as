package src.unit_testing
{
	import flash.display.MovieClip;
	import src.view.IAmazonRenderer;
	import src.controller.Engine;
	import src.model.Board;
	import src.model.BoardPoint;
	import src.model.Move;
	import flash.events.*;
	
	public class EngineTest extends MovieClip implements IAmazonRenderer
	{
		private var blue:BlueQ = new BlueQ();
		private var possMove:PossMove = new PossMove();
		private var obstLoc:PossMove = new PossMove();
		private var eng:Engine;
		private var board:Board = new Board();
		
		public function EngineTest()
		{
			printBoardState();
			eng = new Engine(this);
			eng.addEventListener(Engine.GAME_ENDED, declareWinner);
			blue.addEventListener(MouseEvent.CLICK, amazonClick);
			blue.setRow(5);
			blue.setCol(10);
			
			possMove.addEventListener(MouseEvent.CLICK, moveCommit);
			possMove.setRow(8);
			possMove.setCol(7);
			
			obstLoc.addEventListener(MouseEvent.CLICK, moveCommit);
			obstLoc.setRow(8);
			obstLoc.setCol(10);
			
			possMove.x = 0;
			possMove.y = 40;
			
			obstLoc.x = 40;
			obstLoc.y = 0;
			
			addChild(blue);
			addChild(possMove)
			addChild(obstLoc);
		}
		
		public function printBoardState():void
		{
			var states:Array = board.getBoardState();
			
			for(var i:int = 0 ; i<14 ; i++)
			{
				trace(states[i]);
			}
		}
		
		public function render(possMove:Array, obstacle:BoardPoint, movement:Move):void
		{
			if(possMove != null)
			{	
				trace("Poss Moves :");
				for(var i:int = 0; i<possMove.length ; i++)
				{
					trace(possMove[i].row + "," + possMove[i].col);
				}
			}
			
			if(obstacle != null)
			{
				trace("Obstacles");
				trace(obstacle.row + "," + obstacle.col);
			}
				
			if(movement != null)
			{
				trace("From : " + movement.from.row + "," + movement.from.col + " To : " + movement.to.row + "," + movement.to.col);
			}
		}
		
		private function amazonClick(evt:Event):void
		{
			eng.amazonClicked(evt);
		}
		
		private function moveCommit(evt:Event):void
		{
			eng.moveCommited(evt);
		}
		
		private function  declareWinner(evt:Event):void
		{
			trace("Winner :" + evt.target.winner);
		}
	}
}