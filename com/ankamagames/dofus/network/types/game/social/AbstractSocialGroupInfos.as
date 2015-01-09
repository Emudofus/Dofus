package com.ankamagames.dofus.network.types.game.social
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class AbstractSocialGroupInfos implements INetworkType 
    {

        public static const protocolId:uint = 416;


        public function getTypeId():uint
        {
            return (416);
        }

        public function initAbstractSocialGroupInfos():AbstractSocialGroupInfos
        {
            return (this);
        }

        public function reset():void
        {
        }

        public function serialize(output:ICustomDataOutput):void
        {
        }

        public function serializeAs_AbstractSocialGroupInfos(output:ICustomDataOutput):void
        {
        }

        public function deserialize(input:ICustomDataInput):void
        {
        }

        public function deserializeAs_AbstractSocialGroupInfos(input:ICustomDataInput):void
        {
        }


    }
}//package com.ankamagames.dofus.network.types.game.social

