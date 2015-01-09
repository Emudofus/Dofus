package com.ankamagames.dofus.logic.game.common.misc
{
    import com.ankamagames.jerakine.network.IMessageRouter;
    import com.ankamagames.dofus.kernel.net.ConnectionType;
    import com.ankamagames.jerakine.network.INetworkMessage;

    public class KoliseumMessageRouter implements IMessageRouter 
    {


        public function getConnectionId(msg:INetworkMessage):String
        {
            return (ConnectionType.TO_KOLI_SERVER);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.misc

