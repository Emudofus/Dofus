package com.ankamagames.dofus.network.messages.game.character.choice
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class CharactersListMessage extends BasicCharactersListMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 151;

        private var _isInitialized:Boolean = false;
        public var hasStartupActions:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (151);
        }

        public function initCharactersListMessage(characters:Vector.<CharacterBaseInformations>=null, hasStartupActions:Boolean=false):CharactersListMessage
        {
            super.initBasicCharactersListMessage(characters);
            this.hasStartupActions = hasStartupActions;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.hasStartupActions = false;
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
            this.serializeAs_CharactersListMessage(output);
        }

        public function serializeAs_CharactersListMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_BasicCharactersListMessage(output);
            output.writeBoolean(this.hasStartupActions);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CharactersListMessage(input);
        }

        public function deserializeAs_CharactersListMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.hasStartupActions = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.character.choice

