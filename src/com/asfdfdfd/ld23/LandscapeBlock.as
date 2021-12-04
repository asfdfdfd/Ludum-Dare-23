package com.asfdfdfd.ld23
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	
	public class LandscapeBlock extends Entity
	{
		[Embed(source='../../../../assets/LandscapeBlock.png')] private const LANDSCAPE_BLOCK:Class;
		
		public function LandscapeBlock(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			graphic = new Image(LANDSCAPE_BLOCK);
			
			super(x, y, graphic);
			
			setHitbox(16, 16);
			
			type = "LandscapeBlock";
		}
	}
}