package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.quest.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameRolePlayNpcWithQuestInformations extends GameRolePlayNpcInformations implements INetworkType
    {
        public var questFlag:GameRolePlayNpcQuestFlag;
        public static const protocolId:uint = 383;

        public function GameRolePlayNpcWithQuestInformations()
        {
            this.questFlag = new GameRolePlayNpcQuestFlag();
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 383;
        }// end function

        public function initGameRolePlayNpcWithQuestInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:uint = 0, param5:Boolean = false, param6:uint = 0, param7:GameRolePlayNpcQuestFlag = null) : GameRolePlayNpcWithQuestInformations
        {
            super.initGameRolePlayNpcInformations(param1, param2, param3, param4, param5, param6);
            this.questFlag = param7;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.questFlag = new GameRolePlayNpcQuestFlag();
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameRolePlayNpcWithQuestInformations(param1);
            return;
        }// end function

        public function serializeAs_GameRolePlayNpcWithQuestInformations(param1:IDataOutput) : void
        {
            super.serializeAs_GameRolePlayNpcInformations(param1);
            this.questFlag.serializeAs_GameRolePlayNpcQuestFlag(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameRolePlayNpcWithQuestInformations(param1);
            return;
        }// end function

        public function deserializeAs_GameRolePlayNpcWithQuestInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.questFlag = new GameRolePlayNpcQuestFlag();
            this.questFlag.deserialize(param1);
            return;
        }// end function

    }
}
