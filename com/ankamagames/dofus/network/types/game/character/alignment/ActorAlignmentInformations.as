package com.ankamagames.dofus.network.types.game.character.alignment
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ActorAlignmentInformations extends Object implements INetworkType
    {
        public var alignmentSide:int = 0;
        public var alignmentValue:uint = 0;
        public var alignmentGrade:uint = 0;
        public var dishonor:uint = 0;
        public var characterPower:uint = 0;
        public static const protocolId:uint = 201;

        public function ActorAlignmentInformations()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 201;
        }// end function

        public function initActorAlignmentInformations(param1:int = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0, param5:uint = 0) : ActorAlignmentInformations
        {
            this.alignmentSide = param1;
            this.alignmentValue = param2;
            this.alignmentGrade = param3;
            this.dishonor = param4;
            this.characterPower = param5;
            return this;
        }// end function

        public function reset() : void
        {
            this.alignmentSide = 0;
            this.alignmentValue = 0;
            this.alignmentGrade = 0;
            this.dishonor = 0;
            this.characterPower = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ActorAlignmentInformations(param1);
            return;
        }// end function

        public function serializeAs_ActorAlignmentInformations(param1:IDataOutput) : void
        {
            param1.writeByte(this.alignmentSide);
            if (this.alignmentValue < 0)
            {
                throw new Error("Forbidden value (" + this.alignmentValue + ") on element alignmentValue.");
            }
            param1.writeByte(this.alignmentValue);
            if (this.alignmentGrade < 0)
            {
                throw new Error("Forbidden value (" + this.alignmentGrade + ") on element alignmentGrade.");
            }
            param1.writeByte(this.alignmentGrade);
            if (this.dishonor < 0 || this.dishonor > 500)
            {
                throw new Error("Forbidden value (" + this.dishonor + ") on element dishonor.");
            }
            param1.writeShort(this.dishonor);
            if (this.characterPower < 0)
            {
                throw new Error("Forbidden value (" + this.characterPower + ") on element characterPower.");
            }
            param1.writeInt(this.characterPower);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ActorAlignmentInformations(param1);
            return;
        }// end function

        public function deserializeAs_ActorAlignmentInformations(param1:IDataInput) : void
        {
            this.alignmentSide = param1.readByte();
            this.alignmentValue = param1.readByte();
            if (this.alignmentValue < 0)
            {
                throw new Error("Forbidden value (" + this.alignmentValue + ") on element of ActorAlignmentInformations.alignmentValue.");
            }
            this.alignmentGrade = param1.readByte();
            if (this.alignmentGrade < 0)
            {
                throw new Error("Forbidden value (" + this.alignmentGrade + ") on element of ActorAlignmentInformations.alignmentGrade.");
            }
            this.dishonor = param1.readUnsignedShort();
            if (this.dishonor < 0 || this.dishonor > 500)
            {
                throw new Error("Forbidden value (" + this.dishonor + ") on element of ActorAlignmentInformations.dishonor.");
            }
            this.characterPower = param1.readInt();
            if (this.characterPower < 0)
            {
                throw new Error("Forbidden value (" + this.characterPower + ") on element of ActorAlignmentInformations.characterPower.");
            }
            return;
        }// end function

    }
}
