package com.ankamagames.berilia.types.graphic
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class GraphicElement extends Object
   {
      
      public function GraphicElement(param1:GraphicContainer, param2:Array, param3:String) {
         super();
         this.sprite = param1;
         if(!(param2 == null) && !(param2[0] == null))
         {
            this.locations = param2;
            this.location = param2[0];
         }
         else
         {
            this.location = new GraphicLocation();
            this.locations = new Array(this.location);
         }
         this.name = param3;
         this.size = new GraphicSize();
      }
      
      private static var _aGEIndex:Array = new Array();
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GraphicElement));
      
      public static function getGraphicElement(param1:GraphicContainer, param2:Array, param3:String=null) : GraphicElement {
         var _loc4_:GraphicElement = null;
         if(param3 == null || _aGEIndex[param3] == null)
         {
            _loc4_ = new GraphicElement(param1,param2,param3);
            if(param3 != null)
            {
               _aGEIndex[param3] = _loc4_;
            }
         }
         else
         {
            _loc4_ = _aGEIndex[param3];
         }
         if(param2 != null)
         {
            _loc4_.locations = param2;
            if(!(param2 == null) && !(param2[0] == null))
            {
               _loc4_.location = param2[0];
            }
         }
         return _loc4_;
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
