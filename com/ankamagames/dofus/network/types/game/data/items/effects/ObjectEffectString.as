package com.ankamagames.dofus.network.types.game.data.items.effects
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ObjectEffectString extends ObjectEffect implements INetworkType
    {
        public var value:String = "";
        public static const protocolId:uint = 74;

        public function ObjectEffectString()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 74;
        }// end function

        public function initObjectEffectString(param1:uint = 0, param2:String = "") : ObjectEffectString
        {
            super.initObjectEffect(param1);
            this.value = param2;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.value = "";
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ObjectEffectString(param1);
            return;
        }// end function

        public function serializeAs_ObjectEffectString(param1:IDataOutput) : void
        {
            super.serializeAs_ObjectEffect(param1);
            param1.writeUTF(this.value);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ObjectEffectString(param1);
            return;
        }// end function

        public function deserializeAs_ObjectEffectString(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.value = param1.readUTF();
            return;
        }// end function

    }
}
