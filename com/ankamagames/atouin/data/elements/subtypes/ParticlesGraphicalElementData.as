package com.ankamagames.atouin.data.elements.subtypes
{
   import com.ankamagames.atouin.data.elements.GraphicalElementData;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.IDataInput;
   import com.ankamagames.atouin.AtouinConstants;
   
   public class ParticlesGraphicalElementData extends GraphicalElementData
   {
      
      public function ParticlesGraphicalElementData(param1:int, param2:int) {
         super(param1,param2);
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ParticlesGraphicalElementData));
      
      public var scriptId:int;
      
      override public function fromRaw(param1:IDataInput, param2:int) : void {
         this.scriptId = param1.readShort();
         if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
         {
            _log.debug("  (ParticlesGraphicalElementData) Script id : " + this.scriptId);
         }
      }
   }
}
