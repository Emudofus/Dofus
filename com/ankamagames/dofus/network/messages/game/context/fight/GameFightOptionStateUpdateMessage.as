package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameFightOptionStateUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5927;

        private var _isInitialized:Boolean = false;
        public var fightId:uint = 0;
        public var teamId:uint = 2;
        public var option:uint = 3;
        public var state:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5927);
        }

        public function initGameFightOptionStateUpdateMessage(fightId:uint=0, teamId:uint=2, option:uint=3, state:Boolean=false):GameFightOptionStateUpdateMessage
        {
            this.fightId = fightId;
            this.teamId = teamId;
            this.option = option;
            this.state = state;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.fightId = 0;
            this.teamId = 2;
            this.option = 3;
            this.state = false;
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
            this.serializeAs_GameFightOptionStateUpdateMessage(output);
        }

        public function serializeAs_GameFightOptionStateUpdateMessage(output:ICustomDataOutput):void
        {
            if (this.fightId < 0)
            {
                throw (new Error((("Forbidden value (" + this.fightId) + ") on element fightId.")));
            };
            output.writeShort(this.fightId);
            output.writeByte(this.teamId);
            output.writeByte(this.option);
            output.writeBoolean(this.state);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightOptionStateUpdateMessage(input);
        }

        public function deserializeAs_GameFightOptionStateUpdateMessage(input:ICustomDataInput):void
        {
            this.fightId = input.readShort();
            if (this.fightId < 0)
            {
                throw (new Error((("Forbidden value (" + this.fightId) + ") on element of GameFightOptionStateUpdateMessage.fightId.")));
            };
            this.teamId = input.readByte();
            if (this.teamId < 0)
            {
                throw (new Error((("Forbidden value (" + this.teamId) + ") on element of GameFightOptionStateUpdateMessage.teamId.")));
            };
            this.option = input.readByte();
            if (this.option < 0)
            {
                throw (new Error((("Forbidden value (" + this.option) + ") on element of GameFightOptionStateUpdateMessage.option.")));
            };
            this.state = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.fight

