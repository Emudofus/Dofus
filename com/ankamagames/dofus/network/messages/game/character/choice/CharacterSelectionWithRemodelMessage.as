package com.ankamagames.dofus.network.messages.game.character.choice
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.character.choice.RemodelingInformation;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class CharacterSelectionWithRemodelMessage extends CharacterSelectionMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6549;

        private var _isInitialized:Boolean = false;
        public var remodel:RemodelingInformation;

        public function CharacterSelectionWithRemodelMessage()
        {
            this.remodel = new RemodelingInformation();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6549);
        }

        public function initCharacterSelectionWithRemodelMessage(id:int=0, remodel:RemodelingInformation=null):CharacterSelectionWithRemodelMessage
        {
            super.initCharacterSelectionMessage(id);
            this.remodel = remodel;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.remodel = new RemodelingInformation();
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
            this.serializeAs_CharacterSelectionWithRemodelMessage(output);
        }

        public function serializeAs_CharacterSelectionWithRemodelMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_CharacterSelectionMessage(output);
            this.remodel.serializeAs_RemodelingInformation(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CharacterSelectionWithRemodelMessage(input);
        }

        public function deserializeAs_CharacterSelectionWithRemodelMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.remodel = new RemodelingInformation();
            this.remodel.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.character.choice

