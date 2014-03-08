package com.ankamagames.jerakine.types
{
   import flash.utils.IExternalizable;
   import com.somerandomdude.colortoolkit.spaces.HSL;
   import com.somerandomdude.colortoolkit.ColorUtil;
   import com.somerandomdude.colortoolkit.Color;
   import com.ankamagames.jerakine.enum.ColorGenerationMethodsEnum;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class Color extends Object implements IExternalizable
   {
      
      public function Color(param1:uint=0) {
         super();
         this.parseColor(param1);
      }
      
      public static function toHsl(param1:uint) : HSL {
         return ColorUtil.toHSL(param1 as int);
      }
      
      public static function toHex(param1:HSL) : uint {
         return param1.color as uint;
      }
      
      public static function setHSLlightness(param1:uint, param2:Number) : uint {
         var _loc3_:HSL = toHsl(param1);
         _loc3_.lightness = param2;
         return toHex(_loc3_);
      }
      
      public static function setHSVSaturation(param1:uint, param2:Number) : uint {
         var _loc3_:HSL = toHsl(param1);
         _loc3_.saturation = param2;
         return toHex(_loc3_);
      }
      
      public static function generateColorList(param1:int) : * {
         var _loc2_:uint = Math.random() * 16777215;
         var _loc3_:Color = new com.somerandomdude.colortoolkit.Color(_loc2_);
         switch(param1)
         {
            case ColorGenerationMethodsEnum.MONOCHROME:
               return _loc3_.monochromeScheme.toHex() as Array;
            case ColorGenerationMethodsEnum.ANALOGOUS:
               return _loc3_.analogousScheme.toHex() as Array;
            case ColorGenerationMethodsEnum.COMPLEMENTARY:
               return _loc3_.complemenartyScheme.toHex() as Array;
            case ColorGenerationMethodsEnum.COMPOUND:
               return _loc3_.compoundScheme.toHex() as Array;
            case ColorGenerationMethodsEnum.TETRAD:
               return _loc3_.tetradScheme.toHex() as Array;
            case ColorGenerationMethodsEnum.FLIPPED_COMPOUND:
               return _loc3_.flippedCompoundScheme.toHex() as Array;
            default:
               return [-1,-1,-1,-1,-1,-1];
         }
      }
      
      public var red:uint;
      
      public var green:uint;
      
      public var blue:uint;
      
      public function get color() : uint {
         return (this.red & 255) << 16 | (this.green & 255) << 8 | this.blue & 255;
      }
      
      public function set color(param1:uint) : void {
         this.parseColor(param1);
      }
      
      public function readExternal(param1:IDataInput) : void {
         this.red = param1.readUnsignedByte();
         this.green = param1.readUnsignedByte();
         this.blue = param1.readUnsignedByte();
      }
      
      public function writeExternal(param1:IDataOutput) : void {
         param1.writeByte(this.red);
         param1.writeByte(this.green);
         param1.writeByte(this.blue);
      }
      
      public function toString() : String {
         return "[AdvancedColor(R=\"" + this.red + "\",G=\"" + this.green + "\",B=\"" + this.blue + "\")]";
      }
      
      public function release() : void {
         this.red = this.green = this.blue = 0;
      }
      
      public function adjustDarkness(param1:Number) : void {
         this.red = (1 - param1) * this.red;
         this.green = (1 - param1) * this.green;
         this.blue = (1 - param1) * this.blue;
      }
      
      public function adjustLight(param1:Number) : void {
         this.red = this.red + param1 * (255 - this.red);
         this.green = this.green + param1 * (255 - this.green);
         this.blue = this.blue + param1 * (255 - this.blue);
      }
      
      private function parseColor(param1:uint) : void {
         this.red = (param1 & 16711680) >> 16;
         this.green = (param1 & 65280) >> 8;
         this.blue = param1 & 255;
      }
   }
}
