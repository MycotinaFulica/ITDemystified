package src.view
{
	import flash.display.MovieClip;
	import src.view.Component;
	import src.view.IAmazonRenderer;
	import src.controller.Engine;
	import src.model.Board;
	import src.model.BoardPoint;
	import src.model.Move;
	import flash.events.*;
	
	public class GameBoard extends MovieClip implements IAmazonRenderer
	{
		private var engine:Engine;
		private var boardPic:BoardPic = new BoardPic();
		private var piece:Array = new Array();
		private var possMovesHint:Array = new Array();
		private var obstaclesPic:Array = new Array();
		
		public function GameBoard()
		{
			engine = new Engine(this);
			createPieces();
			initializePosition();
			displayInitPosToCanvas();
			addingListener();
		}
		
		public function render(possMove:Array, obstacle:BoardPoint, movement:Move):void
		{
			if(possMove != null)
			{
				while(possMovesHint.length != 0)
				{
					removeChild(possMovesHint[possMovesHint.length - 1]);
					possMovesHint[possMovesHint.length - 1].removeEventListener(MouseEvent.CLICK, moveCommit);
					possMovesHint.pop();
				}
				
				while(possMove.length != 0)
				{
					var possMoveHn:PossMove = new PossMove();
					possMoveHn.addEventListener(MouseEvent.CLICK, moveCommit);
					possMoveHn.setRow(possMove[possMove.length-1].row);
					possMoveHn.setCol(possMove[possMove.length-1].col);
					possMovesHint.push(possMoveHn);
					possMove.pop();
				}
				displayPieces(possMovesHint);
			}
			else
			{
				while(possMovesHint.length != 0)
				{
					removeChild(possMovesHint[possMovesHint.length - 1]);
					possMovesHint[possMovesHint.length - 1].removeEventListener(MouseEvent.CLICK, moveCommit);
					possMovesHint.pop();
				}
			}
			
			if(obstacle != null)
			{
				var obs:Obstacle = new Obstacle();
				obs.setRow(obstacle.row);
				obs.setCol(obstacle.col);
				
				obs.x = 35.9 + 38.15*obs.getCol();
				obs.y = 35.7 + 38*obs.getRow();
				addChild(obs);
				obstaclesPic.push(obs);
			}
			
			if(movement != null)
			{
				for(var i:int = 0 ; i<4 ; i++)
				{
					for(var j:int = 0 ; j<4 ; j++)
					{
						if(piece[i][j].getRow() == movement.from.row && piece[i][j].getCol() == movement.from.col)
						{
							piece[i][j].setRow(movement.to.row);
							piece[i][j].setCol(movement.to.col);
							
							piece[i][j].x = 35.9 + 38.15*piece[i][j].getCol();
							piece[i][j].y = 35.7 + 38*piece[i][j].getRow();
							break;
						}
					}
				}
			}
		}
		
		private function amazonClick(evt:Event):void
		{ engine.amazonClicked(evt); }
		
		private function moveCommit(evt:Event):void
		{ engine.moveCommited(evt);	}
		
		private function displayPieces(pieces:Array):void
		{
			for(var i:int = 0 ; i< pieces.length ; i++)
			{	
				pieces[i].y = 35.7 + 38*pieces[i].getRow();
				pieces[i].x = 35.9 + 38.15*pieces[i].getCol();
					
				addChild(pieces[i]);
			}
		}
		
		private function createPieces():void
		{
			for(var i:int = 0 ; i<4 ; i++)
			{
				var temp:Array = new Array();
				for(var j:int = 0 ; j<4 ; j++)
				{
					if(i == 0)
						temp.push(new BlueQ());
					else if(i == 1)
						temp.push(new YellowQ());
					else if(i == 2)
						temp.push(new GreenQ());
					else
						temp.push(new RedQ());
				}
				piece[i] = temp;
				temp = null;
			}
		}
		
		private function initializePosition():void
		{
			//blue initial board position
			piece[0][0].setRow(5); piece[0][0].setCol(0);
			piece[0][1].setRow(2); piece[0][1].setCol(0);
			piece[0][2].setRow(0); piece[0][2].setCol(2);
			piece[0][3].setRow(0); piece[0][3].setCol(5);
			
			//Yellow initial position
			piece[1][0].setRow(5); piece[1][0].setCol(13);
			piece[1][1].setRow(2); piece[1][1].setCol(13);
			piece[1][2].setRow(0); piece[1][2].setCol(11);
			piece[1][3].setRow(0); piece[1][3].setCol(8);
			
			//Green initial position
			piece[2][0].setRow(13); piece[2][0].setCol(8);
			piece[2][1].setRow(13); piece[2][1].setCol(11);
			piece[2][2].setRow(11); piece[2][2].setCol(13);
			piece[2][3].setRow(8); piece[2][3].setCol(13);
			
			//Red initial position
			piece[3][0].setRow(8); piece[3][0].setCol(0);
			piece[3][1].setRow(11); piece[3][1].setCol(0);
			piece[3][2].setRow(13); piece[3][2].setCol(2);
			piece[3][3].setRow(13); piece[3][3].setCol(5);
		}
		
		private function displayInitPosToCanvas():void
		{	
			boardPic.x = 0; boardPic.y = 0;
			addChild(boardPic);
			for(var i:int = 0 ; i < 4 ; i++)
			{
				for(var j:int = 0 ; j<4 ; j++)
				{
					piece[i][j].y = 35.7 + 38*piece[i][j].getRow();
					piece[i][j].x = 35.9 + 38.15*piece[i][j].getCol();
					
					addChild(piece[i][j]);
				}
			}
		}
		
		private function addingListener():void
		{
			for(var i:int = 0 ; i<4 ; i++)
			{
				for(var j:int = 0 ; j<4 ; j++)
				{
					piece[i][j].addEventListener(MouseEvent.CLICK, amazonClick);
				}
			}
		}
	}
}