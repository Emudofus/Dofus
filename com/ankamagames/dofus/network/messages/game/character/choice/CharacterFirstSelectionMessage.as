﻿package com.ankamagames.dofus.network.messages.game.character.choice
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class CharacterFirstSelectionMessage extends CharacterSelectionMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6084;

        private var _isInitialized:Boolean = false;
        public var doTutorial:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6084);
        }

        public function initCharacterFirstSelectionMessage(id:int=0, doTutorial:Boolean=false):CharacterFirstSelectionMessage
        {
            super.initCharacterSelectionMessage(id);
            this.doTutorial = doTutorial;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.doTutorial = false;
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

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_CharacterFirstSelectionMessage(output);
        }

        public function serializeAs_CharacterFirstSelectionMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_CharacterSelectionMessage(output);
            output.writeBoolean(this.doTutorial);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CharacterFirstSelectionMessage(input);
        }

        public function deserializeAs_CharacterFirstSelectionMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.doTutorial = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.character.choice

