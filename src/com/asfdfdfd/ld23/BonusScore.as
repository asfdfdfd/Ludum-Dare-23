package com.asfdfdfd.ld23
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Image;
	
	public class BonusScore extends Entity
	{
		[Embed(source='../../../../assets/BonusScore.png')] private const BONUS_SCORE:Class;
		
		[Embed(source='../../../../assets/HeroCoinPickup.mp3')] private static const BONUS_SCORE_SOUND:Class;
		
		private static const BONUS_FALL_SPEED:Number = 200; 
		
		private static const COST:Number = 100;
		
		private var _pickup:Sfx = new Sfx(BonusScore.BONUS_SCORE_SOUND);
		
		public function BonusScore(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			graphic = new Image(BONUS_SCORE);
			
			super(x, y, graphic);
			
			setHitbox(16, 16);
			
			type = "BonusScore";
		}
		
		override public function update():void
		{
			if (collide("Hero", x, y))
			{
				FP.world.remove(this);
				_pickup.play();
				
				Hero.SCORES += BonusScore.COST;
				Hero.SCORES_SESSION += BonusScore.COST;				
			}
			
			moveBy(0, BonusScore.BONUS_FALL_SPEED * FP.elapsed, "LandscapeBlock");
		}
	}
}