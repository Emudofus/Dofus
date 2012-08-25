package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameRolePlayMutantInformations extends GameRolePlayHumanoidInformations implements INetworkType
    {
        public var monsterId:int = 0;
        public var powerLevel:int = 0;
        public static const protocolId:uint = 3;

        public function GameRolePlayMutantInformations()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 3;
        }// end function

        public function initGameRolePlayMutantInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:String = "", param5:HumanInformations = null, param6:int = 0, param7:int = 0) : GameRolePlayMutantInformations
        {
            super.initGameRolePlayHumanoidInformations(param1, param2, param3, param4, param5);
            this.monsterId = param6;
            this.powerLevel = param7;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.monsterId = 0;
            this.powerLevel = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameRolePlayMutantInformations(param1);
            return;
        }// end function

        public function serializeAs_GameRolePlayMutantInformations(param1:IDataOutput) : void
        {
            super.serializeAs_GameRolePlayHumanoidInformations(param1);
            param1.writeInt(this.monsterId);
            param1.writeByte(this.powerLevel);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameRolePlayMutantInformations(param1);
            return;
        }// end function

        public function deserializeAs_GameRolePlayMutantInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.monsterId = param1.readInt();
            this.powerLevel = param1.readByte();
            return;
        }// end function

    }
}
