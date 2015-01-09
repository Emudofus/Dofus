package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class GameFightTaxCollectorInformations extends GameFightAIInformations implements INetworkType 
    {

        public static const protocolId:uint = 48;

        public var firstNameId:uint = 0;
        public var lastNameId:uint = 0;
        public var level:uint = 0;


        override public function getTypeId():uint
        {
            return (48);
        }

        public function initGameFightTaxCollectorInformations(contextualId:int=0, look:EntityLook=null, disposition:EntityDispositionInformations=null, teamId:uint=2, wave:uint=0, alive:Boolean=false, stats:GameFightMinimalStats=null, previousPositions:Vector.<uint>=null, firstNameId:uint=0, lastNameId:uint=0, level:uint=0):GameFightTaxCollectorInformations
        {
            super.initGameFightAIInformations(contextualId, look, disposition, teamId, wave, alive, stats, previousPositions);
            this.firstNameId = firstNameId;
            this.lastNameId = lastNameId;
            this.level = level;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.firstNameId = 0;
            this.lastNameId = 0;
            this.level = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameFightTaxCollectorInformations(output);
        }

        public function serializeAs_GameFightTaxCollectorInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_GameFightAIInformations(output);
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
            if ((((this.level < 0)) || ((this.level > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.level) + ") on element level.")));
            };
            output.writeByte(this.level);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightTaxCollectorInformations(input);
        }

        public function deserializeAs_GameFightTaxCollectorInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.firstNameId = input.readVarUhShort();
            if (this.firstNameId < 0)
            {
                throw (new Error((("Forbidden value (" + this.firstNameId) + ") on element of GameFightTaxCollectorInformations.firstNameId.")));
            };
            this.lastNameId = input.readVarUhShort();
            if (this.lastNameId < 0)
            {
                throw (new Error((("Forbidden value (" + this.lastNameId) + ") on element of GameFightTaxCollectorInformations.lastNameId.")));
            };
            this.level = input.readUnsignedByte();
            if ((((this.level < 0)) || ((this.level > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.level) + ") on element of GameFightTaxCollectorInformations.level.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.fight

