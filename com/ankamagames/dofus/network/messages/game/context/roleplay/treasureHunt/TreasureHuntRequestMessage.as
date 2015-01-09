package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class TreasureHuntRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6488;

        private var _isInitialized:Boolean = false;
        public var questLevel:uint = 0;
        public var questType:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6488);
        }

        public function initTreasureHuntRequestMessage(questLevel:uint=0, questType:uint=0):TreasureHuntRequestMessage
        {
            this.questLevel = questLevel;
            this.questType = questType;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.questLevel = 0;
            this.questType = 0;
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
            this.serializeAs_TreasureHuntRequestMessage(output);
        }

        public function serializeAs_TreasureHuntRequestMessage(output:ICustomDataOutput):void
        {
            if ((((this.questLevel < 1)) || ((this.questLevel > 200))))
            {
                throw (new Error((("Forbidden value (" + this.questLevel) + ") on element questLevel.")));
            };
            output.writeByte(this.questLevel);
            output.writeByte(this.questType);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_TreasureHuntRequestMessage(input);
        }

        public function deserializeAs_TreasureHuntRequestMessage(input:ICustomDataInput):void
        {
            this.questLevel = input.readUnsignedByte();
            if ((((this.questLevel < 1)) || ((this.questLevel > 200))))
            {
                throw (new Error((("Forbidden value (" + this.questLevel) + ") on element of TreasureHuntRequestMessage.questLevel.")));
            };
            this.questType = input.readByte();
            if (this.questType < 0)
            {
                throw (new Error((("Forbidden value (" + this.questType) + ") on element of TreasureHuntRequestMessage.questType.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt

