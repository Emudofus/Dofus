package com.ankamagames.berilia.types.uiDefinition
{
   import com.ankamagames.berilia.types.graphic.GraphicLocation;
   
   public class LocationELement extends Object
   {
      
      public function LocationELement() {
         super();
      }
      
      public var point:uint;
      
      public var relativePoint:uint;
      
      public var relativeTo:String;
      
      public var type:uint;
      
      public var offsetX:Number;
      
      public var offsetY:Number;
      
      public var offsetXType:uint;
      
      public var offsetYType:uint;
      
      public function toGraphicLocation() : GraphicLocation {
         var _loc1_:GraphicLocation = new GraphicLocation(this.point,this.relativePoint,this.relativeTo);
         _loc1_.offsetXType = this.offsetXType;
         _loc1_.offsetYType = this.offsetYType;
         if(!isNaN(this.offsetX))
         {
            _loc1_.setOffsetX(this.offsetX);
         }
         if(!isNaN(this.offsetY))
         {
            _loc1_.setOffsetY(this.offsetY);
         }
         return _loc1_;
      }
   }
}
