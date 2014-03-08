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
      
      public function MapGroupElement(param1:uint, param2:uint) {
         this._icons = new Array();
         super();
         this._mapWidth = param1;
         this._mapHeight = param2;
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
         var _loc8_:DisplayObject = null;
         var _loc9_:* = NaN;
         var _loc10_:* = NaN;
         var _loc11_:Object = null;
         var _loc1_:uint = this._icons.length * 5;
         var _loc2_:Point = new Point(0,0);
         if(_loc1_ < this._mapWidth * 3 / 4)
         {
            _loc1_ = this._mapWidth * 3 / 4;
         }
         if(_loc1_ < this._mapHeight * 3 / 4)
         {
            _loc1_ = this._mapHeight * 3 / 4;
         }
         var _loc3_:Number = Math.min(0.1 * this._icons.length,0.5);
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
         this._shape.graphics.drawCircle(_loc2_.x,_loc2_.y,_loc1_ + 10);
         this._shape.graphics.beginFill(16777215,0.3);
         this._shape.graphics.drawCircle(_loc2_.x,_loc2_.y,Math.min(this._mapWidth,this._mapHeight) / 3);
         super.addChildAt(this._shape,0);
         this.killAllTween();
         this._tween.push(new TweenMax(this._shape,_loc3_,{"alpha":1}));
         var _loc4_:* = false;
         if(!this._initialPos)
         {
            this._initialPos = new Array();
            _loc4_ = true;
         }
         var _loc5_:Number = Math.PI * 2 / this._icons.length;
         var _loc6_:Number = Math.PI / 2 + Math.PI / 4;
         var _loc7_:int = this._icons.length-1;
         while(_loc7_ >= 0)
         {
            _loc8_ = this._icons[_loc7_];
            if(_loc4_)
            {
               this._initialPos.push(
                  {
                     "icon":_loc8_,
                     "x":_loc8_.x,
                     "y":_loc8_.y
                  });
            }
            _loc9_ = Math.cos(_loc5_ * _loc7_ + _loc6_) * _loc1_ + _loc2_.x;
            _loc10_ = Math.sin(_loc5_ * _loc7_ + _loc6_) * _loc1_ + _loc2_.y;
            if(_loc8_.parent != this)
            {
               _loc11_ = this.getInitialPos(_loc8_);
               _loc9_ = _loc11_.x + _loc9_;
               _loc10_ = _loc11_.y + _loc10_;
            }
            this._tween.push(new TweenMax(_loc8_,_loc3_,
               {
                  "x":_loc9_,
                  "y":_loc10_
               }));
            _loc7_--;
         }
         this._open = true;
      }
      
      private function getInitialPos(param1:Object) : Object {
         var _loc2_:Object = null;
         for each (_loc2_ in this._initialPos)
         {
            if(_loc2_.icon == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function close() : void {
         var _loc1_:Object = null;
         graphics.clear();
         this.killAllTween();
         this._tween.push(new TweenMax(this._shape,0.2,
            {
               "alpha":0,
               "onCompleteListener":this.shapeTweenFinished
            }));
         for each (_loc1_ in this._initialPos)
         {
            this._tween.push(new TweenMax(_loc1_.icon,0.2,
               {
                  "x":_loc1_.x,
                  "y":_loc1_.y
               }));
         }
         this._open = false;
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject {
         super.addChild(param1);
         this._icons.push(param1);
         return param1;
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
         var _loc1_:TweenMax = null;
         for each (_loc1_ in this._tween)
         {
            _loc1_.clear();
            _loc1_.gc = true;
         }
         this._tween = new Array();
      }
      
      private function shapeTweenFinished(param1:TweenEvent) : void {
         this._shape.graphics.clear();
      }
      
      public function get icons() : Array {
         return this._icons;
      }
   }
}
