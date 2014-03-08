package com.ankamagames.atouin.data.elements.subtypes
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.IDataInput;
   import com.ankamagames.atouin.AtouinConstants;
   
   public class BlendedGraphicalElementData extends NormalGraphicalElementData
   {
      
      public function BlendedGraphicalElementData(elementId:int, elementType:int) {
         super(elementId,elementType);
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(NormalGraphicalElementData));
      
      public var blendMode:String;
      
      override public function fromRaw(raw:IDataInput, version:int) : void {
         super.fromRaw(raw,version);
         var blendModeLength:uint = raw.readInt();
         this.blendMode = raw.readUTFBytes(blendModeLength);
         if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
         {
            _log.debug("  (BlendedGraphicalElementData) BlendMode : " + this.blendMode);
         }
      }
   }
}
