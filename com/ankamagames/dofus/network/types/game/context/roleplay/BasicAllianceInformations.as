package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.dofus.network.types.game.social.AbstractSocialGroupInfos;
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class BasicAllianceInformations extends AbstractSocialGroupInfos implements INetworkType 
    {

        public static const protocolId:uint = 419;

        public var allianceId:uint = 0;
        public var allianceTag:String = "";


        override public function getTypeId():uint
        {
            return (419);
        }

        public function initBasicAllianceInformations(allianceId:uint=0, allianceTag:String=""):BasicAllianceInformations
        {
            this.allianceId = allianceId;
            this.allianceTag = allianceTag;
            return (this);
        }

        override public function reset():void
        {
            this.allianceId = 0;
            this.allianceTag = "";
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_BasicAllianceInformations(output);
        }

        public function serializeAs_BasicAllianceInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractSocialGroupInfos(output);
            if (this.allianceId < 0)
            {
                throw (new Error((("Forbidden value (" + this.allianceId) + ") on element allianceId.")));
            };
            output.writeVarInt(this.allianceId);
            output.writeUTF(this.allianceTag);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_BasicAllianceInformations(input);
        }

        public function deserializeAs_BasicAllianceInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.allianceId = input.readVarUhInt();
            if (this.allianceId < 0)
            {
                throw (new Error((("Forbidden value (" + this.allianceId) + ") on element of BasicAllianceInformations.allianceId.")));
            };
            this.allianceTag = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay

