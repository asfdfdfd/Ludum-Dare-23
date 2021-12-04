package com.asfdfdfd.ld23
{
	import flash.display.BitmapData;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Emitter;
	
	public class RocketExplosion extends Entity
	{
		private var _emitter:Emitter;
		
		private var timer:Number = 0;
		
		private var particle_count:int = 400;	
		
		private var _exploded:Boolean = false;
		
		public function RocketExplosion(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			_emitter = new Emitter(particle);
			
			_emitter.newType('explode',[0]);
			_emitter.setMotion('explode', 0, 0, 0.2, 360, 200, 1);
			_emitter.relative = false;
		
			setHitbox(16 * 3, 16 * 3);
			
			super(x, y, _emitter, mask);
		}
		
		
		override public function update():void 
		{	
//			var blocks:Array = new Array();
//			
//			collideInto("LandscapeBlock", x, y, blocks);
//			
//			for each(var block:LandscapeBlock in blocks)
//			{
//				FP.world.remove(block);
//			}
			
			if (!_exploded)
			{
				_exploded = true;
				explode(x, y);
			}
		}
		
		private function explode(x:Number, y:Number):void
		{
			for(var i:int = 0; i < particle_count; i++)
			{
				_emitter.emit('explode',x,y);
			}
		}
		
		private function get particle():BitmapData
		{
			var data:BitmapData = new BitmapData(1,1,false, 0xFFC700);
			return data;
		}		
	}
}