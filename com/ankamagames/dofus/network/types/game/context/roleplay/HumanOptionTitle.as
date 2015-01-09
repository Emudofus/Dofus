package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class HumanOptionTitle extends HumanOption implements INetworkType 
    {

        public static const protocolId:uint = 408;

        public var titleId:uint = 0;
        public var titleParam:String = "";


        override public function getTypeId():uint
        {
            return (408);
        }

        public function initHumanOptionTitle(titleId:uint=0, titleParam:String=""):HumanOptionTitle
        {
            this.titleId = titleId;
            this.titleParam = titleParam;
            return (this);
        }

        override public function reset():void
        {
            this.titleId = 0;
            this.titleParam = "";
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_HumanOptionTitle(output);
        }

        public function serializeAs_HumanOptionTitle(output:ICustomDataOutput):void
        {
            super.serializeAs_HumanOption(output);
            if (this.titleId < 0)
            {
                throw (new Error((("Forbidden value (" + this.titleId) + ") on element titleId.")));
            };
            output.writeVarShort(this.titleId);
            output.writeUTF(this.titleParam);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_HumanOptionTitle(input);
        }

        public function deserializeAs_HumanOptionTitle(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.titleId = input.readVarUhShort();
            if (this.titleId < 0)
            {
                throw (new Error((("Forbidden value (" + this.titleId) + ") on element of HumanOptionTitle.titleId.")));
            };
            this.titleParam = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay

