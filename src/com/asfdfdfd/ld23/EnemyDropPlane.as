package com.asfdfdfd.ld23
{	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.motion.LinearMotion;
	
	public class EnemyDropPlane extends Entity
	{
		[Embed(source='../../../../assets/EnemyDropPlane.png')] private const ENEMY_BOMBER:Class;
		
		private var linearMotion:LinearMotion;
		
		public static const DROP_PLANE_SPEED:Number = 200;
		
		private const TIME_BETWEEN_DROPS:Number = 2;
		private const TIME_BETWEEN_TROOPERS:Number = 0.2;
		public static var MAX_TROOPERS_PER_DROP:Number = 1;
				
		private var _timerBetweenDrops:Number = TIME_BETWEEN_DROPS;
		private var _timerBetweenTroopers:Number = TIME_BETWEEN_TROOPERS;
		
		private var _droppedTroopersAtCurrentDrop:Number = 0;
		
		// 0 - waiting for drop
		// 1 - dropping troopers
		private var _state:int = 0;
		
		public function EnemyDropPlane(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			graphic = new Image(ENEMY_BOMBER);
			
			super(x, y, graphic);
			
			setHitbox(4, 4);
			
			_timerBetweenDrops -= FP.rand(100) / 100;
		}
		
		override public function update():void
		{			
			if (_state == 0)
			{
				_timerBetweenDrops -= FP.elapsed;
				
				if (_timerBetweenDrops <= 0)
				{
					_state = 1;
					
					_timerBetweenDrops += TIME_BETWEEN_DROPS - FP.rand(100) / 100;;
				}
			}
			else if (_state == 1)
			{
				_timerBetweenTroopers -= FP.elapsed;
				
				if (_timerBetweenTroopers <= 0)
				{
					_timerBetweenTroopers += TIME_BETWEEN_TROOPERS;
						
					_droppedTroopersAtCurrentDrop++;
					
					FP.world.add(new EnemyTrooper(x, y));
					
					if (_droppedTroopersAtCurrentDrop == MAX_TROOPERS_PER_DROP)
					{
						_droppedTroopersAtCurrentDrop = 0;
						_state = 0;
					}
				}
			}
		}
	}
}