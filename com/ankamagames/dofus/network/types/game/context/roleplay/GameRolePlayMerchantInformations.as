package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameRolePlayMerchantInformations extends GameRolePlayNamedActorInformations implements INetworkType
    {
        public var sellType:uint = 0;
        public static const protocolId:uint = 129;

        public function GameRolePlayMerchantInformations()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 129;
        }// end function

        public function initGameRolePlayMerchantInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:String = "", param5:uint = 0) : GameRolePlayMerchantInformations
        {
            super.initGameRolePlayNamedActorInformations(param1, param2, param3, param4);
            this.sellType = param5;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.sellType = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameRolePlayMerchantInformations(param1);
            return;
        }// end function

        public function serializeAs_GameRolePlayMerchantInformations(param1:IDataOutput) : void
        {
            super.serializeAs_GameRolePlayNamedActorInformations(param1);
            if (this.sellType < 0)
            {
                throw new Error("Forbidden value (" + this.sellType + ") on element sellType.");
            }
            param1.writeInt(this.sellType);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameRolePlayMerchantInformations(param1);
            return;
        }// end function

        public function deserializeAs_GameRolePlayMerchantInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.sellType = param1.readInt();
            if (this.sellType < 0)
            {
                throw new Error("Forbidden value (" + this.sellType + ") on element of GameRolePlayMerchantInformations.sellType.");
            }
            return;
        }// end function

    }
}
