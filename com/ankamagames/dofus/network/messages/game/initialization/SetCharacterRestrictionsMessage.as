package com.ankamagames.dofus.network.messages.game.initialization
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.character.restriction.ActorRestrictionsInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class SetCharacterRestrictionsMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 170;

        private var _isInitialized:Boolean = false;
        public var restrictions:ActorRestrictionsInformations;

        public function SetCharacterRestrictionsMessage()
        {
            this.restrictions = new ActorRestrictionsInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (170);
        }

        public function initSetCharacterRestrictionsMessage(restrictions:ActorRestrictionsInformations=null):SetCharacterRestrictionsMessage
        {
            this.restrictions = restrictions;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.restrictions = new ActorRestrictionsInformations();
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
            this.serializeAs_SetCharacterRestrictionsMessage(output);
        }

        public function serializeAs_SetCharacterRestrictionsMessage(output:ICustomDataOutput):void
        {
            this.restrictions.serializeAs_ActorRestrictionsInformations(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_SetCharacterRestrictionsMessage(input);
        }

        public function deserializeAs_SetCharacterRestrictionsMessage(input:ICustomDataInput):void
        {
            this.restrictions = new ActorRestrictionsInformations();
            this.restrictions.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.initialization

