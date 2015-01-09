package com.ankamagames.dofus.network.messages.game.context
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.IdentifiedEntityDispositionInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameEntityDispositionMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5693;

        private var _isInitialized:Boolean = false;
        public var disposition:IdentifiedEntityDispositionInformations;

        public function GameEntityDispositionMessage()
        {
            this.disposition = new IdentifiedEntityDispositionInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5693);
        }

        public function initGameEntityDispositionMessage(disposition:IdentifiedEntityDispositionInformations=null):GameEntityDispositionMessage
        {
            this.disposition = disposition;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.disposition = new IdentifiedEntityDispositionInformations();
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
            this.serializeAs_GameEntityDispositionMessage(output);
        }

        public function serializeAs_GameEntityDispositionMessage(output:ICustomDataOutput):void
        {
            this.disposition.serializeAs_IdentifiedEntityDispositionInformations(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameEntityDispositionMessage(input);
        }

        public function deserializeAs_GameEntityDispositionMessage(input:ICustomDataInput):void
        {
            this.disposition = new IdentifiedEntityDispositionInformations();
            this.disposition.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context

