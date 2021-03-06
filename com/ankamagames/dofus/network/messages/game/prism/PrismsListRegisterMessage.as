﻿package com.ankamagames.dofus.network.messages.game.prism
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class PrismsListRegisterMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6441;

        private var _isInitialized:Boolean = false;
        public var listen:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6441);
        }

        public function initPrismsListRegisterMessage(listen:uint=0):PrismsListRegisterMessage
        {
            this.listen = listen;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.listen = 0;
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
            this.serializeAs_PrismsListRegisterMessage(output);
        }

        public function serializeAs_PrismsListRegisterMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.listen);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PrismsListRegisterMessage(input);
        }

        public function deserializeAs_PrismsListRegisterMessage(input:ICustomDataInput):void
        {
            this.listen = input.readByte();
            if (this.listen < 0)
            {
                throw (new Error((("Forbidden value (" + this.listen) + ") on element of PrismsListRegisterMessage.listen.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.prism

