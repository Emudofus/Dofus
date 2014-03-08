package com.ankamagames.atouin.types
{
   import flash.display.Bitmap;
   import com.ankamagames.jerakine.interfaces.ICustomUnicNameGetter;
   import flash.display.BitmapData;
   
   public class MapGfxBitmap extends Bitmap implements ICustomUnicNameGetter
   {
      
      public function MapGfxBitmap(bitmapdata:BitmapData, pixelSnapping:String="auto", smoothing:Boolean=false, identifier:uint=0) {
         super(bitmapdata,pixelSnapping,smoothing);
         this._name = "mapGfx::" + identifier;
      }
      
      private var _name:String;
      
      public function get customUnicName() : String {
         return null;
      }
   }
}
