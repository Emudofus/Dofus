package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameFightTaxCollectorInformations extends GameFightAIInformations implements INetworkType
    {
        public var firstNameId:uint = 0;
        public var lastNameId:uint = 0;
        public var level:uint = 0;
        public static const protocolId:uint = 48;

        public function GameFightTaxCollectorInformations()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 48;
        }// end function

        public function initGameFightTaxCollectorInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:uint = 2, param5:Boolean = false, param6:GameFightMinimalStats = null, param7:uint = 0, param8:uint = 0, param9:uint = 0) : GameFightTaxCollectorInformations
        {
            super.initGameFightAIInformations(param1, param2, param3, param4, param5, param6);
            this.firstNameId = param7;
            this.lastNameId = param8;
            this.level = param9;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.firstNameId = 0;
            this.lastNameId = 0;
            this.level = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameFightTaxCollectorInformations(param1);
            return;
        }// end function

        public function serializeAs_GameFightTaxCollectorInformations(param1:IDataOutput) : void
        {
            super.serializeAs_GameFightAIInformations(param1);
            if (this.firstNameId < 0)
            {
                throw new Error("Forbidden value (" + this.firstNameId + ") on element firstNameId.");
            }
            param1.writeShort(this.firstNameId);
            if (this.lastNameId < 0)
            {
                throw new Error("Forbidden value (" + this.lastNameId + ") on element lastNameId.");
            }
            param1.writeShort(this.lastNameId);
            if (this.level < 0)
            {
                throw new Error("Forbidden value (" + this.level + ") on element level.");
            }
            param1.writeShort(this.level);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightTaxCollectorInformations(param1);
            return;
        }// end function

        public function deserializeAs_GameFightTaxCollectorInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.firstNameId = param1.readShort();
            if (this.firstNameId < 0)
            {
                throw new Error("Forbidden value (" + this.firstNameId + ") on element of GameFightTaxCollectorInformations.firstNameId.");
            }
            this.lastNameId = param1.readShort();
            if (this.lastNameId < 0)
            {
                throw new Error("Forbidden value (" + this.lastNameId + ") on element of GameFightTaxCollectorInformations.lastNameId.");
            }
            this.level = param1.readShort();
            if (this.level < 0)
            {
                throw new Error("Forbidden value (" + this.level + ") on element of GameFightTaxCollectorInformations.level.");
            }
            return;
        }// end function

    }
}
