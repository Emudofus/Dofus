package com.ankamagames.dofus.network.messages.game.context
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameCautiousMapMovementRequestMessage extends GameMapMovementRequestMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6496;

        private var _isInitialized:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6496);
        }

        public function initGameCautiousMapMovementRequestMessage(keyMovements:Vector.<uint>=null, mapId:uint=0):GameCautiousMapMovementRequestMessage
        {
            super.initGameMapMovementRequestMessage(keyMovements, mapId);
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            if (HASH_FUNCTION != null)
            {
                HASH_FUNCTION(data);
            };
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameCautiousMapMovementRequestMessage(output);
        }

        public function serializeAs_GameCautiousMapMovementRequestMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_GameMapMovementRequestMessage(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameCautiousMapMovementRequestMessage(input);
        }

        public function deserializeAs_GameCautiousMapMovementRequestMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context

