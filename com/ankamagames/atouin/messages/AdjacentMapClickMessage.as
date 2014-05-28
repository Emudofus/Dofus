package com.ankamagames.atouin.messages
{
   import com.ankamagames.jerakine.messages.Message;
   
   public class AdjacentMapClickMessage extends Object implements Message
   {
      
      public function AdjacentMapClickMessage() {
         super();
      }
      
      public var adjacentMapId:uint;
      
      public var cellId:uint;
   }
}
