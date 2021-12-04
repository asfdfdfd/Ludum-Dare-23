package com.asfdfdfd.ld23
{
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Image;
	
	public class EnemyTrooper extends Entity
	{
		[Embed(source='../../../../assets/EnemyTrooper.png')] private const ENEMY_TROOPER:Class;
		
		private static const TROOPER_FALL_SPEED:Number = 50;
		
		private static const COST:Number = 5;
		
		private const TIME_BETWEEN_GUN_SESSIONS:Number = 7;
		private const TIME_BETWEEN_GUN_SHOOTS:Number = 0.1;
		
		private var _timerBetweenGunSessions:Number = TIME_BETWEEN_GUN_SESSIONS;
		private var _timerBetweenGunShoots:Number = TIME_BETWEEN_GUN_SHOOTS;
		
		private var _shootedBullets:int = 0;
		
		[Embed(source='../../../../assets/HeroGunShoot.mp3')] private static const GUN_SHOOT:Class;
		
		private var _shootSfx:Sfx = new Sfx(EnemyTrooper.GUN_SHOOT);
		
		// 0 - waiting for shoot
		// 1 - shooting
		private var _state:int = 1;
		
		private var _health:Number = 1;
		
		public function EnemyTrooper(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			graphic = new Image(ENEMY_TROOPER);
			
			super(x, y, graphic);
			
			setHitbox(16, 16);
			
			type = "EnemyTrooper";
		}
		
		override public function update():void
		{
			if (!onCamera)
			{
				FP.world.remove(this);
			}
			
			var bullet:Bullet = collide("Bullet", x, y) as Bullet;
			
			if (bullet)
			{
				hit(1);
				
				FP.world.remove(bullet);
			}	
			
			moveBy(0, EnemyTrooper.TROOPER_FALL_SPEED * FP.elapsed, "LandscapeBlock");
			
			var hero:Hero = FP.world.getInstance("Hero") as Hero;
			
			shoot(hero.x, hero.y);
		}
		
		public function hit(value:Number):void
		{
			_health -= value;
			
			if (_health <= 0)
			{
				FP.world.remove(this);
				Hero.SCORES += EnemyTrooper.COST;
				Hero.SCORES_SESSION += EnemyTrooper.COST;				
			}
		}
		
		private function shoot(toX:Number, toY:Number):void
		{
			if (_state == 0)
			{
				_timerBetweenGunSessions -= FP.elapsed;
				
				if (_timerBetweenGunSessions <= 0)
				{
					_state = 1;
					
					_timerBetweenGunSessions += TIME_BETWEEN_GUN_SESSIONS;
				}
			}
			else if (_state == 1)
			{
				_timerBetweenGunShoots -= FP.elapsed;
				
				if (_timerBetweenGunShoots <= 0)
				{
					_timerBetweenGunShoots += TIME_BETWEEN_GUN_SHOOTS;
					
					var line:Line = new Line(new Point(x, y), new Point(toX, toY));
	
					if (toX > x)
					{
						toX = 641;
						toY = line.getY(toX);	
					}
					else
					{
						toX = -20;
						toY = line.getY(toX);	
					}
					
					FP.world.add(new EnemyBullet(x, y, toX, toY));
					
					_shootSfx.play();
					
					_shootedBullets++;
					
					if (_shootedBullets == 3)
					{
						_shootedBullets = 0;
						_state = 0;
					}
				}
			}
		}		
	}
}