package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class GameFightFighterTaxCollectorLightInformations extends GameFightFighterLightInformations implements INetworkType 
    {

        public static const protocolId:uint = 457;

        public var firstNameId:uint = 0;
        public var lastNameId:uint = 0;


        override public function getTypeId():uint
        {
            return (457);
        }

        public function initGameFightFighterTaxCollectorLightInformations(id:int=0, wave:uint=0, level:uint=0, breed:int=0, sex:Boolean=false, alive:Boolean=false, firstNameId:uint=0, lastNameId:uint=0):GameFightFighterTaxCollectorLightInformations
        {
            super.initGameFightFighterLightInformations(id, wave, level, breed, sex, alive);
            this.firstNameId = firstNameId;
            this.lastNameId = lastNameId;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.firstNameId = 0;
            this.lastNameId = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameFightFighterTaxCollectorLightInformations(output);
        }

        public function serializeAs_GameFightFighterTaxCollectorLightInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_GameFightFighterLightInformations(output);
            if (this.firstNameId < 0)
            {
                throw (new Error((("Forbidden value (" + this.firstNameId) + ") on element firstNameId.")));
            };
            output.writeVarShort(this.firstNameId);
            if (this.lastNameId < 0)
            {
                throw (new Error((("Forbidden value (" + this.lastNameId) + ") on element lastNameId.")));
            };
            output.writeVarShort(this.lastNameId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightFighterTaxCollectorLightInformations(input);
        }

        public function deserializeAs_GameFightFighterTaxCollectorLightInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.firstNameId = input.readVarUhShort();
            if (this.firstNameId < 0)
            {
                throw (new Error((("Forbidden value (" + this.firstNameId) + ") on element of GameFightFighterTaxCollectorLightInformations.firstNameId.")));
            };
            this.lastNameId = input.readVarUhShort();
            if (this.lastNameId < 0)
            {
                throw (new Error((("Forbidden value (" + this.lastNameId) + ") on element of GameFightFighterTaxCollectorLightInformations.lastNameId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.fight

