package com.asfdfdfd.ld23
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.motion.LinearMotion;
	
	public class EnemyDropPlaneFactory extends Entity
	{
		public static var TIME_BETWEEN_DROP_PLANES:Number = 5;
		
		private var _timerBetweenDropPlanes:Number = TIME_BETWEEN_DROP_PLANES;
		
		// 0 - waiting bomber appear
		// 1 - waiting bomber bombing
		private var _state:int = 0; 
		
		private var _dropPlane:EnemyDropPlane;
		
		private var linearMotion:LinearMotion;
		
		public function EnemyDropPlaneFactory(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(x, y, graphic, mask);
		}
		
		override public function update():void
		{
			if (_state == 0)
			{
				_timerBetweenDropPlanes -= FP.elapsed;
				
				if (_timerBetweenDropPlanes <= 0)
				{
					_timerBetweenDropPlanes += TIME_BETWEEN_DROP_PLANES;
					
					_dropPlane = new EnemyDropPlane();
					
					linearMotion = new LinearMotion(function():void {
						_state = 0;	
						FP.world.remove(_dropPlane);
					}, Tween.ONESHOT);
					
					linearMotion.setMotionSpeed(640, 40, -200, 40, EnemyDropPlane.DROP_PLANE_SPEED);
					
					_dropPlane.addTween(linearMotion, true);
					
					_state = 1;
					
					FP.world.add(_dropPlane);
				}
			}
			else if (_state == 1)
			{
				_dropPlane.x = linearMotion.x;
				_dropPlane.y = linearMotion.y;
			}
		}
	}
}