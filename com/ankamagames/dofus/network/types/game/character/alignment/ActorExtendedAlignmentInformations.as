package com.ankamagames.dofus.network.types.game.character.alignment
{
    import com.ankamagames.jerakine.network.INetworkType;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    public class ActorExtendedAlignmentInformations extends ActorAlignmentInformations implements INetworkType 
    {

        public static const protocolId:uint = 202;

        public var honor:uint = 0;
        public var honorGradeFloor:uint = 0;
        public var honorNextGradeFloor:uint = 0;
        public var aggressable:uint = 0;


        override public function getTypeId():uint
        {
            return (202);
        }

        public function initActorExtendedAlignmentInformations(alignmentSide:int=0, alignmentValue:uint=0, alignmentGrade:uint=0, characterPower:uint=0, honor:uint=0, honorGradeFloor:uint=0, honorNextGradeFloor:uint=0, aggressable:uint=0):ActorExtendedAlignmentInformations
        {
            super.initActorAlignmentInformations(alignmentSide, alignmentValue, alignmentGrade, characterPower);
            this.honor = honor;
            this.honorGradeFloor = honorGradeFloor;
            this.honorNextGradeFloor = honorNextGradeFloor;
            this.aggressable = aggressable;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.honor = 0;
            this.honorGradeFloor = 0;
            this.honorNextGradeFloor = 0;
            this.aggressable = 0;
        }

        override public function serialize(output:IDataOutput):void
        {
            this.serializeAs_ActorExtendedAlignmentInformations(output);
        }

        public function serializeAs_ActorExtendedAlignmentInformations(output:IDataOutput):void
        {
            super.serializeAs_ActorAlignmentInformations(output);
            if ((((this.honor < 0)) || ((this.honor > 20000))))
            {
                throw (new Error((("Forbidden value (" + this.honor) + ") on element honor.")));
            };
            output.writeShort(this.honor);
            if ((((this.honorGradeFloor < 0)) || ((this.honorGradeFloor > 20000))))
            {
                throw (new Error((("Forbidden value (" + this.honorGradeFloor) + ") on element honorGradeFloor.")));
            };
            output.writeShort(this.honorGradeFloor);
            if ((((this.honorNextGradeFloor < 0)) || ((this.honorNextGradeFloor > 20000))))
            {
                throw (new Error((("Forbidden value (" + this.honorNextGradeFloor) + ") on element honorNextGradeFloor.")));
            };
            output.writeShort(this.honorNextGradeFloor);
            output.writeByte(this.aggressable);
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_ActorExtendedAlignmentInformations(input);
        }

        public function deserializeAs_ActorExtendedAlignmentInformations(input:IDataInput):void
        {
            super.deserialize(input);
            this.honor = input.readUnsignedShort();
            if ((((this.honor < 0)) || ((this.honor > 20000))))
            {
                throw (new Error((("Forbidden value (" + this.honor) + ") on element of ActorExtendedAlignmentInformations.honor.")));
            };
            this.honorGradeFloor = input.readUnsignedShort();
            if ((((this.honorGradeFloor < 0)) || ((this.honorGradeFloor > 20000))))
            {
                throw (new Error((("Forbidden value (" + this.honorGradeFloor) + ") on element of ActorExtendedAlignmentInformations.honorGradeFloor.")));
            };
            this.honorNextGradeFloor = input.readUnsignedShort();
            if ((((this.honorNextGradeFloor < 0)) || ((this.honorNextGradeFloor > 20000))))
            {
                throw (new Error((("Forbidden value (" + this.honorNextGradeFloor) + ") on element of ActorExtendedAlignmentInformations.honorNextGradeFloor.")));
            };
            this.aggressable = input.readByte();
            if (this.aggressable < 0)
            {
                throw (new Error((("Forbidden value (" + this.aggressable) + ") on element of ActorExtendedAlignmentInformations.aggressable.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.character.alignment

