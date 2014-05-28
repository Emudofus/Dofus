package com.ankamagames.atouin.data.elements
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.IDataInput;
   import com.ankamagames.jerakine.utils.errors.AbstractMethodCallError;
   
   public class GraphicalElementData extends Object
   {
      
      public function GraphicalElementData(elementId:int, elementType:int) {
         super();
         this.id = elementId;
         this.type = elementType;
      }
      
      protected static const _log:Logger;
      
      public var id:int;
      
      public var type:int;
      
      public function fromRaw(raw:IDataInput, version:int) : void {
         throw new AbstractMethodCallError();
      }
   }
}
