package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class GameRolePlayMerchantInformations extends GameRolePlayNamedActorInformations implements INetworkType 
    {

        public static const protocolId:uint = 129;

        public var sellType:uint = 0;
        public var options:Vector.<HumanOption>;

        public function GameRolePlayMerchantInformations()
        {
            this.options = new Vector.<HumanOption>();
            super();
        }

        override public function getTypeId():uint
        {
            return (129);
        }

        public function initGameRolePlayMerchantInformations(contextualId:int=0, look:EntityLook=null, disposition:EntityDispositionInformations=null, name:String="", sellType:uint=0, options:Vector.<HumanOption>=null):GameRolePlayMerchantInformations
        {
            super.initGameRolePlayNamedActorInformations(contextualId, look, disposition, name);
            this.sellType = sellType;
            this.options = options;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.sellType = 0;
            this.options = new Vector.<HumanOption>();
        }

        override public function serialize(output:IDataOutput):void
        {
            this.serializeAs_GameRolePlayMerchantInformations(output);
        }

        public function serializeAs_GameRolePlayMerchantInformations(output:IDataOutput):void
        {
            super.serializeAs_GameRolePlayNamedActorInformations(output);
            if (this.sellType < 0)
            {
                throw (new Error((("Forbidden value (" + this.sellType) + ") on element sellType.")));
            };
            output.writeInt(this.sellType);
            output.writeShort(this.options.length);
            var _i2:uint;
            while (_i2 < this.options.length)
            {
                output.writeShort((this.options[_i2] as HumanOption).getTypeId());
                (this.options[_i2] as HumanOption).serialize(output);
                _i2++;
            };
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_GameRolePlayMerchantInformations(input);
        }

        public function deserializeAs_GameRolePlayMerchantInformations(input:IDataInput):void
        {
            var _id2:uint;
            var _item2:HumanOption;
            super.deserialize(input);
            this.sellType = input.readInt();
            if (this.sellType < 0)
            {
                throw (new Error((("Forbidden value (" + this.sellType) + ") on element of GameRolePlayMerchantInformations.sellType.")));
            };
            var _optionsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _optionsLen)
            {
                _id2 = input.readUnsignedShort();
                _item2 = ProtocolTypeManager.getInstance(HumanOption, _id2);
                _item2.deserialize(input);
                this.options.push(_item2);
                _i2++;
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay

