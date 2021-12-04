package com.asfdfdfd.ld23
{	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.motion.CubicMotion;
	import net.flashpunk.tweens.motion.LinearMotion;
	
	public class EnemyRocketShip extends Entity
	{
		[Embed(source='../../../../assets/EnemyRocketShip.png')] private const ENEMY_ROCKET_SHIP:Class;
		
		public static var TIME_BETWEEN_BOMBING:Number = 10;
		
		private var _timerBetweenBombing:Number = TIME_BETWEEN_BOMBING;
		
		public function EnemyRocketShip(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			graphic = new Image(ENEMY_ROCKET_SHIP);
			
			super(x, y, graphic);
						
			setHitbox(142, 4);
		}
		
		override public function update():void
		{			
			_timerBetweenBombing -= FP.elapsed;
			
			if (_timerBetweenBombing <= 0)
			{
				_timerBetweenBombing += TIME_BETWEEN_BOMBING;
							
				var hero:Hero = FP.world.getInstance("Hero");
				
				FP.world.add(new EnemyBallisticMissle(x + width, y, hero.x, hero.y));
			}
		}
	}
}