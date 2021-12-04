package com.asfdfdfd.ld23
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Image;
	
	public class EnemyBomb extends Entity
	{
		[Embed(source='../../../../assets/EnemyBomb.png')] private const ENEMY_BOMB:Class;
		
		[Embed(source='../../../../assets/EnemyBombExplosion.mp3')] private static const EXPLOSION_SOUND:Class;
		
		private var _explosionSfx:Sfx = new Sfx(EnemyBomb.EXPLOSION_SOUND);
		
		public static const MAX_HEALTH:int = 3;
		
		private static const COST:int = 20;
		
		private var _health:Number = MAX_HEALTH;
		
		public function EnemyBomb(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			graphic = new Image(ENEMY_BOMB);
			
			super(x, y, graphic);
			
			setHitbox(16, 16);
			
			type = "EnemyBomb";
		}
		
		override public function update():void
		{
			if (!onCamera)
			{
				FP.world.remove(this);
			}
			
			y += 100 * FP.elapsed;
						
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
			
			FP.world.add(new EnemyBombExplosion(x, y));			
		}
		
		public function kill():void
		{
			explode();
			
			FP.world.add(new BonusScore(x, y));
			
			Hero.SCORES += EnemyBomb.COST;
			Hero.SCORES_SESSION += EnemyBomb.COST;
		}
	}
}