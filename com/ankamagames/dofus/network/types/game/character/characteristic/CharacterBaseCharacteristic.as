package com.ankamagames.dofus.network.types.game.character.characteristic
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class CharacterBaseCharacteristic implements INetworkType 
    {

        public static const protocolId:uint = 4;

        public var base:int = 0;
        public var additionnal:int = 0;
        public var objectsAndMountBonus:int = 0;
        public var alignGiftBonus:int = 0;
        public var contextModif:int = 0;


        public function getTypeId():uint
        {
            return (4);
        }

        public function initCharacterBaseCharacteristic(base:int=0, additionnal:int=0, objectsAndMountBonus:int=0, alignGiftBonus:int=0, contextModif:int=0):CharacterBaseCharacteristic
        {
            this.base = base;
            this.additionnal = additionnal;
            this.objectsAndMountBonus = objectsAndMountBonus;
            this.alignGiftBonus = alignGiftBonus;
            this.contextModif = contextModif;
            return (this);
        }

        public function reset():void
        {
            this.base = 0;
            this.additionnal = 0;
            this.objectsAndMountBonus = 0;
            this.alignGiftBonus = 0;
            this.contextModif = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_CharacterBaseCharacteristic(output);
        }

        public function serializeAs_CharacterBaseCharacteristic(output:ICustomDataOutput):void
        {
            output.writeVarShort(this.base);
            output.writeVarShort(this.additionnal);
            output.writeVarShort(this.objectsAndMountBonus);
            output.writeVarShort(this.alignGiftBonus);
            output.writeVarShort(this.contextModif);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CharacterBaseCharacteristic(input);
        }

        public function deserializeAs_CharacterBaseCharacteristic(input:ICustomDataInput):void
        {
            this.base = input.readVarShort();
            this.additionnal = input.readVarShort();
            this.objectsAndMountBonus = input.readVarShort();
            this.alignGiftBonus = input.readVarShort();
            this.contextModif = input.readVarShort();
        }


    }
}//package com.ankamagames.dofus.network.types.game.character.characteristic

