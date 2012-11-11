package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.dofus.network.types.game.character.alignment.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameRolePlayCharacterInformations extends GameRolePlayHumanoidInformations implements INetworkType
    {
        public var alignmentInfos:ActorAlignmentInformations;
        public static const protocolId:uint = 36;

        public function GameRolePlayCharacterInformations()
        {
            this.alignmentInfos = new ActorAlignmentInformations();
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 36;
        }// end function

        public function initGameRolePlayCharacterInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:String = "", param5:HumanInformations = null, param6:uint = 0, param7:ActorAlignmentInformations = null) : GameRolePlayCharacterInformations
        {
            super.initGameRolePlayHumanoidInformations(param1, param2, param3, param4, param5, param6);
            this.alignmentInfos = param7;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.alignmentInfos = new ActorAlignmentInformations();
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameRolePlayCharacterInformations(param1);
            return;
        }// end function

        public function serializeAs_GameRolePlayCharacterInformations(param1:IDataOutput) : void
        {
            super.serializeAs_GameRolePlayHumanoidInformations(param1);
            this.alignmentInfos.serializeAs_ActorAlignmentInformations(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameRolePlayCharacterInformations(param1);
            return;
        }// end function

        public function deserializeAs_GameRolePlayCharacterInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.alignmentInfos = new ActorAlignmentInformations();
            this.alignmentInfos.deserialize(param1);
            return;
        }// end function

    }
}
