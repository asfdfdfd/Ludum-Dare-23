package com.asfdfdfd.ld23
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class LifeBar extends Entity
	{
		public var bar:Image = Image.createRect(100, 10, 0xFF0000);
		
		public function LifeBar() 
		{
			super(FP.width - bar.width - 30, 30, bar);
			
			name = "LifeBar";
		}
		
		override public function update():void 
		{
//			if (Input.pressed(Key.RIGHT))
//			{
//				bar.clipRect.width = FP.approach(bar.clipRect.width, bar.width, 5);
//				bar.clear();
//				bar.updateBuffer();
//			}
//			if (Input.pressed(Key.LEFT))
//			{
//				bar.clipRect.width = FP.approach(bar.clipRect.width, 0, 5);
//				bar.clear();
//				bar.updateBuffer();
//			}
		}
		
		public function setHealth(curValue:Number, maxValue:Number):void
		{
			bar.clipRect.width = (curValue / maxValue) * 100;
			bar.clear();
			bar.updateBuffer();
		}
	}
}