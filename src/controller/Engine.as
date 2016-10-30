package src.controller
{
	import flash.events.*;
	import src.model.Board;
	import src.model.BoardPoint;
	import src.model.Move;
	import src.view.IAmazonRenderer;
	import src.view.Component;
	
	public class Engine extends EventDispatcher
	{
		private var view:IAmazonRenderer;
		private var board:Board = new Board();
		private var selectedPos:BoardPoint = new BoardPoint(-1,-1);
		public var winner = -1;
		
		public static const GAME_ENDED:String = "gameEnded";
		
		public function Engine(view:IAmazonRenderer)
		{
			this.view = view;
		}
		
		public function amazonClicked(evt:Event):void
		{
			if(evt.target is Component)
			{
				var turnTaker = board.getCurrentTurn();
				var cont:Boolean = false;
				var moves:Array;
				
				if((selectedPos.row == evt.target.getRow() && selectedPos.col == evt.target.getCol())|| board.getCurrentPhase() == 2)
					return;
				
				if(turnTaker == 0 && evt.target is BlueQ)
					cont = true; 
				else if(turnTaker == 1 && evt.target is YellowQ)
					cont = true; 
				else if(turnTaker == 2 && evt.target is GreenQ)
					cont = true; 
				else if(turnTaker == 3 && evt.target is RedQ)
					cont = true; 
				
				if(cont)
				{
					selectedPos.row = evt.target.getRow();
					selectedPos.col = evt.target.getCol();
					moves = PossMoveGenerator.generateMove(board.getBoardState(), selectedPos.row, selectedPos.col);
					view.render(moves, null, null);
				}
			}
		}
		
		public function moveCommited(evt:Event):void
		{
			if(evt.target is Component)
			{
				if(board.getCurrentPhase() == 1)
				{
					var move:Move = new Move();
					var obsPossPlacement:Array;
					
					move.from.row = selectedPos.row;
					move.from.col = selectedPos.col;
					selectedPos.row = -1;
					selectedPos.col = -1;
					
					move.to.row = evt.target.getRow();
					move.to.col = evt.target.getCol();
					
					board.amazonMoved(move.from.row, move.from.col, move.to.row, move.to.col);
					obsPossPlacement = PossMoveGenerator.generateMove(board.getBoardState(), move.to.row, move.to.col);

					view.render(obsPossPlacement, null, move);
				}
				else
				{
					var placement:BoardPoint = new BoardPoint(evt.target.getRow(), evt.target.getCol());
					
					board.obstaclePlaced(placement.row, placement.col);
					view.render(null, placement, null);
					
					//check end game
					var availStat:Array = board.getAvailabilityStat();
					if(availStat[0] == false && availStat[2] == false) 
					{
						winner = 2;
						dispatchEvent(new Event(Engine.GAME_ENDED));
					}
					else if(availStat[1] == false && availStat[3] == false)
					{
						winner = 1;
						dispatchEvent(new Event(Engine.GAME_ENDED));
					}
				}
			}
		}//movecommited block
	}
}
