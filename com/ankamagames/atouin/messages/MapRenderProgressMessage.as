package com.ankamagames.atouin.messages
{
   public class MapRenderProgressMessage extends MapMessage
   {
      
      public function MapRenderProgressMessage(percent:Number) {
         super();
         this._percent = percent;
      }
      
      private var _percent:Number = 0;
      
      public function get percent() : Number {
         return this._percent;
      }
   }
}
