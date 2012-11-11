package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class FightResultPvpData extends FightResultAdditionalData implements INetworkType
    {
        public var grade:uint = 0;
        public var minHonorForGrade:uint = 0;
        public var maxHonorForGrade:uint = 0;
        public var honor:uint = 0;
        public var honorDelta:int = 0;
        public var dishonor:uint = 0;
        public var dishonorDelta:int = 0;
        public static const protocolId:uint = 190;

        public function FightResultPvpData()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 190;
        }// end function

        public function initFightResultPvpData(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0, param5:int = 0, param6:uint = 0, param7:int = 0) : FightResultPvpData
        {
            this.grade = param1;
            this.minHonorForGrade = param2;
            this.maxHonorForGrade = param3;
            this.honor = param4;
            this.honorDelta = param5;
            this.dishonor = param6;
            this.dishonorDelta = param7;
            return this;
        }// end function

        override public function reset() : void
        {
            this.grade = 0;
            this.minHonorForGrade = 0;
            this.maxHonorForGrade = 0;
            this.honor = 0;
            this.honorDelta = 0;
            this.dishonor = 0;
            this.dishonorDelta = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_FightResultPvpData(param1);
            return;
        }// end function

        public function serializeAs_FightResultPvpData(param1:IDataOutput) : void
        {
            super.serializeAs_FightResultAdditionalData(param1);
            if (this.grade < 0 || this.grade > 255)
            {
                throw new Error("Forbidden value (" + this.grade + ") on element grade.");
            }
            param1.writeByte(this.grade);
            if (this.minHonorForGrade < 0 || this.minHonorForGrade > 20000)
            {
                throw new Error("Forbidden value (" + this.minHonorForGrade + ") on element minHonorForGrade.");
            }
            param1.writeShort(this.minHonorForGrade);
            if (this.maxHonorForGrade < 0 || this.maxHonorForGrade > 20000)
            {
                throw new Error("Forbidden value (" + this.maxHonorForGrade + ") on element maxHonorForGrade.");
            }
            param1.writeShort(this.maxHonorForGrade);
            if (this.honor < 0 || this.honor > 20000)
            {
                throw new Error("Forbidden value (" + this.honor + ") on element honor.");
            }
            param1.writeShort(this.honor);
            param1.writeShort(this.honorDelta);
            if (this.dishonor < 0 || this.dishonor > 500)
            {
                throw new Error("Forbidden value (" + this.dishonor + ") on element dishonor.");
            }
            param1.writeShort(this.dishonor);
            param1.writeShort(this.dishonorDelta);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_FightResultPvpData(param1);
            return;
        }// end function

        public function deserializeAs_FightResultPvpData(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.grade = param1.readUnsignedByte();
            if (this.grade < 0 || this.grade > 255)
            {
                throw new Error("Forbidden value (" + this.grade + ") on element of FightResultPvpData.grade.");
            }
            this.minHonorForGrade = param1.readUnsignedShort();
            if (this.minHonorForGrade < 0 || this.minHonorForGrade > 20000)
            {
                throw new Error("Forbidden value (" + this.minHonorForGrade + ") on element of FightResultPvpData.minHonorForGrade.");
            }
            this.maxHonorForGrade = param1.readUnsignedShort();
            if (this.maxHonorForGrade < 0 || this.maxHonorForGrade > 20000)
            {
                throw new Error("Forbidden value (" + this.maxHonorForGrade + ") on element of FightResultPvpData.maxHonorForGrade.");
            }
            this.honor = param1.readUnsignedShort();
            if (this.honor < 0 || this.honor > 20000)
            {
                throw new Error("Forbidden value (" + this.honor + ") on element of FightResultPvpData.honor.");
            }
            this.honorDelta = param1.readShort();
            this.dishonor = param1.readUnsignedShort();
            if (this.dishonor < 0 || this.dishonor > 500)
            {
                throw new Error("Forbidden value (" + this.dishonor + ") on element of FightResultPvpData.dishonor.");
            }
            this.dishonorDelta = param1.readShort();
            return;
        }// end function

    }
}
