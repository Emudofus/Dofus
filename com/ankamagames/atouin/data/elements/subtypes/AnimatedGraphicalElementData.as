package com.ankamagames.atouin.data.elements.subtypes
{
   import flash.utils.IDataInput;
   import com.ankamagames.atouin.AtouinConstants;
   
   public class AnimatedGraphicalElementData extends NormalGraphicalElementData
   {
      
      public function AnimatedGraphicalElementData(elementId:int, elementType:int) {
         super(elementId,elementType);
      }
      
      public var minDelay:uint;
      
      public var maxDelay:uint;
      
      override public function fromRaw(raw:IDataInput, version:int) : void {
         super.fromRaw(raw,version);
         if(version == 4)
         {
            this.minDelay = raw.readInt();
            if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
               _log.debug("  (AnimatedGraphicalElementData) minDelay : " + this.minDelay);
            }
            this.maxDelay = raw.readInt();
            if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
               _log.debug("  (AnimatedGraphicalElementData) maxDelay : " + this.maxDelay);
            }
         }
      }
   }
}
