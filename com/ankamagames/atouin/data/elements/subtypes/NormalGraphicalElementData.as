package com.ankamagames.atouin.data.elements.subtypes
{
   import com.ankamagames.atouin.data.elements.GraphicalElementData;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   import com.ankamagames.atouin.AtouinConstants;
   
   public class NormalGraphicalElementData extends GraphicalElementData
   {
      
      public function NormalGraphicalElementData(param1:int, param2:int) {
         super(param1,param2);
         MEMORY_LOG[this] = 1;
      }
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(NormalGraphicalElementData));
      
      public var gfxId:int;
      
      public var height:uint;
      
      public var horizontalSymmetry:Boolean;
      
      public var origin:Point;
      
      public var size:Point;
      
      override public function fromRaw(param1:IDataInput, param2:int) : void {
         this.gfxId = param1.readInt();
         if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
         {
            _log.debug("  (ElementData) Element gfx id : " + this.gfxId);
         }
         this.height = param1.readByte();
         if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
         {
            _log.debug("  (ElementData) Element height : " + this.height);
         }
         this.horizontalSymmetry = param1.readBoolean();
         if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
         {
            _log.debug("  (ElementData) Element horizontals symmetry : " + this.horizontalSymmetry);
         }
         this.origin = new Point(param1.readShort(),param1.readShort());
         if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
         {
            _log.debug("  (ElementData) Origin : (" + this.origin.x + ";" + this.origin.y + ")");
         }
         this.size = new Point(param1.readShort(),param1.readShort());
         if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
         {
            _log.debug("  (ElementData) Size : (" + this.size.x + ";" + this.size.y + ")");
         }
      }
   }
}
