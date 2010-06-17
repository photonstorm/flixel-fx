package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import flash.events.*;
	
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import flash.text.TextField;
	
	import flash.ui.Mouse;
	
	import com.greensock.TweenMax;
	
	public class Paint extends Sprite
	{
		public var toeFluff:boardMC;
		public var hitZone:Sprite;
		
		//Paper vars
		protected var _paper:Bitmap;
		protected var _w:uint;
		protected var _h:uint;
		protected var _help:TextField;
		
		//Overlay vars
		protected var _overlay:Bitmap;
		protected var _oCT:ColorTransform;
		protected var _oRect:Rectangle;
		
		private var currentCrayon:MovieClip;
		private var currentColor:String;
		
		//Brush vars
		protected var _brush:Bitmap;
		protected var _bMtx:Matrix;
		protected var _bOld:Point;
		protected var _bLerp:Boolean;
		protected var _painting:Boolean;
		protected var _bHelper:Sprite;
		protected var mouseCursor:cursorMC;
		
		public function Paint()
		{
		}
		
		public function init(stageRef:Stage):void
		{
			hitZone = new Sprite;
			hitZone.graphics.beginFill(0xff0000, 0);
			hitZone.graphics.drawRect(0, 0, 414, 414);
			hitZone.graphics.endFill();
			hitZone.x = 70;
			hitZone.y = 60;
			
			_w = 0;
			_h = 0;
			_paper = null;
			_oRect = new Rectangle();
			_oCT = new ColorTransform();
			
			_bMtx = new Matrix();
			_bOld = null;
			_bLerp = true;
			_painting = false;
			_bHelper = new Sprite();
			
			createPaper();
			
			toeFluff = new boardMC();
			addChild(toeFluff);
			
			currentColor = "crayonRed";
			currentCrayon = toeFluff.crayonRed;
			
			createBrush(0xffd63535);
			
			mouseCursor = new cursorMC();
			mouseCursor.gotoAndStop(3);
			addChild(mouseCursor);
			
			toeFluff.crayonWhite.addEventListener(MouseEvent.CLICK, changeBrushColor);
			toeFluff.crayonBlack.addEventListener(MouseEvent.CLICK, changeBrushColor);
			toeFluff.crayonRed.addEventListener(MouseEvent.CLICK, changeBrushColor);
			toeFluff.crayonYellow.addEventListener(MouseEvent.CLICK, changeBrushColor);
			toeFluff.crayonPurple.addEventListener(MouseEvent.CLICK, changeBrushColor);
			toeFluff.crayonGrey.addEventListener(MouseEvent.CLICK, changeBrushColor);
			toeFluff.crayonBlue.addEventListener(MouseEvent.CLICK, changeBrushColor);
			toeFluff.crayonGreen.addEventListener(MouseEvent.CLICK, changeBrushColor);
			
			stageRef.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stageRef.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stageRef.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			//stageRef.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			//stageRef.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			//stageRef.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stageRef.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			stageRef.addEventListener(Event.DEACTIVATE, onFocusLost);
			//stageRef.addEventListener(Event.ACTIVATE, onFocus);
			
			addChild(hitZone);
			
			//That's it! All set
			addEventListener(Event.ENTER_FRAME, update);
			
			animateIn();
		}
		
		private function animateIn():void
		{
			TweenMax.to(toeFluff.crayonWhite, 0.25, { y: 490, yoyo: true, repeat: 1 } );
			TweenMax.to(toeFluff.crayonBlack, 0.25, { y: 490, yoyo: true, repeat: 1, delay: 0.1 } );
			TweenMax.to(toeFluff.crayonRed, 0.25, { y: 490, yoyo: true, repeat: 1, delay: 0.2 } );
			TweenMax.to(toeFluff.crayonYellow, 0.25, { y: 490, yoyo: true, repeat: 1, delay: 0.3 } );
			TweenMax.to(toeFluff.crayonPurple, 0.25, { y: 490, yoyo: true, repeat: 1, delay: 0.4 } );
			TweenMax.to(toeFluff.crayonGrey, 0.25, { y: 490, yoyo: true, repeat: 1, delay: 0.5 } );
			TweenMax.to(toeFluff.crayonBlue, 0.25, { y: 490, yoyo: true, repeat: 1, delay: 0.6 } );
			TweenMax.to(toeFluff.crayonGreen, 0.25, { y: 490, yoyo: true, repeat: 1, delay: 0.7 } );
		}
		
		private function changeBrushColor(event:MouseEvent):void
		{
			if (currentColor != event.currentTarget.name)
			{
				TweenMax.to(currentCrayon, 0.25, { y: 505 } );
						
				currentColor = event.currentTarget.name;
				
				switch (event.currentTarget.name)
				{
					case "crayonWhite":
						createBrush(0xffffffff);
						mouseCursor.gotoAndStop(1);
						currentCrayon = toeFluff.crayonWhite;
						_oCT.alphaMultiplier = 1;
						break;
						
					case "crayonBlack":
						createBrush(0xff000000);
						mouseCursor.gotoAndStop(2);
						currentCrayon = toeFluff.crayonBlack;
						break;
						
					case "crayonRed":
						createBrush(0xffd63535);
						mouseCursor.gotoAndStop(3);
						currentCrayon = toeFluff.crayonRed;
						break;
						
					case "crayonYellow":
						createBrush(0xfffdd444);
						mouseCursor.gotoAndStop(4);
						currentCrayon = toeFluff.crayonYellow;
						break;
						
					case "crayonPurple":
						createBrush(0xffb74b9c);
						mouseCursor.gotoAndStop(5);
						currentCrayon = toeFluff.crayonPurple;
						break;
						
					case "crayonGrey":
						createBrush(0xffd3d3d3);
						mouseCursor.gotoAndStop(6);
						currentCrayon = toeFluff.crayonGrey;
						break;
						
					case "crayonBlue":
						createBrush(0xff87d6ff);
						mouseCursor.gotoAndStop(7);
						currentCrayon = toeFluff.crayonBlue;
						break;
						
					case "crayonGreen":
						createBrush(0xff73ff3d);
						mouseCursor.gotoAndStop(8);
						currentCrayon = toeFluff.crayonGreen;
						break;
				}
				
				TweenMax.to(currentCrayon, 0.25, { y: 490 } );
				
			}
			
		}
		
		protected function update(event:Event):void
		{
			if (hitZone.hitTestPoint(mouseX, mouseY))
			{
				mouseCursor.visible = true;
				Mouse.hide();
			}
			else
			{
				mouseCursor.visible = false;
				Mouse.show();
			}
			
			_overlay.visible = _painting;
			_brush.visible = !_painting;
		}
		
		protected function createPaper():void
		{
			var oldPaper:Bitmap = _paper;
			
			_w = 414;
			_h = 414;
			
			_paper = new Bitmap(new BitmapData(_w, _h, true, 0xffffffff));
			
			_paper.x = 70;
			_paper.y = 60;
			
			addChild(_paper);
			
			var oldOverlay:Bitmap = _overlay;
			
			_overlay = new Bitmap(new BitmapData(_w, _h, true, 0));
			
			_overlay.x = 70;
			_overlay.y = 60;
			
			addChild(_overlay);
			
			_oRect.width = _w;
			_oRect.height = _h;
		}
		
		protected function createBrush(brushColor:uint):void
		{
			var s:uint = 12;
			var s2:uint = s / 2;
			
			_brush = new Bitmap(new BitmapData(s, s, true, 0));
			
			_bHelper.graphics.clear();
			_bHelper.graphics.beginFill(brushColor);
			_bHelper.graphics.drawRoundRect(0, 0, s, s, s2, s2);
			_bHelper.graphics.endFill();
			_brush.bitmapData.draw(_bHelper);
			
			_overlay.alpha = _oCT.alphaMultiplier;
		}
		
		protected function applyOverlay():void
		{
			_painting = false;
			
			_paper.bitmapData.draw(_overlay.bitmapData, null, _oCT);
			
			_overlay.bitmapData.fillRect(_oRect, 0);
		}
		
		protected function onMouseMove(event:MouseEvent=null):void
		{
			if (hitZone.hitTestPoint(mouseX, mouseY) == false)
			{
				applyOverlay();
				
				return;
			}
			
			if (event != null && event.buttonDown)
			{
				_painting = true;
			}
				
			_brush.x = mouseX - uint(_brush.width / 2) + 1;
			_brush.y = mouseY - uint(_brush.height / 2) + 1;
			
			mouseCursor.x = _brush.x;
			mouseCursor.y = _brush.y;
			
			if (_painting)
			{
				var i:uint;
				var numPoints:uint = 1;
				var xPoints:Array;
				var yPoints:Array;
				
				if (_bLerp && (_bOld != null))
				{
					var ratio:Number;
					var dx:Number = _brush.x - _bOld.x;
					var dy:Number = _brush.y - _bOld.y;
					var df:Number = (_brush.width + _brush.height) / 30;
					
					if (df < 1)
					{
						df = 1;
					}
					
					numPoints = Math.sqrt(dx * dx + dy * dy) / df;
					
					if (numPoints < 1)
					{
						numPoints = 1;
					}
					else
					{
						xPoints = new Array(numPoints);
						yPoints = new Array(numPoints);
						
						for (i = 0; i < numPoints; i++)
						{
							ratio = i / numPoints;
							
							xPoints[i] = _brush.x - ratio * dx;
							yPoints[i] = _brush.y - ratio * dy;
						}
					}
				}
				
				if (numPoints == 1)
				{
					xPoints = [ _brush.x ];
					yPoints = [ _brush.y ];
				}
				
				for (i = 0; i < numPoints; i++)
				{
					_bMtx.identity();
					_bMtx.translate(xPoints[i] - 70, yPoints[i] - 60);
					_overlay.bitmapData.draw(_brush.bitmapData, _bMtx);
				}
			}
			
			if (_bOld == null)
			{
				_bOld = new Point();
			}
			
			_bOld.x = _brush.x;
			_bOld.y = _brush.y;
		}
		
		protected function onMouseDown(event:MouseEvent):void
		{
			onMouseMove(event);
		}
		
		protected function onMouseUp(event:MouseEvent):void
		{
			_painting = false;

			applyOverlay();
		}
		
		protected function onKeyUp(event:KeyboardEvent):void
		{
			var refreshBrush:Boolean = false;
			
			switch(event.keyCode)
			{
				case 48:
					_oCT.alphaMultiplier = 1;
					refreshBrush = true;
					break;
					
				case 49:
					_oCT.alphaMultiplier = 0.1;
					refreshBrush = true;
					break;
					
				case 50:
					_oCT.alphaMultiplier = 0.2;
					refreshBrush = true;
					break;
					
				case 51:
					_oCT.alphaMultiplier = 0.3;
					refreshBrush = true;
					break;
					
				case 52:
					_oCT.alphaMultiplier = 0.4;
					refreshBrush = true;
					break;
					
				case 53:
					_oCT.alphaMultiplier = 0.5;
					refreshBrush = true;
					break;
					
				case 54:
					_oCT.alphaMultiplier = 0.6;
					refreshBrush = true;
					break;
					
				case 55:
					_oCT.alphaMultiplier = 0.7;
					refreshBrush = true;
					break;
					
				case 56:
					_oCT.alphaMultiplier = 0.8;
					refreshBrush = true;
					break;
					
				case 57:
					_oCT.alphaMultiplier = 0.9;
					refreshBrush = true;
					break;
			}
			
			if (refreshBrush)
			{
				_overlay.alpha = _oCT.alphaMultiplier;
				//_brush.alpha = _oCT.alphaMultiplier;
			}
		}
		
		protected function onFocusLost(event:Event=null):void
		{
			applyOverlay();
		}
	}
}
