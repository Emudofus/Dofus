package com.ankamagames.tiphon.types
{
   import com.ankamagames.tiphon.display.TiphonSprite;
   
   public class BehaviorData extends Object
   {
      
      public function BehaviorData(param1:String, param2:int, param3:TiphonSprite) {
         super();
         this._animation = param1;
         this._animationStartValue = param1;
         this._parent = param3;
         this._direction = param2;
         this._directionStartValue = param2;
      }
      
      private var _animation:String;
      
      private var _animationStartValue:String;
      
      private var _direction:int;
      
      private var _directionStartValue:int;
      
      private var _parent:TiphonSprite;
      
      public var lock:Boolean = false;
      
      public function get animation() : String {
         return this._animation;
      }
      
      public function get direction() : int {
         return this._direction;
      }
      
      public function set animation(param1:String) : void {
         if(!this.lock)
         {
            this._animation = param1;
         }
      }
      
      public function get animationStartValue() : String {
         return this._animationStartValue;
      }
      
      public function get directionStartValue() : int {
         return this._directionStartValue;
      }
      
      public function get parent() : TiphonSprite {
         return this._parent;
      }
   }
}
