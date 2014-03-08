package com.ankamagames.berilia.types.graphic
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class GraphicElement extends Object
   {
      
      public function GraphicElement(spSprite:GraphicContainer, aLocations:Array, sName:String) {
         super();
         this.sprite = spSprite;
         if((!(aLocations == null)) && (!(aLocations[0] == null)))
         {
            this.locations = aLocations;
            this.location = aLocations[0];
         }
         else
         {
            this.location = new GraphicLocation();
            this.locations = new Array(this.location);
         }
         this.name = sName;
         this.size = new GraphicSize();
      }
      
      private static var _aGEIndex:Array = new Array();
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GraphicElement));
      
      public static function getGraphicElement(spSprite:GraphicContainer, aLocations:Array, sName:String=null) : GraphicElement {
         var ge:GraphicElement = null;
         if((sName == null) || (_aGEIndex[sName] == null))
         {
            ge = new GraphicElement(spSprite,aLocations,sName);
            if(sName != null)
            {
               _aGEIndex[sName] = ge;
            }
         }
         else
         {
            ge = _aGEIndex[sName];
         }
         if(aLocations != null)
         {
            ge.locations = aLocations;
            if((!(aLocations == null)) && (!(aLocations[0] == null)))
            {
               ge.location = aLocations[0];
            }
         }
         return ge;
      }
      
      public static function init() : void {
         _aGEIndex = new Array();
      }
      
      public var sprite:GraphicContainer;
      
      public var location:GraphicLocation;
      
      public var name:String;
      
      public var render:Boolean = false;
      
      public var size:GraphicSize;
      
      public var locations:Array;
   }
}
