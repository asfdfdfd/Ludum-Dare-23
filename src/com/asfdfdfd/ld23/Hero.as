package com.asfdfdfd.ld23
{
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Hero extends Entity
	{
		[Embed(source='../../../../assets/Hero.png')] private const HERO:Class;
		
		public var sprMap:Spritemap = new Spritemap(HERO, 32, 32);
		
		[Embed(source='../../../../assets/HeroGunShoot.mp3')] private static const GUN_SHOOT:Class;
		[Embed(source='../../../../assets/HeroJump.mp3')] private static const JUMP_SOUND:Class;
		
		public static const MAX_SPEED:Number = 200;
		public static const ACCEL:Number = 10;
		public static const FRICTION:Number = MAX_SPEED / (MAX_SPEED + ACCEL);
		public static const MIN_SPEED:Number = ACCEL * FRICTION;
		public static const GRAVITY:Number = 20;
		public static const MAX_FALL:Number = 800;
		
		private var _shootSfx:Sfx = new Sfx(Hero.GUN_SHOOT);
		private var _jumpSfx:Sfx = new Sfx(Hero.JUMP_SOUND);
		
		private static const TIME_BETWEEN_GUN_SHOOTS:Array = [0.25, 0.2, 0.15, 0.1];
		private var _timeBetweenGunShoots:Number = Hero.TIME_BETWEEN_GUN_SHOOTS[BULLET_LEVEL];
		private var _timerBetweenGunShoots:Number = Hero.TIME_BETWEEN_GUN_SHOOTS[BULLET_LEVEL];
		private static var BULLET_LEVEL:int = 0;
				
//		public var sprite:Spritemap = new Spritemap(PLAYER, 20, 20);
		public var speed:Point = new Point();
//		public var safeSpot:Point;

		private static const DEFAULT_HEALTH_LEVELS:Array = [100, 200, 300, 400];
		public static var HEALTH_LEVEL:int = 0;
		private var _health:Number = Hero.DEFAULT_HEALTH_LEVELS[HEALTH_LEVEL];
		
		private static const ROCKET_LEAVE_TIMES:Array = [0, 3, 4, 5];
		private static const ROCKET_SPEEDS:Array = [0, 200, 300, 400];
		private var _rocketLevel:int = 1;
		
		private var _laserLevel:int = 0;
		private var _shieldLevel:int = 0;
		
		private static const JUMP_PAWAS:Array = [300, 400, 500, 600];
		public static var JUMP_LEVEL:int = 0;
		private var _jumpPower:Number = JUMP_PAWAS[JUMP_LEVEL];
				
		private static const BOMB_DAMAGE:Number = 50;
		private static const BALLISTIC_MISSLE_DAMAGE:Number = 70;
				
		public static var SCORES:int = 0;
		public static var SCORES_SESSION:int = -1;
		
		public static var NAME:String = "LudumDare23";
		
		public function Hero(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			//graphic = new Image(HERO);
			
			sprMap.add("stand_left", [0], 20);
			sprMap.add("stand_right", [5], 20);
			sprMap.add("jump_left", [0], 20);
			sprMap.add("jump_right", [0], 20);			
			sprMap.add("left", [0, 1, 2], 20);
			sprMap.add("right", [3, 4, 5], 20);
			
			super(x, y, sprMap);
			
			setHitbox(32, 32);
			
			name = "Hero";
			type = "Hero";
		}
		
		public function get HealthLevel():int
		{
			return Hero.HEALTH_LEVEL;
		}
		
		public function set HealthLevel(value:int):void
		{
			Hero.HEALTH_LEVEL = value;
			_health = Hero.DEFAULT_HEALTH_LEVELS[Hero.HEALTH_LEVEL];
		}
		
		public function get BulletLevel():int
		{
			return Hero.BULLET_LEVEL;
		}
		
		public function set BulletLevel(value:int):void
		{
			Hero.BULLET_LEVEL = value;
			
			_timeBetweenGunShoots = Hero.TIME_BETWEEN_GUN_SHOOTS[BULLET_LEVEL];
		}
		
		public function get JumpLevel():int
		{
			return Hero.JUMP_LEVEL;
		}
		
		public function set JumpLevel(value:int):void
		{
			Hero.JUMP_LEVEL = value;
			_jumpPower = Hero.JUMP_PAWAS[Hero.JUMP_LEVEL]
		}		
		
//		public function get LaserLevel():int
//		{
//			return _laserLevel;
//		}
//		
//		public function set LaserLevel(value:int):void
//		{
//			_laserLevel = value;
//		}
//		
//		public function get RocketLevel():int
//		{
//			return _rocketLevel;
//		}
//		
//		public function set RocketLevel(value:int):void
//		{
//			_rocketLevel = value;
//		}		
//		
//		public function get ShieldLevel():int
//		{
//			return _shieldLevel;
//		}
//		
//		public function set ShieldLevel(value:int):void
//		{
//			_shieldLevel = value;
//		}	
		
		public function get health():Number
		{
			return _health;
		}
		
		public function reset():void
		{
			_health = Hero.DEFAULT_HEALTH_LEVELS[HEALTH_LEVEL];
			Hero.SCORES_SESSION = -1;
			x = 400-width;
			y = 364-height;
		}
		
		override public function update():void 
		{	
			if (y >= 480)
			{
				_health = 0;
			}
			
			if (collide("LandscapeBlock", x, y + 1))
			{
				if (Input.pressed(Key.W))
				{
					_jumpSfx.play();
					speed.y = -_jumpPower;
//					squish(0.7, 1.4);
				}
			}
			else
			{
				speed.y += GRAVITY;
				
				if (speed.y > MAX_FALL)
					speed.y = MAX_FALL;
			}
			
			if (Input.check(Key.D))
			{
				sprMap.play("right");
				speed.x += ACCEL;
			}
			
			if (Input.check(Key.A))
			{
				sprMap.play("left");
				speed.x -= ACCEL;
			}
			
			if (Input.released(Key.D))
			{
				sprMap.play("stand_right");
			}
			
			if (Input.released(Key.A))
			{
				sprMap.play("stand_left");
			}
			
			
			speed.x *= FRICTION;
			
			if (Math.abs(speed.x) < MIN_SPEED)
				speed.x = 0;
			
			moveBy(speed.x * FP.elapsed, speed.y * FP.elapsed, "LandscapeBlock", true);
			
			x = Math.max(x, 10);
			
			if (collide("LandscapeBlock", x, y + 1))
			{
				if (Math.abs(speed.x) > MIN_SPEED)
				{
//					sprite.play("Run");
//					sprite.rate = FP.scale(Math.abs(speed.x), 0, MAX_SPEED, 0, 1);
				}
				else
				{
//					sprite.play("Idle");
//					sprite.rate = 1;
				}
			}
			else
			{
//				sprite.frame = 3;
			}
			
//			if (speed.x != 0)
//				sprite.flipped = speed.x < 0; 
			
//			if (collide("Death", x, y))
//			{
//				world.add(new Explode(x, y - 10));
//				speed.x = speed.y = 0;
//				active = false;
//				sprite.alpha = 0.5;
//				TweenMax.to(this, 0.5, { x:safeSpot.x, y:safeSpot.y, ease:Back.easeIn, onComplete:enable } );
//				Room(world).shake(20, 4);
//			}
//			else if (!collide("Death", x + 20, y) && !collide("Death", x - 20, y))
//			{
//				if (collide("Solid", x, y + 1) && collide("Solid", x + 20, y + 1) && collide("Solid", x - 20, y + 1))
//				{
//					safeSpot.x = x;
//					safeSpot.y = y;
//				}
//			}
			
			if (Input.mouseDown)
			{
				shoot();	
			}	
			
//			if (Input.pressed(Key.Q))
//			{
//				shootRocket();
//			}
						
			var bomb:EnemyBomb = collide("EnemyBomb", x, y) as EnemyBomb;
			if (bomb)
			{
				bomb.explode();
				
				hit(Hero.BOMB_DAMAGE);
			}
			
			var missle:EnemyBallisticMissle = collide("EnemyBallisticRocket", x, y) as EnemyBallisticMissle;
			if (missle)
			{
				missle.explode();
				
				hit(Hero.BALLISTIC_MISSLE_DAMAGE);
			}			
			
			var lifeBar:LifeBar = FP.world.getInstance("LifeBar") as LifeBar;
			lifeBar.setHealth(_health, Hero.DEFAULT_HEALTH_LEVELS[HEALTH_LEVEL]);			
		}
				
		public function hit(value:Number):void
		{
			_health -= value;
		}
		
		override public function moveCollideX(e:Entity):Boolean 
		{
			speed.x = 0;
			return true;
		}
		
		override public function moveCollideY(e:Entity):Boolean 
		{
			if (speed.y > 0)
			{
				speed.x *= 0.75;
				squish(1.4, 0.7);
			}
			
			speed.y = 0;
			return true;
		}
		
		public function squish(x:Number, y:Number):void
		{
//			sprite.scaleX = x;
//			sprite.scaleY = y;
//			TweenMax.killTweensOf(sprite);
//			TweenMax.to(sprite, 0.15, { scaleX:1, scaleY:1, ease:Cubic.easeIn } );
		}
		
		private function shootRocket():void
		{
			if (_rocketLevel == 0) return;
			
			FP.world.add(new Rocket(x, y, Hero.ROCKET_LEAVE_TIMES[_rocketLevel], Hero.ROCKET_SPEEDS[_rocketLevel]));			
		}
		
		private function shoot():void
		{
			_timerBetweenGunShoots -= FP.elapsed;
			
			if (_timerBetweenGunShoots <= 0)
			{
				_timerBetweenGunShoots += _timeBetweenGunShoots;
				
				var line:Line = new Line(new Point(x, y), new Point(Input.mouseX, Input.mouseY));
				
				var toX:Number;
				var toY:Number;
				
				if (Input.mouseX > x)
				{
					toX = 641;
					toY = line.getY(toX);	
				}
				else
				{
					toX = -20;
					toY = line.getY(toX);	
				}
				
				FP.world.add(new Bullet(x, y, toX, toY));
			
				_shootSfx.play();
			}
		}
	}
}