package com.ankamagames.jerakine.scrambling
{
   import flash.utils.ByteArray;
   
   public interface Scramblable
   {
      
      function scramble(param1:ByteArray) : void;
      
      function unscramble(param1:ByteArray) : void;
   }
}
