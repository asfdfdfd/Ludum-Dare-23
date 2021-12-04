package com.asfdfdfd.ld23
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.motion.LinearMotion;
	import net.flashpunk.tweens.motion.LinearPath;
	import net.flashpunk.tweens.motion.QuadPath;
	
	public class Rocket extends Entity
	{
		[Embed(source='../../../../assets/Rocket.png')] private const BULLET:Class;
		
		private var _linearMotion:LinearMotion;
		
		private var _leaveTime:Number = 0;
		
		private var _prey:Entity;
		
		private var _speed:Number = 0;
		
		public function Rocket(x:Number, y:Number, leaveTime:Number, speed:Number, graphic:Graphic=null, mask:Mask=null)
		{
			graphic = new Image(BULLET);
			
			super(x, y, graphic);
			
			setHitbox(4, 4);
			
			_leaveTime = leaveTime;
			
			_speed = speed;
			
			_prey = getPrey();
			
			var toX:Number = 0;
			var toY:Number = 0;
			
//			if (_prey != null)
//			{
				toX = _prey.x;
				toY = _prey.y;
//			}

			_linearMotion = new LinearMotion();
			_linearMotion.setMotionSpeed(x, y, toX, toY, _speed);

			this.addTween(_linearMotion, true);
		}
		
		private function getPrey():Entity
		{
			var entites:Array = new Array();
			
			FP.world.getType("EnemyBallisticRocket", entites);
			
			if (entites.length > 0)
			{
				return entites[0];
			}
			
			FP.world.getType("EnemyBomb", entites);
			
			if (entites.length > 0)
			{
				return entites[0];
			}		
			
			FP.world.getType("EnemyTrooper", entites);
			
			if (entites.length > 0)
			{
				return entites[0];
			}		
			
			return new Entity(0, 0);
		}
		
		override public function update():void
		{
			checkHits();
			
			_leaveTime -= FP.elapsed;
			
			if (_leaveTime <= 0)
			{
				FP.world.remove(this);
				return;
			}
						
			x = _linearMotion.x;
			y = _linearMotion.y;
			
			if (_prey.world != FP.world) _prey = getPrey();
			
			_linearMotion.setMotionSpeed(x, y, _prey.x, _prey.y, _speed);		
		}		
		
		private function checkHits():void
		{
			var bomb:EnemyBomb = collide("EnemyBomb", x, y) as EnemyBomb;
			
			if (bomb)
			{
				bomb.hit(5);
				
				explode();
			}	
			
			var rocket:EnemyBallisticMissle = collide("EnemyBallisticRocket", x, y) as EnemyBallisticMissle;
			
			if (rocket)
			{
				rocket.hit(5);
				
				explode();
			}
			
			var trooper:EnemyTrooper = collide("EnemyTrooper", x, y) as EnemyTrooper;
			
			if (trooper)
			{
				trooper.hit(5);
				
				explode();
			}			
			
			var landscape:LandscapeBlock = collide("LandscapeBlock", x, y) as LandscapeBlock;
			
			if (landscape)
			{
				explode();
			}			
		}
		
		private function explode():void
		{
			FP.world.remove(this);
			FP.world.add(new RocketExplosion(x, y));
		}
	}
}