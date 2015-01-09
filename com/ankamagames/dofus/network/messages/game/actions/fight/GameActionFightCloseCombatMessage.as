package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class GameActionFightCloseCombatMessage extends AbstractGameActionFightTargetedAbilityMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6116;

        private var _isInitialized:Boolean = false;
        public var weaponGenericId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6116);
        }

        public function initGameActionFightCloseCombatMessage(actionId:uint=0, sourceId:int=0, targetId:int=0, destinationCellId:int=0, critical:uint=1, silentCast:Boolean=false, weaponGenericId:uint=0):GameActionFightCloseCombatMessage
        {
            super.initAbstractGameActionFightTargetedAbilityMessage(actionId, sourceId, targetId, destinationCellId, critical, silentCast);
            this.weaponGenericId = weaponGenericId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.weaponGenericId = 0;
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        override public function serialize(output:IDataOutput):void
        {
            this.serializeAs_GameActionFightCloseCombatMessage(output);
        }

        public function serializeAs_GameActionFightCloseCombatMessage(output:IDataOutput):void
        {
            super.serializeAs_AbstractGameActionFightTargetedAbilityMessage(output);
            if (this.weaponGenericId < 0)
            {
                throw (new Error((("Forbidden value (" + this.weaponGenericId) + ") on element weaponGenericId.")));
            };
            output.writeInt(this.weaponGenericId);
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_GameActionFightCloseCombatMessage(input);
        }

        public function deserializeAs_GameActionFightCloseCombatMessage(input:IDataInput):void
        {
            super.deserialize(input);
            this.weaponGenericId = input.readInt();
            if (this.weaponGenericId < 0)
            {
                throw (new Error((("Forbidden value (" + this.weaponGenericId) + ") on element of GameActionFightCloseCombatMessage.weaponGenericId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.actions.fight

