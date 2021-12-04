package com.asfdfdfd.ld23.world
{
	import Playtomic.Leaderboards;
	import Playtomic.PlayerScore;
	
	import com.asfdfdfd.ld23.Game;
	import com.asfdfdfd.ld23.Hero;
	import com.asfdfdfd.ld23.ShopUpgrade;
	
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;
	
	public class ShopWorld extends World
	{
		[Embed(source='assets/UpgradeBullet01.png')] private const UPGRADE_BULLET_01:Class;
		[Embed(source='../../../../../assets/UpgradeBullet02.png')] private const UPGRADE_BULLET_02:Class;
		[Embed(source='../../../../../assets/UpgradeBullet03.png')] private const UPGRADE_BULLET_03:Class;
		
		[Embed(source='../../../../../assets/UpgradeHealth01.png')] private const UPGRADE_HEALTH_01:Class;
		[Embed(source='../../../../../assets/UpgradeHealth02.png')] private const UPGRADE_HEALTH_02:Class;
		[Embed(source='../../../../../assets/UpgradeHealth03.png')] private const UPGRADE_HEALTH_03:Class;
		
		[Embed(source='../../../../../assets/UpgradeJump01.png')] private const UPGRADE_JUMP_01:Class;
		[Embed(source='../../../../../assets/UpgradeJump02.png')] private const UPGRADE_JUMP_02:Class;
		[Embed(source='../../../../../assets/UpgradeJump03.png')] private const UPGRADE_JUMP_03:Class;
		
		[Embed(source='../../../../../assets/UpgradeLaser01.png')] private const UPGRADE_LASER_01:Class;
		[Embed(source='../../../../../assets/UpgradeLaser02.png')] private const UPGRADE_LASER_02:Class;
		[Embed(source='../../../../../assets/UpgradeLaser03.png')] private const UPGRADE_LASER_03:Class;
		
		[Embed(source='../../../../../assets/UpgradeRocket01.png')] private const UPGRADE_ROCKET_01:Class;
		[Embed(source='../../../../../assets/UpgradeRocket02.png')] private const UPGRADE_ROCKET_02:Class;
		[Embed(source='../../../../../assets/UpgradeRocket03.png')] private const UPGRADE_ROCKET_03:Class;
		
		[Embed(source='../../../../../assets/UpgradeShield01.png')] private const UPGRADE_SHIELD_01:Class;
		[Embed(source='../../../../../assets/UpgradeShield02.png')] private const UPGRADE_SHIELD_02:Class;
		[Embed(source='../../../../../assets/UpgradeShield03.png')] private const UPGRADE_SHIELD_03:Class;
		
		public function ShopWorld()
		{
			super();
		}
		
		public override function begin():void
		{
			super.begin();
			
			Hero.SCORES_SESSION = -1;
			
//			sendCurrentScores();
			createUpgradeEntites();
		}
		
		private var hero:Hero;
		
		private var upgradeBullet01:ShopUpgrade;
		private var upgradeBullet02:ShopUpgrade;
		private var upgradeBullet03:ShopUpgrade;
		
		private var upgradeHealth01:ShopUpgrade;
		private var upgradeHealth02:ShopUpgrade;
		private var upgradeHealth03:ShopUpgrade;
		
		private var upgradeJump01:ShopUpgrade;
		private var upgradeJump02:ShopUpgrade;
		private var upgradeJump03:ShopUpgrade;
		
		private var upgradeLaser01:ShopUpgrade;
		private var upgradeLaser02:ShopUpgrade;
		private var upgradeLaser03:ShopUpgrade;
		
		private var upgradeRocket01:ShopUpgrade;
		private var upgradeRocket02:ShopUpgrade;
		private var upgradeRocket03:ShopUpgrade;
		
		private var upgradeShield01:ShopUpgrade;
		private var upgradeShield02:ShopUpgrade;
		private var upgradeShield03:ShopUpgrade;		
		
		private function createUpgradeEntites():void
		{
			hero = (FP.engine as Game).hero;
			
			var bulletLevel01Avail:Boolean = hero.BulletLevel == 0 && Hero.SCORES >= 1000;
			var bulletLevel02Avail:Boolean = hero.BulletLevel == 1 && Hero.SCORES >= 5000;
			var bulletLevel03Avail:Boolean = hero.BulletLevel == 2 && Hero.SCORES >= 10000;
			
			upgradeBullet01 = new ShopUpgrade(0, 0, onUpgradeBullet01Click, new Image(UPGRADE_BULLET_01), bulletLevel01Avail);
			upgradeBullet02 = new ShopUpgrade(130, 0, onUpgradeBullet02Click, new Image(UPGRADE_BULLET_02), bulletLevel02Avail);
			upgradeBullet03 = new ShopUpgrade(260, 0, onUpgradeBullet03Click, new Image(UPGRADE_BULLET_03), bulletLevel03Avail);
			
			var healthLevel01Avail:Boolean = hero.HealthLevel == 0 && Hero.SCORES >= 1000;
			var healthLevel02Avail:Boolean = hero.HealthLevel == 1 && Hero.SCORES >= 5000;
			var healthLevel03Avail:Boolean = hero.HealthLevel == 2 && Hero.SCORES >= 10000;
			
			upgradeHealth01 = new ShopUpgrade(0, 70, onUpgradeHealth01Click, new Image(UPGRADE_HEALTH_01), healthLevel01Avail);
			upgradeHealth02 = new ShopUpgrade(130, 70, onUpgradeHealth02Click, new Image(UPGRADE_HEALTH_02), healthLevel02Avail);
			upgradeHealth03 = new ShopUpgrade(260, 70, onUpgradeHealth03Click, new Image(UPGRADE_HEALTH_03), healthLevel03Avail);
			
			var jumpLevel01Avail:Boolean = hero.JumpLevel == 0 && Hero.SCORES >= 1000;
			var jumpLevel02Avail:Boolean = hero.JumpLevel == 1 && Hero.SCORES >= 5000;
			var jumpLevel03Avail:Boolean = hero.JumpLevel == 2 && Hero.SCORES >= 10000;
			
			upgradeJump01 = new ShopUpgrade(0, 140, onUpgradeJump01Click, new Image(UPGRADE_JUMP_01), jumpLevel01Avail);
			upgradeJump02 = new ShopUpgrade(130, 140, onUpgradeJump02Click, new Image(UPGRADE_JUMP_02), jumpLevel02Avail);
			upgradeJump03 = new ShopUpgrade(260, 140, onUpgradeJump03Click, new Image(UPGRADE_JUMP_03), jumpLevel03Avail);
			
//			var laserLevel01Avail:Boolean = hero.LaserLevel == 0;
//			var laserLevel02Avail:Boolean = hero.LaserLevel == 1;
//			var laserLevel03Avail:Boolean = hero.LaserLevel == 2;
//			
//			upgradeLaser01 = new ShopUpgrade(0, 210, onUpgradeLaser01Click, new Image(UPGRADE_LASER_01), laserLevel01Avail);
//			upgradeLaser02 = new ShopUpgrade(130, 210, onUpgradeLaser02Click, new Image(UPGRADE_LASER_02), laserLevel02Avail);
//			upgradeLaser03 = new ShopUpgrade(260, 210, onUpgradeLaser03Click, new Image(UPGRADE_LASER_03), laserLevel03Avail);
			
//			var rocketLevel01Avail:Boolean = hero.RocketLevel == 0;
//			var rocketLevel02Avail:Boolean = hero.RocketLevel == 1;
//			var rocketLevel03Avail:Boolean = hero.RocketLevel == 2;
//			
//			upgradeRocket01 = new ShopUpgrade(0, 280, onUpgradeRocket01Click, new Image(UPGRADE_ROCKET_01), rocketLevel01Avail);
//			upgradeRocket02 = new ShopUpgrade(130, 280, onUpgradeRocket02Click, new Image(UPGRADE_ROCKET_02), rocketLevel02Avail);
//			upgradeRocket03 = new ShopUpgrade(260, 280, onUpgradeRocket03Click, new Image(UPGRADE_ROCKET_03), rocketLevel03Avail);
//			
//			var shieldLevel01Avail:Boolean = hero.ShieldLevel == 0;
//			var shieldLevel02Avail:Boolean = hero.ShieldLevel == 1;
//			var shieldLevel03Avail:Boolean = hero.ShieldLevel == 2;
//			
//			upgradeShield01 = new ShopUpgrade(0, 350, onUpgradeShield01Click, new Image(UPGRADE_SHIELD_01), shieldLevel01Avail);
//			upgradeShield02 = new ShopUpgrade(130, 350, onUpgradeShield02Click, new Image(UPGRADE_SHIELD_02), shieldLevel02Avail);
//			upgradeShield03 = new ShopUpgrade(260, 350, onUpgradeShield03Click, new Image(UPGRADE_SHIELD_03), shieldLevel03Avail);
		}
		
		private function onUpgradeBullet01Click():void
		{
			hero.BulletLevel = 1;
			
			Hero.SCORES -= 1000;
			
			upgradeBullet01.available = false;
			upgradeBullet02.available = true && Hero.SCORES >= 5000;
			upgradeBullet03.available = false;
			
			fixOthers();
		}
		
		private function onUpgradeBullet02Click():void
		{
			hero.BulletLevel = 2;
			
			Hero.SCORES -= 5000;
			
			upgradeBullet01.available = false;
			upgradeBullet02.available = false;
			upgradeBullet03.available = true && Hero.SCORES >= 10000;
			
			fixOthers();
		}
		
		private function onUpgradeBullet03Click():void
		{
			hero.BulletLevel = 3;
			
			Hero.SCORES -= 10000;
			
			upgradeBullet01.available = false;
			upgradeBullet02.available = false;
			upgradeBullet03.available = false;		

			fixOthers();
		}
		
		private function onUpgradeHealth01Click():void
		{
			hero.HealthLevel = 1;	
			
			Hero.SCORES -= 1000;
			
			upgradeHealth01.available = false;
			upgradeHealth02.available = true && Hero.SCORES >= 5000;
			upgradeHealth03.available = false;
			
			fixOthers();
		}
		
		private function onUpgradeHealth02Click():void
		{
			hero.HealthLevel = 2;
			
			Hero.SCORES -= 5000;
			
			upgradeHealth01.available = false;
			upgradeHealth02.available = false;
			upgradeHealth03.available = true && Hero.SCORES >= 10000;	
			
			fixOthers();
		}
		
		private function onUpgradeHealth03Click():void
		{
			hero.HealthLevel = 3;
			
			Hero.SCORES -= 10000;
			
			upgradeHealth01.available = false;
			upgradeHealth02.available = false;
			upgradeHealth03.available = false;	
			
			fixOthers();
		}	
		
		private function onUpgradeJump01Click():void
		{
			hero.JumpLevel = 1;	
			
			Hero.SCORES -= 1000;
			
			upgradeJump01.available = false;
			upgradeJump02.available = true && Hero.SCORES >= 5000;;
			upgradeJump03.available = false;
			
			fixOthers();
		}
		
		private function onUpgradeJump02Click():void
		{
			hero.JumpLevel = 2;
			
			Hero.SCORES -= 5000;
			
			upgradeJump01.available = false;
			upgradeJump02.available = false;
			upgradeJump03.available = true && Hero.SCORES >= 10000;
			
			fixOthers();
		}
		
		private function onUpgradeJump03Click():void
		{
			hero.JumpLevel = 3;
			
			Hero.SCORES -= 10000;
			
			upgradeJump01.available = false;
			upgradeJump02.available = false;
			upgradeJump03.available = false;
			
			fixOthers();
		}		
		
		private function fixOthers():void
		{
			upgradeBullet01.available = hero.BulletLevel == 0 && Hero.SCORES >= 1000;
			upgradeBullet02.available = hero.BulletLevel == 1 && Hero.SCORES >= 5000;
			upgradeBullet03.available = hero.BulletLevel == 2 && Hero.SCORES >= 10000;;

			upgradeHealth01.available = hero.HealthLevel == 0 && Hero.SCORES >= 1000;
			upgradeHealth02.available = hero.HealthLevel == 1 && Hero.SCORES >= 5000;
			upgradeHealth03.available = hero.HealthLevel == 2 && Hero.SCORES >= 10000;

			upgradeJump01.available = hero.JumpLevel == 0 && Hero.SCORES >= 1000;
			upgradeJump02.available = hero.JumpLevel == 1 && Hero.SCORES >= 5000;
			upgradeJump03.available = hero.JumpLevel == 2 && Hero.SCORES >= 10000;			
		}
		
//		private function onUpgradeLaser01Click():void
//		{
//			hero.LaserLevel = 1;	
//			
//			upgradeLaser01.available = false;
//			upgradeLaser02.available = true;
//			upgradeLaser03.available = false;
//		}
//		
//		private function onUpgradeLaser02Click():void
//		{
//			hero.LaserLevel = 2;
//			
//			upgradeLaser01.available = false;
//			upgradeLaser02.available = false;
//			upgradeLaser03.available = true;			
//		}
//		
//		private function onUpgradeLaser03Click():void
//		{
//			hero.LaserLevel = 3;
//			
//			upgradeLaser01.available = false;
//			upgradeLaser02.available = false;
//			upgradeLaser03.available = false;			
//		}
//		
//		private function onUpgradeRocket01Click():void
//		{
//			hero.RocketLevel = 1;	
//			
//			upgradeRocket01.available = false;
//			upgradeRocket02.available = true;
//			upgradeRocket03.available = false;
//		}
//		
//		private function onUpgradeRocket02Click():void
//		{
//			hero.RocketLevel = 2;
//			
//			upgradeRocket01.available = false;
//			upgradeRocket02.available = false;
//			upgradeRocket03.available = true;			
//		}
//		
//		private function onUpgradeRocket03Click():void
//		{
//			hero.RocketLevel = 3;
//			
//			upgradeRocket01.available = false;
//			upgradeRocket02.available = false;
//			upgradeRocket03.available = false;			
//		}		
		
//		private function onUpgradeShield01Click():void
//		{
//			hero.ShieldLevel = 1;	
//			
//			upgradeShield01.available = false;
//			upgradeShield02.available = true;
//			upgradeShield03.available = false;
//		}
//		
//		private function onUpgradeShield02Click():void
//		{
//			hero.ShieldLevel = 2;
//			
//			upgradeShield01.available = false;
//			upgradeShield02.available = false;
//			upgradeShield03.available = true;			
//		}
//		
//		private function onUpgradeShield03Click():void
//		{
//			hero.ShieldLevel = 3;
//			
//			upgradeShield01.available = false;
//			upgradeShield02.available = false;
//			upgradeShield03.available = false;			
//		}
//		
		private function sendCurrentScores():void
		{
			var levelScore:PlayerScore = new PlayerScore(Hero.NAME, Hero.SCORES);
			Leaderboards.SaveAndList(levelScore, "level", scoresReceived);			
		}
		
		private function scoresReceived(scores:Array, numscores:int, response:Object):void
		{
			
		}
		
		override public function render():void
		{
			super.render();
			
			Draw.text("Press SPACE to play again.", 0, 450);
			Draw.text("Your total scores: " + Hero.SCORES, 0, 220);
			
			hero = (FP.engine as Game).hero;
			
			var scores1:int;
			
			if (hero.BulletLevel == 0) scores1 = 1000;
			if (hero.BulletLevel == 1) scores1 = 5000;
			if (hero.BulletLevel == 2) scores1 = 10000;
			
			Draw.text("Price: " + scores1 + " scores", 400, 0);
			
			var scores2:int;
			
			if (hero.HealthLevel == 0) scores2 = 1000;
			if (hero.HealthLevel == 1) scores2 = 5000;
			if (hero.HealthLevel == 2) scores2 = 10000;
			
			Draw.text("Price: " + scores2 + " scores", 400, 70);
			
			var scores3:int;
			
			if (hero.JumpLevel == 0) scores3 = 1000;
			if (hero.JumpLevel == 1) scores3 = 5000;
			if (hero.JumpLevel == 2) scores3 = 10000;
			
			Draw.text("Price: " + scores3 + " scores", 400, 140);
		}
	}
}