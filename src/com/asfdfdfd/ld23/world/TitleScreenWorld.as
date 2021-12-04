package com.asfdfdfd.ld23.world
{
	import com.asfdfdfd.ld23.Game;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	
	public class TitleScreenWorld extends World
	{
		[Embed(source='../../../../../assets/TitleScreen.png')] private const SCREEN:Class;
		
		private var image:Image = new Image(SCREEN);
		
		public function TitleScreenWorld()
		{
			super();
		}
		
		override public function update():void
		{
			super.update();
			
			if (Input.mousePressed)
			{
				Game.GAME_WORLD = new GameWorld();
				FP.world = Game.GAME_WORLD;				
			}
			
			Draw.graphic(image, 0, 0);
		}
	}
}