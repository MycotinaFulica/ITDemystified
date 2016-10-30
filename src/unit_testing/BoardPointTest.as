package src.unit_testing
{
	import flash.display.Sprite;
	import src.model.BoardPoint;
	
	public class BoardPointTest extends Sprite
	{
		public function BoardPointTest()
		{
			var point:BoardPoint = new BoardPoint(3,2);
			
			trace(point.row);
			trace(point.col);
		}
	}
}