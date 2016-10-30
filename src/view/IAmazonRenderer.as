package src.view
{
	import src.model.BoardPoint;
	import src.model.Move;
	
	public interface IAmazonRenderer
	{
		function render(possMove:Array, obstacle:BoardPoint, movement:Move):void;
	}
}