package com.ankamagames.berilia.types.uiDefinition
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.types.graphic.GraphicSize;
   
   public class SizeElement extends Object
   {
      
      public function SizeElement() {
         super();
      }
      
      public static const SIZE_PIXEL:uint = 0;
      
      public static const SIZE_PRC:uint = 1;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SizeElement));
      
      public var xUnit:uint;
      
      public var yUnit:uint;
      
      public var x:Number;
      
      public var y:Number;
      
      public function toGraphicSize() : GraphicSize {
         var _loc1_:GraphicSize = new GraphicSize();
         if(!isNaN(this.xUnit))
         {
            _loc1_.setX(this.x,this.xUnit);
         }
         if(!isNaN(this.yUnit))
         {
            _loc1_.setY(this.y,this.yUnit);
         }
         return _loc1_;
      }
   }
}
