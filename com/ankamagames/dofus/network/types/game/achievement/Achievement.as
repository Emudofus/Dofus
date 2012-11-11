package com.ankamagames.dofus.network.types.game.achievement
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class Achievement extends Object implements INetworkType
    {
        public var id:uint = 0;
        public static const protocolId:uint = 363;

        public function Achievement()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 363;
        }// end function

        public function initAchievement(param1:uint = 0) : Achievement
        {
            this.id = param1;
            return this;
        }// end function

        public function reset() : void
        {
            this.id = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_Achievement(param1);
            return;
        }// end function

        public function serializeAs_Achievement(param1:IDataOutput) : void
        {
            if (this.id < 0)
            {
                throw new Error("Forbidden value (" + this.id + ") on element id.");
            }
            param1.writeShort(this.id);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_Achievement(param1);
            return;
        }// end function

        public function deserializeAs_Achievement(param1:IDataInput) : void
        {
            this.id = param1.readShort();
            if (this.id < 0)
            {
                throw new Error("Forbidden value (" + this.id + ") on element of Achievement.id.");
            }
            return;
        }// end function

    }
}
