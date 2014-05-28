package com.ankamagames.dofus.logic.game.common.misc
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public interface IHookLock
   {
      
      function addHook(param1:Hook, param2:Array) : void;
      
      function release() : void;
   }
}
