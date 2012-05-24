package org.josht.starling.foxhole.layoutExplorer.data
{
	import org.josht.starling.foxhole.layout.TiledColumnsLayout;

	public class TiledColumnsLayoutSettings
	{
		public function TiledColumnsLayoutSettings()
		{
		}

		public var itemCount:int = 50;
		public var horizontalAlign:String = TiledColumnsLayout.HORIZONTAL_ALIGN_LEFT;
		public var verticalAlign:String = TiledColumnsLayout.VERTICAL_ALIGN_TOP;
		public var tileHorizontalAlign:String = TiledColumnsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
		public var tileVerticalAlign:String = TiledColumnsLayout.TILE_VERTICAL_ALIGN_TOP;
		public var gap:Number = 0;
		public var paddingTop:Number = 0;
		public var paddingRight:Number = 0;
		public var paddingBottom:Number = 0;
		public var paddingLeft:Number = 0;
	}
}
