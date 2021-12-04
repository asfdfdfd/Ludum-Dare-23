package com.asfdfdfd.ld23
{	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.motion.LinearMotion;
	
	public class EnemyBomber extends Entity
	{
		[Embed(source='../../../../assets/EnemyBomber.png')] private const ENEMY_BOMBER:Class;
		
		public static const BOMBER_SPEED:Number = 200;
		
		public static var TIME_BETWEEN_BOMBING:Number = 2;
		
		private var _timerBetweenBombing:Number = TIME_BETWEEN_BOMBING;
		
		public function EnemyBomber(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			graphic = new Image(ENEMY_BOMBER);
			
			super(x, y, graphic);
			
			setHitbox(4, 4);

			_timerBetweenBombing += FP.rand(100) / 100;
		}
		
		override public function update():void
		{
			_timerBetweenBombing -= FP.elapsed;
			
			if (_timerBetweenBombing <= 0)
			{
				_timerBetweenBombing += EnemyBomber.TIME_BETWEEN_BOMBING - FP.rand(100) / 100;
				
				FP.world.add(new EnemyBomb(x, y));
			}
		}
	}
}