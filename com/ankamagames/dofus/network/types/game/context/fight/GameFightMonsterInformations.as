package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameFightMonsterInformations extends GameFightAIInformations implements INetworkType
    {
        public var creatureGenericId:uint = 0;
        public var creatureGrade:uint = 0;
        public static const protocolId:uint = 29;

        public function GameFightMonsterInformations()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 29;
        }// end function

        public function initGameFightMonsterInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:uint = 2, param5:Boolean = false, param6:GameFightMinimalStats = null, param7:uint = 0, param8:uint = 0) : GameFightMonsterInformations
        {
            super.initGameFightAIInformations(param1, param2, param3, param4, param5, param6);
            this.creatureGenericId = param7;
            this.creatureGrade = param8;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.creatureGenericId = 0;
            this.creatureGrade = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameFightMonsterInformations(param1);
            return;
        }// end function

        public function serializeAs_GameFightMonsterInformations(param1:IDataOutput) : void
        {
            super.serializeAs_GameFightAIInformations(param1);
            if (this.creatureGenericId < 0)
            {
                throw new Error("Forbidden value (" + this.creatureGenericId + ") on element creatureGenericId.");
            }
            param1.writeShort(this.creatureGenericId);
            if (this.creatureGrade < 0)
            {
                throw new Error("Forbidden value (" + this.creatureGrade + ") on element creatureGrade.");
            }
            param1.writeByte(this.creatureGrade);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightMonsterInformations(param1);
            return;
        }// end function

        public function deserializeAs_GameFightMonsterInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.creatureGenericId = param1.readShort();
            if (this.creatureGenericId < 0)
            {
                throw new Error("Forbidden value (" + this.creatureGenericId + ") on element of GameFightMonsterInformations.creatureGenericId.");
            }
            this.creatureGrade = param1.readByte();
            if (this.creatureGrade < 0)
            {
                throw new Error("Forbidden value (" + this.creatureGrade + ") on element of GameFightMonsterInformations.creatureGrade.");
            }
            return;
        }// end function

    }
}
