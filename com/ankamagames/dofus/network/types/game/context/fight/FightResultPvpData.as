package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class FightResultPvpData extends FightResultAdditionalData implements INetworkType 
    {

        public static const protocolId:uint = 190;

        public var grade:uint = 0;
        public var minHonorForGrade:uint = 0;
        public var maxHonorForGrade:uint = 0;
        public var honor:uint = 0;
        public var honorDelta:int = 0;


        override public function getTypeId():uint
        {
            return (190);
        }

        public function initFightResultPvpData(grade:uint=0, minHonorForGrade:uint=0, maxHonorForGrade:uint=0, honor:uint=0, honorDelta:int=0):FightResultPvpData
        {
            this.grade = grade;
            this.minHonorForGrade = minHonorForGrade;
            this.maxHonorForGrade = maxHonorForGrade;
            this.honor = honor;
            this.honorDelta = honorDelta;
            return (this);
        }

        override public function reset():void
        {
            this.grade = 0;
            this.minHonorForGrade = 0;
            this.maxHonorForGrade = 0;
            this.honor = 0;
            this.honorDelta = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_FightResultPvpData(output);
        }

        public function serializeAs_FightResultPvpData(output:ICustomDataOutput):void
        {
            super.serializeAs_FightResultAdditionalData(output);
            if ((((this.grade < 0)) || ((this.grade > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.grade) + ") on element grade.")));
            };
            output.writeByte(this.grade);
            if ((((this.minHonorForGrade < 0)) || ((this.minHonorForGrade > 20000))))
            {
                throw (new Error((("Forbidden value (" + this.minHonorForGrade) + ") on element minHonorForGrade.")));
            };
            output.writeVarShort(this.minHonorForGrade);
            if ((((this.maxHonorForGrade < 0)) || ((this.maxHonorForGrade > 20000))))
            {
                throw (new Error((("Forbidden value (" + this.maxHonorForGrade) + ") on element maxHonorForGrade.")));
            };
            output.writeVarShort(this.maxHonorForGrade);
            if ((((this.honor < 0)) || ((this.honor > 20000))))
            {
                throw (new Error((("Forbidden value (" + this.honor) + ") on element honor.")));
            };
            output.writeVarShort(this.honor);
            output.writeVarShort(this.honorDelta);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_FightResultPvpData(input);
        }

        public function deserializeAs_FightResultPvpData(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.grade = input.readUnsignedByte();
            if ((((this.grade < 0)) || ((this.grade > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.grade) + ") on element of FightResultPvpData.grade.")));
            };
            this.minHonorForGrade = input.readVarUhShort();
            if ((((this.minHonorForGrade < 0)) || ((this.minHonorForGrade > 20000))))
            {
                throw (new Error((("Forbidden value (" + this.minHonorForGrade) + ") on element of FightResultPvpData.minHonorForGrade.")));
            };
            this.maxHonorForGrade = input.readVarUhShort();
            if ((((this.maxHonorForGrade < 0)) || ((this.maxHonorForGrade > 20000))))
            {
                throw (new Error((("Forbidden value (" + this.maxHonorForGrade) + ") on element of FightResultPvpData.maxHonorForGrade.")));
            };
            this.honor = input.readVarUhShort();
            if ((((this.honor < 0)) || ((this.honor > 20000))))
            {
                throw (new Error((("Forbidden value (" + this.honor) + ") on element of FightResultPvpData.honor.")));
            };
            this.honorDelta = input.readVarShort();
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.fight

