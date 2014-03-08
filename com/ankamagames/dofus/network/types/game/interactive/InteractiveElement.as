package com.ankamagames.dofus.network.types.game.interactive
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class InteractiveElement extends Object implements INetworkType
   {
      
      public function InteractiveElement() {
         this.enabledSkills = new Vector.<InteractiveElementSkill>();
         this.disabledSkills = new Vector.<InteractiveElementSkill>();
         super();
      }
      
      public static const protocolId:uint = 80;
      
      public var elementId:uint = 0;
      
      public var elementTypeId:int = 0;
      
      public var enabledSkills:Vector.<InteractiveElementSkill>;
      
      public var disabledSkills:Vector.<InteractiveElementSkill>;
      
      public function getTypeId() : uint {
         return 80;
      }
      
      public function initInteractiveElement(elementId:uint=0, elementTypeId:int=0, enabledSkills:Vector.<InteractiveElementSkill>=null, disabledSkills:Vector.<InteractiveElementSkill>=null) : InteractiveElement {
         this.elementId = elementId;
         this.elementTypeId = elementTypeId;
         this.enabledSkills = enabledSkills;
         this.disabledSkills = disabledSkills;
         return this;
      }
      
      public function reset() : void {
         this.elementId = 0;
         this.elementTypeId = 0;
         this.enabledSkills = new Vector.<InteractiveElementSkill>();
         this.disabledSkills = new Vector.<InteractiveElementSkill>();
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_InteractiveElement(output);
      }
      
      public function serializeAs_InteractiveElement(output:IDataOutput) : void {
         if(this.elementId < 0)
         {
            throw new Error("Forbidden value (" + this.elementId + ") on element elementId.");
         }
         else
         {
            output.writeInt(this.elementId);
            output.writeInt(this.elementTypeId);
            output.writeShort(this.enabledSkills.length);
            _i3 = 0;
            while(_i3 < this.enabledSkills.length)
            {
               output.writeShort((this.enabledSkills[_i3] as InteractiveElementSkill).getTypeId());
               (this.enabledSkills[_i3] as InteractiveElementSkill).serialize(output);
               _i3++;
            }
            output.writeShort(this.disabledSkills.length);
            _i4 = 0;
            while(_i4 < this.disabledSkills.length)
            {
               output.writeShort((this.disabledSkills[_i4] as InteractiveElementSkill).getTypeId());
               (this.disabledSkills[_i4] as InteractiveElementSkill).serialize(output);
               _i4++;
            }
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_InteractiveElement(input);
      }
      
      public function deserializeAs_InteractiveElement(input:IDataInput) : void {
         var _id3:uint = 0;
         var _item3:InteractiveElementSkill = null;
         var _id4:uint = 0;
         var _item4:InteractiveElementSkill = null;
         this.elementId = input.readInt();
         if(this.elementId < 0)
         {
            throw new Error("Forbidden value (" + this.elementId + ") on element of InteractiveElement.elementId.");
         }
         else
         {
            this.elementTypeId = input.readInt();
            _enabledSkillsLen = input.readUnsignedShort();
            _i3 = 0;
            while(_i3 < _enabledSkillsLen)
            {
               _id3 = input.readUnsignedShort();
               _item3 = ProtocolTypeManager.getInstance(InteractiveElementSkill,_id3);
               _item3.deserialize(input);
               this.enabledSkills.push(_item3);
               _i3++;
            }
            _disabledSkillsLen = input.readUnsignedShort();
            _i4 = 0;
            while(_i4 < _disabledSkillsLen)
            {
               _id4 = input.readUnsignedShort();
               _item4 = ProtocolTypeManager.getInstance(InteractiveElementSkill,_id4);
               _item4.deserialize(input);
               this.disabledSkills.push(_item4);
               _i4++;
            }
            return;
         }
      }
   }
}
