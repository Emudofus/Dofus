package com.ankamagames.dofus.network.messages.game.context.roleplay.death
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class GameRolePlayPlayerLifeStatusMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5996;

        private var _isInitialized:Boolean = false;
        public var state:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5996);
        }

        public function initGameRolePlayPlayerLifeStatusMessage(state:uint=0):GameRolePlayPlayerLifeStatusMessage
        {
            this.state = state;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.state = 0;
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

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_GameRolePlayPlayerLifeStatusMessage(output);
        }

        public function serializeAs_GameRolePlayPlayerLifeStatusMessage(output:IDataOutput):void
        {
            output.writeByte(this.state);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_GameRolePlayPlayerLifeStatusMessage(input);
        }

        public function deserializeAs_GameRolePlayPlayerLifeStatusMessage(input:IDataInput):void
        {
            this.state = input.readByte();
            if (this.state < 0)
            {
                throw (new Error((("Forbidden value (" + this.state) + ") on element of GameRolePlayPlayerLifeStatusMessage.state.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.death

