package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class HumanOptionTitle extends HumanOption implements INetworkType
    {
        public var titleId:uint = 0;
        public var titleParam:String = "";
        public static const protocolId:uint = 408;

        public function HumanOptionTitle()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 408;
        }// end function

        public function initHumanOptionTitle(param1:uint = 0, param2:String = "") : HumanOptionTitle
        {
            this.titleId = param1;
            this.titleParam = param2;
            return this;
        }// end function

        override public function reset() : void
        {
            this.titleId = 0;
            this.titleParam = "";
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_HumanOptionTitle(param1);
            return;
        }// end function

        public function serializeAs_HumanOptionTitle(param1:IDataOutput) : void
        {
            super.serializeAs_HumanOption(param1);
            if (this.titleId < 0)
            {
                throw new Error("Forbidden value (" + this.titleId + ") on element titleId.");
            }
            param1.writeShort(this.titleId);
            param1.writeUTF(this.titleParam);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_HumanOptionTitle(param1);
            return;
        }// end function

        public function deserializeAs_HumanOptionTitle(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.titleId = param1.readShort();
            if (this.titleId < 0)
            {
                throw new Error("Forbidden value (" + this.titleId + ") on element of HumanOptionTitle.titleId.");
            }
            this.titleParam = param1.readUTF();
            return;
        }// end function

    }
}
