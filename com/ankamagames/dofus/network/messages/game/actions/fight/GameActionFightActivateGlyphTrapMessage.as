package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameActionFightActivateGlyphTrapMessage extends AbstractGameActionMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6545;

        private var _isInitialized:Boolean = false;
        public var markId:int = 0;
        public var active:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6545);
        }

        public function initGameActionFightActivateGlyphTrapMessage(actionId:uint=0, sourceId:int=0, markId:int=0, active:Boolean=false):GameActionFightActivateGlyphTrapMessage
        {
            super.initAbstractGameActionMessage(actionId, sourceId);
            this.markId = markId;
            this.active = active;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.markId = 0;
            this.active = false;
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
            this.serializeAs_GameActionFightActivateGlyphTrapMessage(output);
        }

        public function serializeAs_GameActionFightActivateGlyphTrapMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractGameActionMessage(output);
            output.writeShort(this.markId);
            output.writeBoolean(this.active);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameActionFightActivateGlyphTrapMessage(input);
        }

        public function deserializeAs_GameActionFightActivateGlyphTrapMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.markId = input.readShort();
            this.active = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.actions.fight

