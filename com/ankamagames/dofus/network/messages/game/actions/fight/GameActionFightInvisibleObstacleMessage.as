package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameActionFightInvisibleObstacleMessage extends AbstractGameActionMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5820;

        private var _isInitialized:Boolean = false;
        public var sourceSpellId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5820);
        }

        public function initGameActionFightInvisibleObstacleMessage(actionId:uint=0, sourceId:int=0, sourceSpellId:uint=0):GameActionFightInvisibleObstacleMessage
        {
            super.initAbstractGameActionMessage(actionId, sourceId);
            this.sourceSpellId = sourceSpellId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.sourceSpellId = 0;
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
            this.serializeAs_GameActionFightInvisibleObstacleMessage(output);
        }

        public function serializeAs_GameActionFightInvisibleObstacleMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractGameActionMessage(output);
            if (this.sourceSpellId < 0)
            {
                throw (new Error((("Forbidden value (" + this.sourceSpellId) + ") on element sourceSpellId.")));
            };
            output.writeVarInt(this.sourceSpellId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameActionFightInvisibleObstacleMessage(input);
        }

        public function deserializeAs_GameActionFightInvisibleObstacleMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.sourceSpellId = input.readVarUhInt();
            if (this.sourceSpellId < 0)
            {
                throw (new Error((("Forbidden value (" + this.sourceSpellId) + ") on element of GameActionFightInvisibleObstacleMessage.sourceSpellId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.actions.fight

