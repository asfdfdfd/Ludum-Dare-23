package com.asfdfdfd.ld23
{
	import flash.geom.Rectangle;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.motion.LinearMotion;
	
	public class EnemyBullet extends Entity
	{
		[Embed(source='../../../../assets/Bullet.png')] private const BULLET:Class;
		
		private var _motion:LinearMotion = new LinearMotion();
		
		private static const BULLET_SPEED:Number = 100;
		private static const BULLET_DAMAGE:Number = 1
		
		public function EnemyBullet(x:Number=0, y:Number=0, toX:Number=0, toY:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			graphic = new Image(BULLET);
			
			super(x, y, graphic);
			
			setHitbox(4, 4);
			
			_motion = new LinearMotion();
			_motion.setMotionSpeed(x, y, toX, toY, EnemyBullet.BULLET_SPEED);
			
			addTween(_motion, true);
		}
		
		override public function update():void
		{
			x = _motion.x;
			y = _motion.y;
			
			if (!onCamera)
			{
				FP.world.remove(this);
				return;
			}
			
			var hero:Hero = collide("Hero", x, y) as Hero;
			
			if (hero)
			{
				hero.hit(EnemyBullet.BULLET_DAMAGE);
				
				FP.world.remove(this);
			}	

			var landscape:LandscapeBlock = collide("LandscapeBlock", x, y) as LandscapeBlock;
			
			if (landscape)
			{
				FP.world.remove(this);
			}
		}
	}
}