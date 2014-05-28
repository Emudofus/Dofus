package com.ankamagames.dofus.logic.game.common.misc
{
   import com.ankamagames.jerakine.network.IMessageRouter;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionType;
   
   public class KoliseumMessageRouter extends Object implements IMessageRouter
   {
      
      public function KoliseumMessageRouter() {
         super();
      }
      
      public function getConnectionId(msg:INetworkMessage) : String {
         return ConnectionType.TO_KOLI_SERVER;
      }
   }
}
