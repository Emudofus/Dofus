package com.ankamagames.dofus.network.messages.game.atlas.compass
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.MapCoordinates;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

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

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        override public function serialize(output:IDataOutput):void
        {
            this.serializeAs_CompassUpdatePvpSeekMessage(output);
        }

        public function serializeAs_CompassUpdatePvpSeekMessage(output:IDataOutput):void
        {
            super.serializeAs_CompassUpdateMessage(output);
            if (this.memberId < 0)
            {
                throw (new Error((("Forbidden value (" + this.memberId) + ") on element memberId.")));
            };
            output.writeInt(this.memberId);
            output.writeUTF(this.memberName);
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_CompassUpdatePvpSeekMessage(input);
        }

        public function deserializeAs_CompassUpdatePvpSeekMessage(input:IDataInput):void
        {
            super.deserialize(input);
            this.memberId = input.readInt();
            if (this.memberId < 0)
            {
                throw (new Error((("Forbidden value (" + this.memberId) + ") on element of CompassUpdatePvpSeekMessage.memberId.")));
            };
            this.memberName = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.atlas.compass

