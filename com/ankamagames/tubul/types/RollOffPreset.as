package com.ankamagames.tubul.types
{
   public class RollOffPreset extends Object
   {
      
      public function RollOffPreset(param1:uint, param2:uint, param3:uint) {
         super();
         this._maxVolume = param1;
         this._maxRange = param2;
         this._maxSaturationRange = param3;
      }
      
      private var _maxVolume:uint;
      
      private var _maxRange:uint;
      
      private var _maxSaturationRange:uint;
      
      public function get maxVolume() : uint {
         return this._maxVolume;
      }
      
      public function get maxRange() : uint {
         return this._maxRange;
      }
      
      public function get maxSaturationRange() : uint {
         return this._maxSaturationRange;
      }
   }
}
