package com.ankamagames.jerakine.replay
{
   public class LogClassField extends Object
   {
      
      public function LogClassField(fieldNameId:uint, type:int, transient:Boolean) {
         super();
         this.fieldNameId = fieldNameId;
         this.type = type;
         this.transient = transient;
      }
      
      public var fieldNameId:uint;
      
      public var type:int;
      
      public var transient:Boolean;
   }
}
