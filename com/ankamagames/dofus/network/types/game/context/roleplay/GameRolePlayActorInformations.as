package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameRolePlayActorInformations extends GameContextActorInformations implements INetworkType
    {
        public static const protocolId:uint = 141;

        public function GameRolePlayActorInformations()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 141;
        }// end function

        public function initGameRolePlayActorInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null) : GameRolePlayActorInformations
        {
            super.initGameContextActorInformations(param1, param2, param3);
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameRolePlayActorInformations(param1);
            return;
        }// end function

        public function serializeAs_GameRolePlayActorInformations(param1:IDataOutput) : void
        {
            super.serializeAs_GameContextActorInformations(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameRolePlayActorInformations(param1);
            return;
        }// end function

        public function deserializeAs_GameRolePlayActorInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            return;
        }// end function

    }
}
