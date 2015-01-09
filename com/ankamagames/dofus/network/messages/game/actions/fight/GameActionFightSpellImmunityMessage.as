package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameActionFightSpellImmunityMessage extends AbstractGameActionMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6221;

        private var _isInitialized:Boolean = false;
        public var targetId:int = 0;
        public var spellId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6221);
        }

        public function initGameActionFightSpellImmunityMessage(actionId:uint=0, sourceId:int=0, targetId:int=0, spellId:uint=0):GameActionFightSpellImmunityMessage
        {
            super.initAbstractGameActionMessage(actionId, sourceId);
            this.targetId = targetId;
            this.spellId = spellId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.targetId = 0;
            this.spellId = 0;
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
            this.serializeAs_GameActionFightSpellImmunityMessage(output);
        }

        public function serializeAs_GameActionFightSpellImmunityMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractGameActionMessage(output);
            output.writeInt(this.targetId);
            if (this.spellId < 0)
            {
                throw (new Error((("Forbidden value (" + this.spellId) + ") on element spellId.")));
            };
            output.writeVarShort(this.spellId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameActionFightSpellImmunityMessage(input);
        }

        public function deserializeAs_GameActionFightSpellImmunityMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.targetId = input.readInt();
            this.spellId = input.readVarUhShort();
            if (this.spellId < 0)
            {
                throw (new Error((("Forbidden value (" + this.spellId) + ") on element of GameActionFightSpellImmunityMessage.spellId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.actions.fight

