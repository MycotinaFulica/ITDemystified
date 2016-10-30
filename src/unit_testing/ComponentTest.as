package src.unit_testing
{
	import flash.display.MovieClip;
	
	public class ComponentTest extends MovieClip
	{
		public function ComponentTest()
		{
			var blue:BlueQ = new BlueQ();
			
			addChild(blue);
		}
	}
}