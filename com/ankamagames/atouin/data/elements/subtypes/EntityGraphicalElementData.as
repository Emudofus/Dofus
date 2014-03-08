package com.ankamagames.atouin.data.elements.subtypes
{
   import com.ankamagames.atouin.data.elements.GraphicalElementData;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.IDataInput;
   import com.ankamagames.atouin.AtouinConstants;
   
   public class EntityGraphicalElementData extends GraphicalElementData
   {
      
      public function EntityGraphicalElementData(param1:int, param2:int) {
         super(param1,param2);
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EntityGraphicalElementData));
      
      public var entityLook:String;
      
      public var horizontalSymmetry:Boolean;
      
      public var playAnimation:Boolean;
      
      public var playAnimStatic:Boolean;
      
      public var minDelay:uint;
      
      public var maxDelay:uint;
      
      override public function fromRaw(param1:IDataInput, param2:int) : void {
         var _loc3_:uint = param1.readInt();
         this.entityLook = param1.readUTFBytes(_loc3_);
         if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
         {
            _log.debug("  (EntityGraphicalElementData) Entity look : " + this.entityLook);
         }
         this.horizontalSymmetry = param1.readBoolean();
         if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
         {
            _log.debug("  (EntityGraphicalElementData) Element horizontals symmetry : " + this.horizontalSymmetry);
         }
         if(param2 >= 7)
         {
            this.playAnimation = param1.readBoolean();
            if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
               _log.debug("  (EntityGraphicalElementData) playAnimation : " + this.playAnimation);
            }
         }
         if(param2 >= 6)
         {
            this.playAnimStatic = param1.readBoolean();
            if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
               _log.debug("  (EntityGraphicalElementData) playAnimStatic : " + this.playAnimStatic);
            }
         }
         if(param2 >= 5)
         {
            this.minDelay = param1.readInt();
            if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
               _log.debug("  (EntityGraphicalElementData) minDelay : " + this.minDelay);
            }
            this.maxDelay = param1.readInt();
            if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
               _log.debug("  (EntityGraphicalElementData) maxDelay : " + this.maxDelay);
            }
         }
      }
   }
}
