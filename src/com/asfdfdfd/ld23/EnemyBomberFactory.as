package com.asfdfdfd.ld23
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.motion.LinearMotion;
	
	public class EnemyBomberFactory extends Entity
	{
		public var TIME_BETWEEN_BOMBERS:Number = 5;
		
		private var _timerBetweenBombers:Number = TIME_BETWEEN_BOMBERS;
		
		// 0 - waiting bomber appear
		// 1 - waiting bomber bombing
		private var _state:int = 0; 
		
		private var _bomber:EnemyBomber;
		
		private var linearMotion:LinearMotion;
		
		public function EnemyBomberFactory(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(x, y, graphic, mask);
		}
		
		override public function update():void
		{
			if (_state == 0)
			{
				_timerBetweenBombers -= FP.elapsed;
				
				if (_timerBetweenBombers <= 0)
				{
					_timerBetweenBombers += TIME_BETWEEN_BOMBERS;
					
					_bomber = new EnemyBomber();
					
					linearMotion = new LinearMotion(function():void {
						_state = 0;	
						FP.world.remove(_bomber);
					}, Tween.ONESHOT);
					
					linearMotion.setMotionSpeed(0, 0, 640, 0, EnemyBomber.BOMBER_SPEED);
					
					_bomber.addTween(linearMotion, true);
					
					_state = 1;
					
					FP.world.add(_bomber);
				}
			}
			else if (_state == 1)
			{
				_bomber.x = linearMotion.x;
				_bomber.y = linearMotion.y;
			}
		}
	}
}