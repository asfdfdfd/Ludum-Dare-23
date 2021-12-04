package com.asfdfdfd.ld23
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	
	public class WaterBlock extends Entity
	{
		[Embed(source='../../../../assets/Water.png')] private const LANDSCAPE_BLOCK:Class;
		
		public function WaterBlock(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			graphic = new Image(LANDSCAPE_BLOCK);
			
			super(x, y, graphic);
			
			setHitbox(32, 32);
			
			type = "Water";
		}
	}
}