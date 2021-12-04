package com.asfdfdfd.ld23
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.motion.CubicMotion;
	import net.flashpunk.utils.Ease;
	
	public class EnemyBallisticMissle extends Entity
	{
		[Embed(source='../../../../assets/EnemyBomb.png')] private const ENEMY_BOMB:Class;
		
		[Embed(source='../../../../assets/EnemyBallisticMissleExplosion.mp3')] private static const EXPLOSION_SOUND:Class;
		
		private var _explosionSfx:Sfx = new Sfx(EnemyBallisticMissle.EXPLOSION_SOUND);
		
		public static const MAX_HEALTH:int = 5;
		
		private var _health:Number = MAX_HEALTH;
		
		private var motion:CubicMotion;
		
		private static const COST:int = 30;
		
		public function EnemyBallisticMissle(x:Number=0, y:Number=0, toX:Number=0, toY:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			graphic = new Image(ENEMY_BOMB);
			
			super(x, y, graphic);
			
			setHitbox(16, 16);
			
			type = "EnemyBallisticRocket";
			
			var lengthX:Number = Math.abs(toX - x);
			var lengthY:Number = Math.abs(toY - y);
			
			motion = new CubicMotion();
			motion.setMotion(x, y, (lengthX / 2), 100, toX, toY, toX + 100, 500, (toX - x) / 100);
			
			this.addTween(motion, true);			
		}
		
		override public function update():void
		{
			if (!onCamera)
			{
				FP.world.remove(this);
			}
			
			x = motion.x;
			y = motion.y;
						
			var block:LandscapeBlock = collide("LandscapeBlock", x, y) as LandscapeBlock;
			
			if (block)
			{
				explode();
				FP.world.remove(block);
			}
		}
		
		public function hit(value:Number = 1):void
		{
			_health -= value;
			
			if (_health <= 0)
			{
				kill();
			}
		}
		
		public function explode():void
		{
			FP.world.remove(this);
			_explosionSfx.play();
			FP.world.add(new EnemyBallisticMissleExplosion(x, y));
		}
		
		public function kill():void
		{
			
			explode();
			
			
			FP.world.add(new BonusScore(x, y));
			
			
			Hero.SCORES += EnemyBallisticMissle.COST;
			Hero.SCORES_SESSION += EnemyBallisticMissle.COST;			
		}
	}
}