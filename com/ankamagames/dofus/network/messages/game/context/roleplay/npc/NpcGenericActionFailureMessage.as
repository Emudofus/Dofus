package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class NpcGenericActionFailureMessage extends NetworkMessage implements INetworkMessage
    {
        public static const protocolId:uint = 5900;

        public function NpcGenericActionFailureMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return true;
        }// end function

        override public function getMessageId() : uint
        {
            return 5900;
        }// end function

        public function initNpcGenericActionFailureMessage() : NpcGenericActionFailureMessage
        {
            return this;
        }// end function

        override public function reset() : void
        {
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
            return;
        }// end function

        public function serializeAs_NpcGenericActionFailureMessage(param1:IDataOutput) : void
        {
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            return;
        }// end function

        public function deserializeAs_NpcGenericActionFailureMessage(param1:IDataInput) : void
        {
            return;
        }// end function

    }
}
