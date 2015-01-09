package com.ankamagames.dofus.network.messages.game.context.roleplay
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class MapFightCountMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 210;

        private var _isInitialized:Boolean = false;
        public var fightCount:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (210);
        }

        public function initMapFightCountMessage(fightCount:uint=0):MapFightCountMessage
        {
            this.fightCount = fightCount;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.fightCount = 0;
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
            this.serializeAs_MapFightCountMessage(output);
        }

        public function serializeAs_MapFightCountMessage(output:ICustomDataOutput):void
        {
            if (this.fightCount < 0)
            {
                throw (new Error((("Forbidden value (" + this.fightCount) + ") on element fightCount.")));
            };
            output.writeVarShort(this.fightCount);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_MapFightCountMessage(input);
        }

        public function deserializeAs_MapFightCountMessage(input:ICustomDataInput):void
        {
            this.fightCount = input.readVarUhShort();
            if (this.fightCount < 0)
            {
                throw (new Error((("Forbidden value (" + this.fightCount) + ") on element of MapFightCountMessage.fightCount.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay

