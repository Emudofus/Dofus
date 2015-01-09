package com.ankamagames.dofus.network.types.game.approach
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ServerSessionConstant implements INetworkType 
    {

        public static const protocolId:uint = 430;

        public var id:uint = 0;


        public function getTypeId():uint
        {
            return (430);
        }

        public function initServerSessionConstant(id:uint=0):ServerSessionConstant
        {
            this.id = id;
            return (this);
        }

        public function reset():void
        {
            this.id = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ServerSessionConstant(output);
        }

        public function serializeAs_ServerSessionConstant(output:ICustomDataOutput):void
        {
            if (this.id < 0)
            {
                throw (new Error((("Forbidden value (" + this.id) + ") on element id.")));
            };
            output.writeVarShort(this.id);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ServerSessionConstant(input);
        }

        public function deserializeAs_ServerSessionConstant(input:ICustomDataInput):void
        {
            this.id = input.readVarUhShort();
            if (this.id < 0)
            {
                throw (new Error((("Forbidden value (" + this.id) + ") on element of ServerSessionConstant.id.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.approach

