package com.ankamagames.dofus.network.messages.game.context
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.ActorOrientation;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameMapChangeOrientationMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 946;

        private var _isInitialized:Boolean = false;
        public var orientation:ActorOrientation;

        public function GameMapChangeOrientationMessage()
        {
            this.orientation = new ActorOrientation();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (946);
        }

        public function initGameMapChangeOrientationMessage(orientation:ActorOrientation=null):GameMapChangeOrientationMessage
        {
            this.orientation = orientation;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.orientation = new ActorOrientation();
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

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameMapChangeOrientationMessage(output);
        }

        public function serializeAs_GameMapChangeOrientationMessage(output:ICustomDataOutput):void
        {
            this.orientation.serializeAs_ActorOrientation(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameMapChangeOrientationMessage(input);
        }

        public function deserializeAs_GameMapChangeOrientationMessage(input:ICustomDataInput):void
        {
            this.orientation = new ActorOrientation();
            this.orientation.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context

