package com.ankamagames.dofus.network.types.game.character.alignment
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ActorExtendedAlignmentInformations extends ActorAlignmentInformations implements INetworkType
    {
        public var honor:uint = 0;
        public var honorGradeFloor:uint = 0;
        public var honorNextGradeFloor:uint = 0;
        public var pvpEnabled:Boolean = false;
        public static const protocolId:uint = 202;

        public function ActorExtendedAlignmentInformations()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 202;
        }// end function

        public function initActorExtendedAlignmentInformations(param1:int = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0, param5:uint = 0, param6:uint = 0, param7:uint = 0, param8:uint = 0, param9:Boolean = false) : ActorExtendedAlignmentInformations
        {
            super.initActorAlignmentInformations(param1, param2, param3, param4, param5);
            this.honor = param6;
            this.honorGradeFloor = param7;
            this.honorNextGradeFloor = param8;
            this.pvpEnabled = param9;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.honor = 0;
            this.honorGradeFloor = 0;
            this.honorNextGradeFloor = 0;
            this.pvpEnabled = false;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ActorExtendedAlignmentInformations(param1);
            return;
        }// end function

        public function serializeAs_ActorExtendedAlignmentInformations(param1:IDataOutput) : void
        {
            super.serializeAs_ActorAlignmentInformations(param1);
            if (this.honor < 0 || this.honor > 20000)
            {
                throw new Error("Forbidden value (" + this.honor + ") on element honor.");
            }
            param1.writeShort(this.honor);
            if (this.honorGradeFloor < 0 || this.honorGradeFloor > 20000)
            {
                throw new Error("Forbidden value (" + this.honorGradeFloor + ") on element honorGradeFloor.");
            }
            param1.writeShort(this.honorGradeFloor);
            if (this.honorNextGradeFloor < 0 || this.honorNextGradeFloor > 20000)
            {
                throw new Error("Forbidden value (" + this.honorNextGradeFloor + ") on element honorNextGradeFloor.");
            }
            param1.writeShort(this.honorNextGradeFloor);
            param1.writeBoolean(this.pvpEnabled);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ActorExtendedAlignmentInformations(param1);
            return;
        }// end function

        public function deserializeAs_ActorExtendedAlignmentInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.honor = param1.readUnsignedShort();
            if (this.honor < 0 || this.honor > 20000)
            {
                throw new Error("Forbidden value (" + this.honor + ") on element of ActorExtendedAlignmentInformations.honor.");
            }
            this.honorGradeFloor = param1.readUnsignedShort();
            if (this.honorGradeFloor < 0 || this.honorGradeFloor > 20000)
            {
                throw new Error("Forbidden value (" + this.honorGradeFloor + ") on element of ActorExtendedAlignmentInformations.honorGradeFloor.");
            }
            this.honorNextGradeFloor = param1.readUnsignedShort();
            if (this.honorNextGradeFloor < 0 || this.honorNextGradeFloor > 20000)
            {
                throw new Error("Forbidden value (" + this.honorNextGradeFloor + ") on element of ActorExtendedAlignmentInformations.honorNextGradeFloor.");
            }
            this.pvpEnabled = param1.readBoolean();
            return;
        }// end function

    }
}
