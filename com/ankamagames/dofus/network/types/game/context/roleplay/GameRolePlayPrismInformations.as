package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.dofus.network.types.game.character.alignment.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameRolePlayPrismInformations extends GameRolePlayActorInformations implements INetworkType
    {
        public var alignInfos:ActorAlignmentInformations;
        public static const protocolId:uint = 161;

        public function GameRolePlayPrismInformations()
        {
            this.alignInfos = new ActorAlignmentInformations();
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 161;
        }// end function

        public function initGameRolePlayPrismInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:ActorAlignmentInformations = null) : GameRolePlayPrismInformations
        {
            super.initGameRolePlayActorInformations(param1, param2, param3);
            this.alignInfos = param4;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.alignInfos = new ActorAlignmentInformations();
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameRolePlayPrismInformations(param1);
            return;
        }// end function

        public function serializeAs_GameRolePlayPrismInformations(param1:IDataOutput) : void
        {
            super.serializeAs_GameRolePlayActorInformations(param1);
            this.alignInfos.serializeAs_ActorAlignmentInformations(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameRolePlayPrismInformations(param1);
            return;
        }// end function

        public function deserializeAs_GameRolePlayPrismInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.alignInfos = new ActorAlignmentInformations();
            this.alignInfos.deserialize(param1);
            return;
        }// end function

    }
}
