package com.ankamagames.dofus.logic.game.fight.messages
{
   import com.ankamagames.jerakine.messages.Message;


   public class TextActionInformationMessage extends Object implements Message
   {
         

      public function TextActionInformationMessage(textKey:uint, params:Array=null) {
         super();
         this._textKey=textKey;
         this._params=params;
      }



      private var _textKey:uint;

      private var _params:Array;

      public function get textKey() : uint {
         return this._textKey;
      }

      public function get params() : Array {
         return this._params;
      }
   }

}