package com.ankamagames.berilia.types.graphic
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.utils.errors.BeriliaXmlParsingError;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.enums.LocationTypeEnum;
   import com.ankamagames.berilia.types.uiDefinition.LocationELement;
   
   public class GraphicLocation extends Object
   {
      
      public function GraphicLocation(param1:Number=NaN, param2:Number=NaN, param3:String=null) {
         super();
         this._nOffsetX = 0;
         this._nOffsetY = 0;
         this._nPoint = LocationEnum.POINT_TOPLEFT;
         this._nRelativePoint = LocationEnum.POINT_TOPLEFT;
         this._sRelativeTo = REF_PARENT;
         if(!isNaN(param1))
         {
            this._nPoint = param1;
         }
         if(!isNaN(param2))
         {
            this._nRelativePoint = param2;
         }
         if(param3 != null)
         {
            this._sRelativeTo = param3;
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GraphicLocation));
      
      public static const REF_PARENT:String = "$PARENT";
      
      public static const REF_TOP:String = "$TOP";
      
      public static const REF_SCREEN:String = "$SCREEN";
      
      public static const REF_LAST:String = "$LAST";
      
      public static function convertPointStringToInt(param1:String) : uint {
         switch(param1)
         {
            case "TOPLEFT":
               return LocationEnum.POINT_TOPLEFT;
            case "TOP":
               return LocationEnum.POINT_TOP;
            case "TOPRIGHT":
               return LocationEnum.POINT_TOPRIGHT;
            case "LEFT":
               return LocationEnum.POINT_LEFT;
            case "CENTER":
               return LocationEnum.POINT_CENTER;
            case "RIGHT":
               return LocationEnum.POINT_RIGHT;
            case "BOTTOMLEFT":
               return LocationEnum.POINT_BOTTOMLEFT;
            case "BOTTOM":
               return LocationEnum.POINT_BOTTOM;
            case "BOTTOMRIGHT":
               return LocationEnum.POINT_BOTTOMRIGHT;
            default:
               throw new BeriliaXmlParsingError(param1 + " is not a valid value for a point location");
         }
      }
      
      public static function convertPointIntToString(param1:uint) : String {
         switch(param1)
         {
            case LocationEnum.POINT_TOPLEFT:
               return "TOPLEFT";
            case LocationEnum.POINT_TOP:
               return "TOP";
            case LocationEnum.POINT_TOPRIGHT:
               return "TOPRIGHT";
            case LocationEnum.POINT_LEFT:
               return "LEFT";
            case LocationEnum.POINT_CENTER:
               return "CENTER";
            case LocationEnum.POINT_RIGHT:
               return "RIGHT";
            case LocationEnum.POINT_BOTTOMLEFT:
               return "BOTTOMLEFT";
            case LocationEnum.POINT_BOTTOM:
               return "BOTTOM";
            case LocationEnum.POINT_BOTTOMRIGHT:
               return "BOTTOMRIGHT";
            default:
               throw new BeriliaXmlParsingError(param1 + " is not a valid value for a point location");
         }
      }
      
      private var _nPoint:uint;
      
      private var _nRelativePoint:uint;
      
      private var _sRelativeTo:String;
      
      protected var _nOffsetX:Number;
      
      protected var _nOffsetY:Number;
      
      public var offsetXType:uint;
      
      public var offsetYType:uint;
      
      public function setPoint(param1:String) : void {
         this._nPoint = convertPointStringToInt(param1);
      }
      
      public function getPoint() : uint {
         return this._nPoint;
      }
      
      public function setRelativePoint(param1:String) : void {
         this._nRelativePoint = convertPointStringToInt(param1);
      }
      
      public function getRelativePoint() : uint {
         return this._nRelativePoint;
      }
      
      public function setRelativeTo(param1:String) : void {
         this._sRelativeTo = param1;
      }
      
      public function getRelativeTo() : String {
         return this._sRelativeTo;
      }
      
      public function setOffsetX(param1:Number) : void {
         if(this.offsetXType == LocationTypeEnum.LOCATION_TYPE_ABSOLUTE)
         {
            this._nOffsetX = Math.floor(param1);
         }
         else
         {
            this._nOffsetX = param1;
         }
      }
      
      public function getOffsetX() : Number {
         return this._nOffsetX;
      }
      
      public function setOffsetY(param1:Number) : void {
         if(this.offsetYType == LocationTypeEnum.LOCATION_TYPE_ABSOLUTE)
         {
            this._nOffsetY = Math.floor(param1);
         }
         else
         {
            this._nOffsetY = param1;
         }
      }
      
      public function getOffsetY() : Number {
         return this._nOffsetY;
      }
      
      public function toString() : String {
         return "GraphicLocation [point : " + convertPointIntToString(this.getPoint()) + ", relativePoint : " + convertPointIntToString(this.getRelativePoint()) + ", relativeTo : " + this.getRelativeTo() + ", offset : " + this.getOffsetX() + "/" + this.getOffsetY();
      }
      
      public function clone() : GraphicLocation {
         var _loc1_:GraphicLocation = new GraphicLocation(this._nPoint,this._nRelativePoint,this._sRelativeTo);
         _loc1_.offsetXType = this.offsetXType;
         _loc1_.offsetYType = this.offsetYType;
         _loc1_.setOffsetX(this.getOffsetX());
         _loc1_.setOffsetY(this.getOffsetY());
         return _loc1_;
      }
      
      public function toLocationElement() : LocationELement {
         var _loc1_:LocationELement = new LocationELement();
         _loc1_.offsetXType = this.offsetXType;
         _loc1_.offsetYType = this.offsetYType;
         _loc1_.offsetX = this.getOffsetX();
         _loc1_.offsetY = this.getOffsetY();
         _loc1_.point = this.getPoint();
         _loc1_.relativePoint = this.getRelativePoint();
         _loc1_.relativeTo = this.getRelativeTo();
         return _loc1_;
      }
   }
}
