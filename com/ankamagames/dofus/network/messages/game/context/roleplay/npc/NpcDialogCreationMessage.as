package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class NpcDialogCreationMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var mapId:int = 0;
        public var npcId:int = 0;
        public static const protocolId:uint = 5618;

        public function NpcDialogCreationMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5618;
        }// end function

        public function initNpcDialogCreationMessage(param1:int = 0, param2:int = 0) : NpcDialogCreationMessage
        {
            this.mapId = param1;
            this.npcId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.mapId = 0;
            this.npcId = 0;
            this._isInitialized = false;
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_NpcDialogCreationMessage(param1);
            return;
        }// end function

        public function serializeAs_NpcDialogCreationMessage(param1:IDataOutput) : void
        {
            param1.writeInt(this.mapId);
            param1.writeInt(this.npcId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_NpcDialogCreationMessage(param1);
            return;
        }// end function

        public function deserializeAs_NpcDialogCreationMessage(param1:IDataInput) : void
        {
            this.mapId = param1.readInt();
            this.npcId = param1.readInt();
            return;
        }// end function

    }
}
