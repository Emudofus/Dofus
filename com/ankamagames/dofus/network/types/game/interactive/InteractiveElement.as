package com.ankamagames.dofus.network.types.game.interactive
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class InteractiveElement extends Object implements INetworkType
    {
        public var elementId:uint = 0;
        public var elementTypeId:int = 0;
        public var enabledSkills:Vector.<InteractiveElementSkill>;
        public var disabledSkills:Vector.<InteractiveElementSkill>;
        public static const protocolId:uint = 80;

        public function InteractiveElement()
        {
            this.enabledSkills = new Vector.<InteractiveElementSkill>;
            this.disabledSkills = new Vector.<InteractiveElementSkill>;
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 80;
        }// end function

        public function initInteractiveElement(param1:uint = 0, param2:int = 0, param3:Vector.<InteractiveElementSkill> = null, param4:Vector.<InteractiveElementSkill> = null) : InteractiveElement
        {
            this.elementId = param1;
            this.elementTypeId = param2;
            this.enabledSkills = param3;
            this.disabledSkills = param4;
            return this;
        }// end function

        public function reset() : void
        {
            this.elementId = 0;
            this.elementTypeId = 0;
            this.enabledSkills = new Vector.<InteractiveElementSkill>;
            this.disabledSkills = new Vector.<InteractiveElementSkill>;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_InteractiveElement(param1);
            return;
        }// end function

        public function serializeAs_InteractiveElement(param1:IDataOutput) : void
        {
            if (this.elementId < 0)
            {
                throw new Error("Forbidden value (" + this.elementId + ") on element elementId.");
            }
            param1.writeInt(this.elementId);
            param1.writeInt(this.elementTypeId);
            param1.writeShort(this.enabledSkills.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.enabledSkills.length)
            {
                
                param1.writeShort((this.enabledSkills[_loc_2] as InteractiveElementSkill).getTypeId());
                (this.enabledSkills[_loc_2] as InteractiveElementSkill).serialize(param1);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.disabledSkills.length);
            var _loc_3:* = 0;
            while (_loc_3 < this.disabledSkills.length)
            {
                
                param1.writeShort((this.disabledSkills[_loc_3] as InteractiveElementSkill).getTypeId());
                (this.disabledSkills[_loc_3] as InteractiveElementSkill).serialize(param1);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_InteractiveElement(param1);
            return;
        }// end function

        public function deserializeAs_InteractiveElement(param1:IDataInput) : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            this.elementId = param1.readInt();
            if (this.elementId < 0)
            {
                throw new Error("Forbidden value (" + this.elementId + ") on element of InteractiveElement.elementId.");
            }
            this.elementTypeId = param1.readInt();
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_6 = param1.readUnsignedShort();
                _loc_7 = ProtocolTypeManager.getInstance(InteractiveElementSkill, _loc_6);
                _loc_7.deserialize(param1);
                this.enabledSkills.push(_loc_7);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_8 = param1.readUnsignedShort();
                _loc_9 = ProtocolTypeManager.getInstance(InteractiveElementSkill, _loc_8);
                _loc_9.deserialize(param1);
                this.disabledSkills.push(_loc_9);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

    }
}
