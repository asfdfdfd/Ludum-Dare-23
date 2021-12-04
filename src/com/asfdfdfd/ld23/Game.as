package com.asfdfdfd.ld23
{
	import Playtomic.Log;
	
	import com.asfdfdfd.ld23.world.GameWorld;
	import com.asfdfdfd.ld23.world.ShopWorld;
	import com.asfdfdfd.ld23.world.TitleScreenWorld;
	
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Game extends Engine
	{
		public static var GAME_WORLD:GameWorld;
		private var _shopWorld:ShopWorld;
		
		public function Game()
		{
			super(640, 480);
			
			Log.View(7724, "735c1e6e4c144063", "bf8fb12970814a1aa9fec8ca9f92b8", root.loaderInfo.loaderURL);
		
//			FP.console.enable();
			
			Log.Play();
			

			FP.world = new TitleScreenWorld();
		}
		
		override public function init():void
		{
		}
		
		public function get hero():Hero
		{
			return Game.GAME_WORLD.getInstance("Hero") as Hero;
		}
		
		override public function update():void
		{
			super.update();
			
			if (hero.health <= 0 && (FP.world is GameWorld))
			{
				FP.world = new ShopWorld();
			}
			
			if (Input.pressed(Key.SPACE) && (FP.world is ShopWorld))
			{
				Game.GAME_WORLD = new GameWorld();
				FP.world = Game.GAME_WORLD;
			}			
		}
	}
}