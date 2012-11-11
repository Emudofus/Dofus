package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameFightAIInformations extends GameFightFighterInformations implements INetworkType
    {
        public static const protocolId:uint = 151;

        public function GameFightAIInformations()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 151;
        }// end function

        public function initGameFightAIInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:uint = 2, param5:Boolean = false, param6:GameFightMinimalStats = null) : GameFightAIInformations
        {
            super.initGameFightFighterInformations(param1, param2, param3, param4, param5, param6);
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameFightAIInformations(param1);
            return;
        }// end function

        public function serializeAs_GameFightAIInformations(param1:IDataOutput) : void
        {
            super.serializeAs_GameFightFighterInformations(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightAIInformations(param1);
            return;
        }// end function

        public function deserializeAs_GameFightAIInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            return;
        }// end function

    }
}
