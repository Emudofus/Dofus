package com.ankamagames.jerakine.script.api
{
   import flash.filters.BevelFilter;
   import flash.filters.BlurFilter;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.ConvolutionFilter;
   import flash.filters.DisplacementMapFilter;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   
   public class EffectsApi extends Object
   {
      
      public function EffectsApi() {
         super();
      }
      
      public static function CreateBevelFilter(param1:Number=4.0, param2:Number=45, param3:uint=16777215, param4:Number=1.0, param5:uint=0, param6:Number=1.0, param7:Number=4.0, param8:Number=4.0, param9:Number=1, param10:int=1, param11:String="inner", param12:Boolean=false) : BevelFilter {
         return new BevelFilter(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
      }
      
      public static function CreateBlurFilter(param1:Number=4.0, param2:Number=4.0, param3:int=1) : BlurFilter {
         return new BlurFilter(param1,param2,param3);
      }
      
      public static function CreateColorMatrixFilter(param1:Array=null) : ColorMatrixFilter {
         return new ColorMatrixFilter(param1);
      }
      
      public static function CreateConvolutionFilter(param1:Number=0, param2:Number=0, param3:Array=null, param4:Number=1.0, param5:Number=0.0, param6:Boolean=true, param7:Boolean=true, param8:uint=0, param9:Number=0.0) : ConvolutionFilter {
         return new ConvolutionFilter(param1,param2,param3,param4,param5,param6,param7,param8,param9);
      }
      
      public static function CreateDisplacementMapFilter(param1:BitmapData=null, param2:Point=null, param3:uint=0, param4:uint=0, param5:Number=0.0, param6:Number=0.0, param7:String="wrap", param8:uint=0, param9:Number=0.0) : DisplacementMapFilter {
         return new DisplacementMapFilter(param1,param2,param3,param4,param5,param6,param7,param8,param9);
      }
      
      public static function CreateDropShadowFilter(param1:Number=4.0, param2:Number=45, param3:uint=0, param4:Number=1.0, param5:Number=4.0, param6:Number=4.0, param7:Number=1.0, param8:int=1, param9:Boolean=false, param10:Boolean=false, param11:Boolean=false) : DropShadowFilter {
         return new DropShadowFilter(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      public static function CreateGlowFilter(param1:uint=4.27819008E9, param2:Number=1.0, param3:Number=6.0, param4:Number=6.0, param5:Number=2, param6:int=1, param7:Boolean=false, param8:Boolean=false) : GlowFilter {
         return new GlowFilter(param1,param2,param3,param4,param5,param6,param7,param8);
      }
   }
}
