package com.ankamagames.dofus.internalDatacenter.communication
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;


   public class ChatBubble extends Object implements IDataCenter
   {
         

      public function ChatBubble(text:String) {
         super();
         this._text=text;
      }



      private var _text:String;

      public function get text() : String {
         return this._text;
      }
   }

}