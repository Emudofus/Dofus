package com.ankamagames.dofus.network.types.game.character.alignment
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class ActorAlignmentInformations implements INetworkType 
    {

        public static const protocolId:uint = 201;

        public var alignmentSide:int = 0;
        public var alignmentValue:uint = 0;
        public var alignmentGrade:uint = 0;
        public var characterPower:uint = 0;


        public function getTypeId():uint
        {
            return (201);
        }

        public function initActorAlignmentInformations(alignmentSide:int=0, alignmentValue:uint=0, alignmentGrade:uint=0, characterPower:uint=0):ActorAlignmentInformations
        {
            this.alignmentSide = alignmentSide;
            this.alignmentValue = alignmentValue;
            this.alignmentGrade = alignmentGrade;
            this.characterPower = characterPower;
            return (this);
        }

        public function reset():void
        {
            this.alignmentSide = 0;
            this.alignmentValue = 0;
            this.alignmentGrade = 0;
            this.characterPower = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ActorAlignmentInformations(output);
        }

        public function serializeAs_ActorAlignmentInformations(output:ICustomDataOutput):void
        {
            output.writeByte(this.alignmentSide);
            if (this.alignmentValue < 0)
            {
                throw (new Error((("Forbidden value (" + this.alignmentValue) + ") on element alignmentValue.")));
            };
            output.writeByte(this.alignmentValue);
            if (this.alignmentGrade < 0)
            {
                throw (new Error((("Forbidden value (" + this.alignmentGrade) + ") on element alignmentGrade.")));
            };
            output.writeByte(this.alignmentGrade);
            if (this.characterPower < 0)
            {
                throw (new Error((("Forbidden value (" + this.characterPower) + ") on element characterPower.")));
            };
            output.writeVarInt(this.characterPower);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ActorAlignmentInformations(input);
        }

        public function deserializeAs_ActorAlignmentInformations(input:ICustomDataInput):void
        {
            this.alignmentSide = input.readByte();
            this.alignmentValue = input.readByte();
            if (this.alignmentValue < 0)
            {
                throw (new Error((("Forbidden value (" + this.alignmentValue) + ") on element of ActorAlignmentInformations.alignmentValue.")));
            };
            this.alignmentGrade = input.readByte();
            if (this.alignmentGrade < 0)
            {
                throw (new Error((("Forbidden value (" + this.alignmentGrade) + ") on element of ActorAlignmentInformations.alignmentGrade.")));
            };
            this.characterPower = input.readVarUhInt();
            if (this.characterPower < 0)
            {
                throw (new Error((("Forbidden value (" + this.characterPower) + ") on element of ActorAlignmentInformations.characterPower.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.character.alignment

