package com.ankamagames.jerakine.cache
{
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   
   public interface ICachable extends IDestroyable
   {
      
      function set name(param1:String) : void;
      
      function get name() : String;
      
      function set inUse(param1:Boolean) : void;
      
      function get inUse() : Boolean;
   }
}
