package com.ankamagames.tiphon.types
{
   public class TiphonEventInfo extends Object
   {
      
      public function TiphonEventInfo(param1:String, param2:String="") {
         super();
         this.type = param1;
         this._params = param2;
      }
      
      public var type:String;
      
      private var _label:String;
      
      private var _sprite;
      
      private var _params:String;
      
      private var _animationType:String;
      
      private var _direction:int = -1;
      
      public function set label(param1:String) : void {
         this._label = param1;
      }
      
      public function get label() : String {
         return this._label;
      }
      
      public function get sprite() : * {
         return this._sprite;
      }
      
      public function get params() : String {
         return this._params;
      }
      
      public function get animationType() : String {
         if(this._animationType == null)
         {
            return "undefined";
         }
         return this._animationType;
      }
      
      public function get direction() : int {
         return this._direction;
      }
      
      public function get animationName() : String {
         return this._animationType + "_" + this._direction;
      }
      
      public function set animationName(param1:String) : void {
         var _loc2_:Array = param1.split("_");
         var _loc3_:uint = _loc2_.length;
         this._animationType = "";
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_-1)
         {
            if(_loc4_ > 0)
            {
               this._animationType = this._animationType + ("_" + _loc2_[_loc4_]);
            }
            else
            {
               this._animationType = _loc2_[_loc4_];
            }
            _loc4_++;
         }
         this._direction = _loc2_[_loc2_.length-1];
         if(this._direction == 3)
         {
            this._direction = 1;
         }
         if(this._direction == 7)
         {
            this._direction = 5;
         }
      }
      
      public function duplicate() : TiphonEventInfo {
         return new TiphonEventInfo(this.type,this._params);
      }
      
      public function destroy() : void {
         this._sprite = null;
      }
   }
}
