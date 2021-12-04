package com.asfdfdfd.ld23.world
{
	import Playtomic.Log;
	
	import com.asfdfdfd.ld23.EnemyBomber;
	import com.asfdfdfd.ld23.EnemyBomberFactory;
	import com.asfdfdfd.ld23.EnemyDropPlane;
	import com.asfdfdfd.ld23.EnemyDropPlaneFactory;
	import com.asfdfdfd.ld23.EnemyRocketShip;
	import com.asfdfdfd.ld23.Hero;
	import com.asfdfdfd.ld23.LandscapeBlock;
	import com.asfdfdfd.ld23.LifeBar;
	import com.asfdfdfd.ld23.WaterBlock;
	
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.utils.Draw;
	
	public class GameWorld extends World
	{
		private var _enemyBomberFactory:EnemyBomberFactory;
		private var _enemyDropPlaneFactory:EnemyDropPlaneFactory;
		private var _rocketShip:EnemyRocketShip;
		
		private var _currentSection:int = 0;
		
		public function GameWorld()
		{
			super();
				
			FP.screen.color = 0x5D7AA2;
			
			for (var w:int = 288; w <= 576; w += 16)
			{
				for (var h:int = 364; h <= 480; h += 16)
				{
					add(new LandscapeBlock(w, h));
				}
			}
			
			add(new LifeBar());
			add(new Hero(300-32, 364-32));
			
			EnemyBomber.TIME_BETWEEN_BOMBING = 2;
			EnemyDropPlane.MAX_TROOPERS_PER_DROP = 1;
			EnemyRocketShip.TIME_BETWEEN_BOMBING = 10;
			EnemyDropPlaneFactory.TIME_BETWEEN_DROP_PLANES = 5;		
			
			for (w = 0; w <= 640; w += 32)
			{
				for (h = 364 + 32 * 3; h <= 480; h += 32)
				{
					add(new WaterBlock(w, h));
				}
			}
		}
		
		override public function update():void
		{
			super.update();
			
			if (Hero.SCORES_SESSION == -1 && _currentSection == 0)
			{
				startSection1();
			}
			else if (Hero.SCORES_SESSION >= 120 && _currentSection == 1)
			{
				startSection2();
			}
			else if (Hero.SCORES_SESSION >= 240 && _currentSection == 2)
			{
				startSection3();
			}	
			else if (Hero.SCORES_SESSION >= 490 && _currentSection == 3)
			{
				startSection4();
			}
			else if (Hero.SCORES_SESSION >= 1000 && _currentSection == 4)
			{
				startSection5();
			}	
			else if (Hero.SCORES_SESSION >= 2000 && _currentSection == 5)
			{
				startSection6();
			}	
			else if (Hero.SCORES_SESSION >= 2300 && _currentSection == 6)
			{
				startSection7();
			}	
			else if (Hero.SCORES_SESSION >= 3700 && _currentSection == 7)
			{
				startSection8();
			}		
			else if (Hero.SCORES_SESSION >= 5000 && _currentSection == 8)
			{
				startSection9();
			}	
			else if (Hero.SCORES_SESSION >= 490 && _currentSection == 9)
			{
				startSection10();
			}	
			
			Log.ForceSend();
		}
		
		override public function render():void
		{
			super.render();
			
			Draw.text("Scores: " + Hero.SCORES.toString(), 0, 30);
			
//			Draw.linePlus(0, 0, 100, 100, 0xFF0000, 1, 5);
//			Draw.linePlus(0, 0, 100, 100, 0x00FF00, 1, 3);
		}
		
		public function reset():void
		{
			_currentSection = 0;
		}
		
		private function startSection1():void
		{
			Log.CustomMetric("Section1");
			
			_currentSection = 1;
			
			Hero.SCORES_SESSION = 0;
			
			if (!_enemyBomberFactory)
			{
				_enemyBomberFactory = new EnemyBomberFactory();
				add(_enemyBomberFactory);
			}
		}
		
		private function startSection2():void
		{
			Log.CustomMetric("Section2");
			
			_currentSection = 2;

			_enemyBomberFactory.TIME_BETWEEN_BOMBERS = 3;
		}
		
		private function startSection3():void
		{
			Log.CustomMetric("Section3");
			
			_currentSection = 3;
			
			if (!_enemyDropPlaneFactory)
			{
				_enemyDropPlaneFactory = new EnemyDropPlaneFactory();
				add(_enemyDropPlaneFactory);
			}
		}	
		
		private function startSection4():void
		{
			Log.CustomMetric("Section4");
			
			_currentSection = 4;
			
			EnemyBomber.TIME_BETWEEN_BOMBING = 1.4;
		}		
		
		private function startSection5():void
		{
			Log.CustomMetric("Section5");
			
			_currentSection = 5;
			
			EnemyDropPlane.MAX_TROOPERS_PER_DROP = 2;
		}
		
		private function startSection6():void
		{
			Log.CustomMetric("Section6");
			
			_currentSection = 6;
			
			EnemyDropPlaneFactory.TIME_BETWEEN_DROP_PLANES = 4;
			EnemyBomber.TIME_BETWEEN_BOMBING = 1.6;
		}	
		
		private function startSection7():void
		{
			Log.CustomMetric("Section7");
			
			_currentSection = 7;
			
			if (!_rocketShip)
			{
				_rocketShip = new EnemyRocketShip(-16-16-16-16, 364);
				add(_rocketShip);
			}
		}		
		
		private function startSection8():void
		{
			Log.CustomMetric("Section8");
			
			_currentSection = 8;
			
			EnemyDropPlane.MAX_TROOPERS_PER_DROP = 3;
		}		
		
		private function startSection9():void
		{
			Log.CustomMetric("Section9");
			
			_currentSection = 9;
			
			EnemyBomber.TIME_BETWEEN_BOMBING = 1.3;
			EnemyRocketShip.TIME_BETWEEN_BOMBING = 5;
		}
		
		private function startSection10():void
		{
			Log.CustomMetric("Section10");
			
			_currentSection = 10;
			
			EnemyDropPlaneFactory.TIME_BETWEEN_DROP_PLANES = 3;
		}		
	}
}