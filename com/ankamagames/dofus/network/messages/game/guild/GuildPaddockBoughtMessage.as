package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.paddock.PaddockContentInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GuildPaddockBoughtMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5952;

        private var _isInitialized:Boolean = false;
        public var paddockInfo:PaddockContentInformations;

        public function GuildPaddockBoughtMessage()
        {
            this.paddockInfo = new PaddockContentInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5952);
        }

        public function initGuildPaddockBoughtMessage(paddockInfo:PaddockContentInformations=null):GuildPaddockBoughtMessage
        {
            this.paddockInfo = paddockInfo;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.paddockInfo = new PaddockContentInformations();
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
            this.serializeAs_GuildPaddockBoughtMessage(output);
        }

        public function serializeAs_GuildPaddockBoughtMessage(output:ICustomDataOutput):void
        {
            this.paddockInfo.serializeAs_PaddockContentInformations(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildPaddockBoughtMessage(input);
        }

        public function deserializeAs_GuildPaddockBoughtMessage(input:ICustomDataInput):void
        {
            this.paddockInfo = new PaddockContentInformations();
            this.paddockInfo.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

