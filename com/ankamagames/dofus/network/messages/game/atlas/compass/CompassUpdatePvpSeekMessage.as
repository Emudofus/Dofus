package com.ankamagames.dofus.network.messages.game.atlas.compass
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.MapCoordinates;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class CompassUpdatePvpSeekMessage extends CompassUpdateMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6013;

        private var _isInitialized:Boolean = false;
        public var memberId:uint = 0;
        public var memberName:String = "";


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6013);
        }

        public function initCompassUpdatePvpSeekMessage(type:uint=0, coords:MapCoordinates=null, memberId:uint=0, memberName:String=""):CompassUpdatePvpSeekMessage
        {
            super.initCompassUpdateMessage(type, coords);
            this.memberId = memberId;
            this.memberName = memberName;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.memberId = 0;
            this.memberName = "";
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
            this.serializeAs_CompassUpdatePvpSeekMessage(output);
        }

        public function serializeAs_CompassUpdatePvpSeekMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_CompassUpdateMessage(output);
            if (this.memberId < 0)
            {
                throw (new Error((("Forbidden value (" + this.memberId) + ") on element memberId.")));
            };
            output.writeVarInt(this.memberId);
            output.writeUTF(this.memberName);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CompassUpdatePvpSeekMessage(input);
        }

        public function deserializeAs_CompassUpdatePvpSeekMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.memberId = input.readVarUhInt();
            if (this.memberId < 0)
            {
                throw (new Error((("Forbidden value (" + this.memberId) + ") on element of CompassUpdatePvpSeekMessage.memberId.")));
            };
            this.memberName = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.atlas.compass

