package com.asfdfdfd.ld23
{
	import flash.geom.Rectangle;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.motion.LinearMotion;
	
	public class Bullet extends Entity
	{
		[Embed(source='../../../../assets/Bullet.png')] private const BULLET:Class;
		
		private var _motion:LinearMotion = new LinearMotion();
		
		public function Bullet(x:Number=0, y:Number=0, toX:Number=0, toY:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			graphic = new Image(BULLET);
			
			super(x, y, graphic);
			
			setHitbox(4, 4);
			
			_motion = new LinearMotion();
			_motion.setMotionSpeed(x, y, toX, toY, 800);
			
			addTween(_motion, true);
			
			type = "Bullet";
		}
		
		override public function update():void
		{
			x = _motion.x;
			y = _motion.y;
			
			if (!onCamera)// !new Rectangle(0, 0, FP.width, FP.height).contains(x, y))
			{
				FP.world.remove(this);
				return;
			}
			
			var bomb:EnemyBomb = collide("EnemyBomb", x, y) as EnemyBomb;
			
			if (bomb)
			{
				bomb.hit();
				
				FP.world.remove(this);
			}	
			
			var rocket:EnemyBallisticMissle = collide("EnemyBallisticRocket", x, y) as EnemyBallisticMissle;
			
			if (rocket)
			{
				rocket.hit();
				
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