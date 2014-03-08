package com.ankamagames.atouin.types
{
   import flash.display.Bitmap;
   import com.ankamagames.jerakine.interfaces.ICustomUnicNameGetter;
   import flash.display.BitmapData;
   
   public class MapGfxBitmap extends Bitmap implements ICustomUnicNameGetter
   {
      
      public function MapGfxBitmap(param1:BitmapData, param2:String="auto", param3:Boolean=false, param4:uint=0) {
         super(param1,param2,param3);
         this._name = "mapGfx::" + param4;
      }
      
      private var _name:String;
      
      public function get customUnicName() : String {
         return null;
      }
   }
}
