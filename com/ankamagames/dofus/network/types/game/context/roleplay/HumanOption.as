package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class HumanOption implements INetworkType 
    {

        public static const protocolId:uint = 406;


        public function getTypeId():uint
        {
            return (406);
        }

        public function initHumanOption():HumanOption
        {
            return (this);
        }

        public function reset():void
        {
        }

        public function serialize(output:ICustomDataOutput):void
        {
        }

        public function serializeAs_HumanOption(output:ICustomDataOutput):void
        {
        }

        public function deserialize(input:ICustomDataInput):void
        {
        }

        public function deserializeAs_HumanOption(input:ICustomDataInput):void
        {
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay

