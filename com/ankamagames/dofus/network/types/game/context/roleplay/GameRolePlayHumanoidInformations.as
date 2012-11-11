package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameRolePlayHumanoidInformations extends GameRolePlayNamedActorInformations implements INetworkType
    {
        public var humanoidInfo:HumanInformations;
        public var accountId:uint = 0;
        public static const protocolId:uint = 159;

        public function GameRolePlayHumanoidInformations()
        {
            this.humanoidInfo = new HumanInformations();
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 159;
        }// end function

        public function initGameRolePlayHumanoidInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:String = "", param5:HumanInformations = null, param6:uint = 0) : GameRolePlayHumanoidInformations
        {
            super.initGameRolePlayNamedActorInformations(param1, param2, param3, param4);
            this.humanoidInfo = param5;
            this.accountId = param6;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.humanoidInfo = new HumanInformations();
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameRolePlayHumanoidInformations(param1);
            return;
        }// end function

        public function serializeAs_GameRolePlayHumanoidInformations(param1:IDataOutput) : void
        {
            super.serializeAs_GameRolePlayNamedActorInformations(param1);
            param1.writeShort(this.humanoidInfo.getTypeId());
            this.humanoidInfo.serialize(param1);
            if (this.accountId < 0)
            {
                throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
            }
            param1.writeInt(this.accountId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameRolePlayHumanoidInformations(param1);
            return;
        }// end function

        public function deserializeAs_GameRolePlayHumanoidInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            var _loc_2:* = param1.readUnsignedShort();
            this.humanoidInfo = ProtocolTypeManager.getInstance(HumanInformations, _loc_2);
            this.humanoidInfo.deserialize(param1);
            this.accountId = param1.readInt();
            if (this.accountId < 0)
            {
                throw new Error("Forbidden value (" + this.accountId + ") on element of GameRolePlayHumanoidInformations.accountId.");
            }
            return;
        }// end function

    }
}
