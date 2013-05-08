package com.ankamagames.atouin.messages
{


   public class MapLoadingFailedMessage extends MapMessage
   {
         

      public function MapLoadingFailedMessage() {
         super();
      }

      public static const NO_FILE:uint = 0;

      public var errorReason:uint;
   }

}