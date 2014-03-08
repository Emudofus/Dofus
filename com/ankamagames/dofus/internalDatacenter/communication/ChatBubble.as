package com.ankamagames.dofus.internalDatacenter.communication
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ChatBubble extends Object implements IDataCenter
   {
      
      public function ChatBubble(param1:String) {
         super();
         this._text = param1;
      }
      
      private var _text:String;
      
      public function get text() : String {
         return this._text;
      }
   }
}
