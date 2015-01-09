package com.ankamagames.dofus.network.types.game.character.characteristic
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class CharacterSpellModification implements INetworkType 
    {

        public static const protocolId:uint = 215;

        public var modificationType:uint = 0;
        public var spellId:uint = 0;
        public var value:CharacterBaseCharacteristic;

        public function CharacterSpellModification()
        {
            this.value = new CharacterBaseCharacteristic();
            super();
        }

        public function getTypeId():uint
        {
            return (215);
        }

        public function initCharacterSpellModification(modificationType:uint=0, spellId:uint=0, value:CharacterBaseCharacteristic=null):CharacterSpellModification
        {
            this.modificationType = modificationType;
            this.spellId = spellId;
            this.value = value;
            return (this);
        }

        public function reset():void
        {
            this.modificationType = 0;
            this.spellId = 0;
            this.value = new CharacterBaseCharacteristic();
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_CharacterSpellModification(output);
        }

        public function serializeAs_CharacterSpellModification(output:ICustomDataOutput):void
        {
            output.writeByte(this.modificationType);
            if (this.spellId < 0)
            {
                throw (new Error((("Forbidden value (" + this.spellId) + ") on element spellId.")));
            };
            output.writeVarShort(this.spellId);
            this.value.serializeAs_CharacterBaseCharacteristic(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CharacterSpellModification(input);
        }

        public function deserializeAs_CharacterSpellModification(input:ICustomDataInput):void
        {
            this.modificationType = input.readByte();
            if (this.modificationType < 0)
            {
                throw (new Error((("Forbidden value (" + this.modificationType) + ") on element of CharacterSpellModification.modificationType.")));
            };
            this.spellId = input.readVarUhShort();
            if (this.spellId < 0)
            {
                throw (new Error((("Forbidden value (" + this.spellId) + ") on element of CharacterSpellModification.spellId.")));
            };
            this.value = new CharacterBaseCharacteristic();
            this.value.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.types.game.character.characteristic

