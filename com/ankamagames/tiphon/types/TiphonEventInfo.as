package com.ankamagames.tiphon.types
{
   public class TiphonEventInfo extends Object
   {
      
      public function TiphonEventInfo(pType:String, pParams:String="") {
         super();
         this.type = pType;
         this._params = pParams;
      }
      
      public var type:String;
      
      private var _label:String;
      
      private var _sprite;
      
      private var _params:String;
      
      private var _animationType:String;
      
      private var _direction:int = -1;
      
      public function set label(pLabel:String) : void {
         this._label = pLabel;
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
      
      public function set animationName(pAnimationName:String) : void {
         var splited:Array = pAnimationName.split("_");
         var size:uint = splited.length;
         this._animationType = "";
         var i:uint = 0;
         while(i < size - 1)
         {
            if(i > 0)
            {
               this._animationType = this._animationType + ("_" + splited[i]);
            }
            else
            {
               this._animationType = splited[i];
            }
            i++;
         }
         this._direction = splited[splited.length - 1];
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
