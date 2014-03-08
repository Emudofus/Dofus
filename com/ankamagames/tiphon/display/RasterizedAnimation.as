package com.ankamagames.tiphon.display
{
   import flash.utils.Dictionary;
   import flash.display.MovieClip;
   import flash.display.Bitmap;
   
   public class RasterizedAnimation extends TiphonAnimation
   {
      
      public function RasterizedAnimation(param1:MovieClip, param2:String) {
         super();
         this._target = param1;
         this._targetName = "[" + this._target.scaleX + "," + this._target.scaleY + "]" + param1.toString() + " [" + param2 + "]";
         this._totalFrames = this._target.totalFrames;
         var _loc3_:RasterizedFrameList = FRAMES[this._targetName];
         if(_loc3_)
         {
            _loc3_.death = 0;
            _loc3_.life = _loc3_.life + 2;
            if(_loc3_.life > _loc3_.maxLife)
            {
               _loc3_.life = _loc3_.maxLife;
            }
         }
         else
         {
            FRAMES[this._targetName] = new RasterizedFrameList(this._targetName,5);
         }
      }
      
      public static var FRAMES:Dictionary = new Dictionary(false);
      
      public static function countFrames() : Object {
         var _loc3_:RasterizedFrameList = null;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         for each (_loc3_ in FRAMES)
         {
            _loc1_++;
            _loc4_ = _loc3_.frameList.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               if(_loc3_.frameList[_loc5_])
               {
                  _loc2_++;
               }
               _loc5_++;
            }
         }
         return 
            {
               "animations":_loc1_,
               "frames":_loc2_
            };
      }
      
      public static function optimize(param1:int=1) : void {
         var _loc2_:RasterizedFrameList = null;
         for each (_loc2_ in FRAMES)
         {
            _loc2_.death = _loc2_.death + param1;
            _loc2_.life = _loc2_.life - _loc2_.death;
            if(_loc2_.life < 1)
            {
               delete FRAMES[[_loc2_.key]];
            }
         }
      }
      
      protected var _target:MovieClip;
      
      private var _targetName:String;
      
      private var _bitmap:Bitmap;
      
      private var _smoothing:Boolean;
      
      protected var _totalFrames:uint;
      
      private var _currentIndex:int = -1;
      
      override public function get totalFrames() : int {
         return this._totalFrames;
      }
      
      override public function get currentFrame() : int {
         return this._currentIndex + 1;
      }
      
      public function get smoothing() : Boolean {
         return this._smoothing;
      }
      
      public function set smoothing(param1:Boolean) : void {
         this._smoothing = param1;
         if(this._bitmap)
         {
            this._bitmap.smoothing = param1;
         }
      }
      
      override public function gotoAndStop(param1:Object, param2:String=null) : void {
         var _loc3_:uint = param1 as uint;
         if(_loc3_ > 0)
         {
            _loc3_--;
         }
         this.displayFrame(_loc3_ % this._totalFrames);
      }
      
      override public function gotoAndPlay(param1:Object, param2:String=null) : void {
         this.gotoAndStop(param1,param2);
         this.play();
      }
      
      override public function play() : void {
      }
      
      override public function stop() : void {
      }
      
      override public function nextFrame() : void {
         this.displayFrame((this._currentIndex + 1) % this._totalFrames);
      }
      
      override public function prevFrame() : void {
         this.displayFrame(this._currentIndex > 0?this._currentIndex-1:this._totalFrames-1);
      }
      
      protected function displayFrame(param1:uint) : Boolean {
         if(param1 == this._currentIndex)
         {
            return false;
         }
         var _loc2_:Array = FRAMES[this._targetName].frameList;
         var _loc3_:RasterizedFrame = _loc2_[param1] as RasterizedFrame;
         if(!_loc3_)
         {
            _loc3_ = new RasterizedFrame(this._target,param1);
            _loc2_[param1] = _loc3_;
         }
         if(!this._bitmap)
         {
            this._bitmap = new Bitmap(_loc3_.bitmapData);
            this._bitmap.smoothing = this._smoothing;
            addChild(this._bitmap);
         }
         else
         {
            this._bitmap.bitmapData = _loc3_.bitmapData;
         }
         this._bitmap.x = _loc3_.x;
         this._bitmap.y = _loc3_.y;
         this._currentIndex = param1;
         return true;
      }
   }
}
