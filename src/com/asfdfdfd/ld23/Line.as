package com.asfdfdfd.ld23
{
	import flash.geom.Point;

	public class Line
	{
		private var _k:Number;
		private var _b:Number;
		
		public function Line(from:Point, to:Point)
		{
			_k = (to.y-from.y)/(to.x-from.x);
			_b = (to.x*from.y - from.x*to.y)/(to.x-from.x);
		}
		
		public function getX(y:Number):Number
		{
			return (y - _b) / _k;
		}
		
		public function getY(x:Number):Number
		{
			return _k * x + _b;
		}
	}
}