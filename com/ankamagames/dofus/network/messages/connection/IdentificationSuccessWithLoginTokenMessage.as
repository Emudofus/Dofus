package com.ankamagames.dofus.network.messages.connection
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class IdentificationSuccessWithLoginTokenMessage extends IdentificationSuccessMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var loginToken:String = "";
        public static const protocolId:uint = 6209;

        public function IdentificationSuccessWithLoginTokenMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6209;
        }// end function

        public function initIdentificationSuccessWithLoginTokenMessage(param1:String = "", param2:String = "", param3:uint = 0, param4:uint = 0, param5:Boolean = false, param6:String = "", param7:Number = 0, param8:Boolean = false, param9:Number = 0, param10:String = "") : IdentificationSuccessWithLoginTokenMessage
        {
            super.initIdentificationSuccessMessage(param1, param2, param3, param4, param5, param6, param7, param8, param9);
            this.loginToken = param10;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.loginToken = "";
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

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_IdentificationSuccessWithLoginTokenMessage(param1);
            return;
        }// end function

        public function serializeAs_IdentificationSuccessWithLoginTokenMessage(param1:IDataOutput) : void
        {
            super.serializeAs_IdentificationSuccessMessage(param1);
            param1.writeUTF(this.loginToken);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_IdentificationSuccessWithLoginTokenMessage(param1);
            return;
        }// end function

        public function deserializeAs_IdentificationSuccessWithLoginTokenMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.loginToken = param1.readUTF();
            return;
        }// end function

    }
}
