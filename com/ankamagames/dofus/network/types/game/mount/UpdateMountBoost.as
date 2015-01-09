package com.ankamagames.dofus.network.types.game.mount
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class UpdateMountBoost implements INetworkType 
    {

        public static const protocolId:uint = 356;

        public var type:uint = 0;


        public function getTypeId():uint
        {
            return (356);
        }

        public function initUpdateMountBoost(type:uint=0):UpdateMountBoost
        {
            this.type = type;
            return (this);
        }

        public function reset():void
        {
            this.type = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_UpdateMountBoost(output);
        }

        public function serializeAs_UpdateMountBoost(output:ICustomDataOutput):void
        {
            output.writeByte(this.type);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_UpdateMountBoost(input);
        }

        public function deserializeAs_UpdateMountBoost(input:ICustomDataInput):void
        {
            this.type = input.readByte();
            if (this.type < 0)
            {
                throw (new Error((("Forbidden value (" + this.type) + ") on element of UpdateMountBoost.type.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.mount

