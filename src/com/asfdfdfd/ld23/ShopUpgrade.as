package com.asfdfdfd.ld23
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	
	public class ShopUpgrade extends Entity
	{
		private var _callback:Function;
		
		private var _available:Boolean = false;
		
		public function ShopUpgrade(x:Number=0, y:Number=0, callback:Function = null, graphic:Graphic=null, available:Boolean = false, mask:Mask=null)
		{
			super(x, y, graphic, mask);
			
			this.available = available;
			
			_callback = callback;
			
			FP.world.add(this);
			
			this.setHitbox(120, 60);
		}
		
		override public function update():void
		{
			if (!_available) return;
			if (!Input.mousePressed) return;

			if (this.collidePoint(x, y, Input.mouseX, Input.mouseY))
			{
				_callback();
			}
		}
		
		public function set available(value:Boolean):void
		{
			_available = value;
			
			if (value)
			{
				(graphic as Image).alpha = 1;
			}
			else
			{
				(graphic as Image).alpha = 0.5;
			}
		}
	}
}