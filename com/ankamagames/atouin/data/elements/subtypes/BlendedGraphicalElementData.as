package com.ankamagames.atouin.data.elements.subtypes
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.IDataInput;
   import com.ankamagames.atouin.AtouinConstants;
   
   public class BlendedGraphicalElementData extends NormalGraphicalElementData
   {
      
      public function BlendedGraphicalElementData(param1:int, param2:int) {
         super(param1,param2);
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(NormalGraphicalElementData));
      
      public var blendMode:String;
      
      override public function fromRaw(param1:IDataInput, param2:int) : void {
         super.fromRaw(param1,param2);
         var _loc3_:uint = param1.readInt();
         this.blendMode = param1.readUTFBytes(_loc3_);
         if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
         {
            _log.debug("  (BlendedGraphicalElementData) BlendMode : " + this.blendMode);
         }
      }
   }
}
