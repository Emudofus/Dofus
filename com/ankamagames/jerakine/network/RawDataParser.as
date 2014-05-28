package com.ankamagames.jerakine.network
{
   import flash.utils.IDataInput;
   
   public interface RawDataParser
   {
      
      function parse(param1:IDataInput, param2:uint, param3:uint) : INetworkMessage;
   }
}
