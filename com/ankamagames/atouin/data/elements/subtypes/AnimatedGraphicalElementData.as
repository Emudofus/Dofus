package com.ankamagames.atouin.data.elements.subtypes
{
   import flash.utils.IDataInput;
   import com.ankamagames.atouin.AtouinConstants;
   
   public class AnimatedGraphicalElementData extends NormalGraphicalElementData
   {
      
      public function AnimatedGraphicalElementData(param1:int, param2:int) {
         super(param1,param2);
      }
      
      public var minDelay:uint;
      
      public var maxDelay:uint;
      
      override public function fromRaw(param1:IDataInput, param2:int) : void {
         super.fromRaw(param1,param2);
         if(param2 == 4)
         {
            this.minDelay = param1.readInt();
            if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
               _log.debug("  (AnimatedGraphicalElementData) minDelay : " + this.minDelay);
            }
            this.maxDelay = param1.readInt();
            if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
               _log.debug("  (AnimatedGraphicalElementData) maxDelay : " + this.maxDelay);
            }
         }
      }
   }
}
