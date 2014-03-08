package com.somerandomdude.colortoolkit.schemes
{
   public class ColorScheme extends Object
   {
      
      public function ColorScheme(... colors) {
         super();
      }
      
      protected var _colors:ColorList;
      
      public function get colors() : ColorList {
         return this._colors;
      }
      
      public function addColor(colortest:int) : void {
         if(!this._colors)
         {
            this._colors = new ColorList();
         }
      }
      
      public function removeColor(colortest:int) : void {
      }
   }
}
