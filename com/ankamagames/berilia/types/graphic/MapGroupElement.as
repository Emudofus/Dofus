package com.ankamagames.berilia.types.graphic
{
   import flash.display.Sprite;
   import flash.display.Shape;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.display.GradientType;
   import gs.TweenMax;
   import gs.events.TweenEvent;
   
   public class MapGroupElement extends Sprite
   {
      
      public function MapGroupElement(mapWidth:uint, mapHeight:uint) {
         this._icons = new Array();
         super();
         this._mapWidth = mapWidth;
         this._mapHeight = mapHeight;
         doubleClickEnabled = true;
      }
      
      private var _icons:Array;
      
      private var _initialPos:Array;
      
      private var _mapWidth:uint;
      
      private var _mapHeight:uint;
      
      private var _tween:Array;
      
      private var _shape:Shape;
      
      private var _open:Boolean;
      
      public function get opened() : Boolean {
         return this._open;
      }
      
      public function open() : void {
         var icon:DisplayObject = null;
         var destX:* = NaN;
         var destY:* = NaN;
         var pos:Object = null;
         var radius:uint = this._icons.length * 5;
         var center:Point = new Point(0,0);
         if(radius < this._mapWidth * 3 / 4)
         {
            radius = this._mapWidth * 3 / 4;
         }
         if(radius < this._mapHeight * 3 / 4)
         {
            radius = this._mapHeight * 3 / 4;
         }
         var tweenTime:Number = Math.min(0.1 * this._icons.length,0.5);
         if(!this._shape)
         {
            this._shape = new Shape();
         }
         else
         {
            this._shape.graphics.clear();
         }
         this._shape.alpha = 0;
         this._shape.graphics.beginGradientFill(GradientType.RADIAL,[16777215,16777215],[0,0.6],[0,127]);
         this._shape.graphics.drawCircle(center.x,center.y,radius + 10);
         this._shape.graphics.beginFill(16777215,0.3);
         this._shape.graphics.drawCircle(center.x,center.y,Math.min(this._mapWidth,this._mapHeight) / 3);
         super.addChildAt(this._shape,0);
         this.killAllTween();
         this._tween.push(new TweenMax(this._shape,tweenTime,{"alpha":1}));
         var saveInitialPosition:Boolean = false;
         if(!this._initialPos)
         {
            this._initialPos = new Array();
            saveInitialPosition = true;
         }
         var step:Number = Math.PI * 2 / this._icons.length;
         var offset:Number = Math.PI / 2 + Math.PI / 4;
         var i:int = this._icons.length - 1;
         while(i >= 0)
         {
            icon = this._icons[i];
            if(saveInitialPosition)
            {
               this._initialPos.push(
                  {
                     "icon":icon,
                     "x":icon.x,
                     "y":icon.y
                  });
            }
            destX = Math.cos(step * i + offset) * radius + center.x;
            destY = Math.sin(step * i + offset) * radius + center.y;
            if(icon.parent != this)
            {
               pos = this.getInitialPos(icon);
               destX = pos.x + destX;
               destY = pos.y + destY;
            }
            this._tween.push(new TweenMax(icon,tweenTime,
               {
                  "x":destX,
                  "y":destY
               }));
            i--;
         }
         this._open = true;
      }
      
      private function getInitialPos(pIcon:Object) : Object {
         var iconPos:Object = null;
         for each(iconPos in this._initialPos)
         {
            if(iconPos.icon == pIcon)
            {
               return iconPos;
            }
         }
         return null;
      }
      
      public function close() : void {
         var icon:Object = null;
         graphics.clear();
         this.killAllTween();
         this._tween.push(new TweenMax(this._shape,0.2,
            {
               "alpha":0,
               "onCompleteListener":this.shapeTweenFinished
            }));
         for each(icon in this._initialPos)
         {
            this._tween.push(new TweenMax(icon.icon,0.2,
               {
                  "x":icon.x,
                  "y":icon.y
               }));
         }
         this._open = false;
      }
      
      override public function addChild(child:DisplayObject) : DisplayObject {
         super.addChild(child);
         this._icons.push(child);
         return child;
      }
      
      public function remove() : void {
         while(numChildren)
         {
            removeChildAt(0);
         }
         this._icons = null;
         this.killAllTween();
      }
      
      private function killAllTween() : void {
         var t:TweenMax = null;
         for each(t in this._tween)
         {
            t.clear();
            t.gc = true;
         }
         this._tween = new Array();
      }
      
      private function shapeTweenFinished(e:TweenEvent) : void {
         this._shape.graphics.clear();
      }
      
      public function get icons() : Array {
         return this._icons;
      }
   }
}
