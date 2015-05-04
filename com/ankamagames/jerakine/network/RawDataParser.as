package com.ankamagames.jerakine.network
{
   public interface RawDataParser
   {
      
      function parse(param1:ICustomDataInput, param2:uint, param3:uint) : INetworkMessage;
   }
}
