package com.ankamagames.dofus.network.messages.game.context
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.EntityMovementInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameContextMoveElementMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 253;

        private var _isInitialized:Boolean = false;
        public var movement:EntityMovementInformations;

        public function GameContextMoveElementMessage()
        {
            this.movement = new EntityMovementInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (253);
        }

        public function initGameContextMoveElementMessage(movement:EntityMovementInformations=null):GameContextMoveElementMessage
        {
            this.movement = movement;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.movement = new EntityMovementInformations();
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
            this.serializeAs_GameContextMoveElementMessage(output);
        }

        public function serializeAs_GameContextMoveElementMessage(output:ICustomDataOutput):void
        {
            this.movement.serializeAs_EntityMovementInformations(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameContextMoveElementMessage(input);
        }

        public function deserializeAs_GameContextMoveElementMessage(input:ICustomDataInput):void
        {
            this.movement = new EntityMovementInformations();
            this.movement.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context

