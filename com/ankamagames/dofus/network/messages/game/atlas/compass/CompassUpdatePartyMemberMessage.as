package com.ankamagames.dofus.network.messages.game.atlas.compass
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.MapCoordinates;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class CompassUpdatePartyMemberMessage extends CompassUpdateMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5589;

        private var _isInitialized:Boolean = false;
        public var memberId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5589);
        }

        public function initCompassUpdatePartyMemberMessage(type:uint=0, coords:MapCoordinates=null, memberId:uint=0):CompassUpdatePartyMemberMessage
        {
            super.initCompassUpdateMessage(type, coords);
            this.memberId = memberId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.memberId = 0;
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_CompassUpdatePartyMemberMessage(output);
        }

        public function serializeAs_CompassUpdatePartyMemberMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_CompassUpdateMessage(output);
            if (this.memberId < 0)
            {
                throw (new Error((("Forbidden value (" + this.memberId) + ") on element memberId.")));
            };
            output.writeVarInt(this.memberId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CompassUpdatePartyMemberMessage(input);
        }

        public function deserializeAs_CompassUpdatePartyMemberMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.memberId = input.readVarUhInt();
            if (this.memberId < 0)
            {
                throw (new Error((("Forbidden value (" + this.memberId) + ") on element of CompassUpdatePartyMemberMessage.memberId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.atlas.compass

