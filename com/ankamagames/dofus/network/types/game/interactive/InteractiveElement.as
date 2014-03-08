package com.ankamagames.dofus.network.types.game.interactive
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
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
      
      public function initInteractiveElement(param1:uint=0, param2:int=0, param3:Vector.<InteractiveElementSkill>=null, param4:Vector.<InteractiveElementSkill>=null) : InteractiveElement {
         this.elementId = param1;
         this.elementTypeId = param2;
         this.enabledSkills = param3;
         this.disabledSkills = param4;
         return this;
      }
      
      public function reset() : void {
         this.elementId = 0;
         this.elementTypeId = 0;
         this.enabledSkills = new Vector.<InteractiveElementSkill>();
         this.disabledSkills = new Vector.<InteractiveElementSkill>();
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_InteractiveElement(param1);
      }
      
      public function serializeAs_InteractiveElement(param1:IDataOutput) : void {
         if(this.elementId < 0)
         {
            throw new Error("Forbidden value (" + this.elementId + ") on element elementId.");
         }
         else
         {
            param1.writeInt(this.elementId);
            param1.writeInt(this.elementTypeId);
            param1.writeShort(this.enabledSkills.length);
            _loc2_ = 0;
            while(_loc2_ < this.enabledSkills.length)
            {
               param1.writeShort((this.enabledSkills[_loc2_] as InteractiveElementSkill).getTypeId());
               (this.enabledSkills[_loc2_] as InteractiveElementSkill).serialize(param1);
               _loc2_++;
            }
            param1.writeShort(this.disabledSkills.length);
            _loc3_ = 0;
            while(_loc3_ < this.disabledSkills.length)
            {
               param1.writeShort((this.disabledSkills[_loc3_] as InteractiveElementSkill).getTypeId());
               (this.disabledSkills[_loc3_] as InteractiveElementSkill).serialize(param1);
               _loc3_++;
            }
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_InteractiveElement(param1);
      }
      
      public function deserializeAs_InteractiveElement(param1:IDataInput) : void {
         var _loc6_:uint = 0;
         var _loc7_:InteractiveElementSkill = null;
         var _loc8_:uint = 0;
         var _loc9_:InteractiveElementSkill = null;
         this.elementId = param1.readInt();
         if(this.elementId < 0)
         {
            throw new Error("Forbidden value (" + this.elementId + ") on element of InteractiveElement.elementId.");
         }
         else
         {
            this.elementTypeId = param1.readInt();
            _loc2_ = param1.readUnsignedShort();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc6_ = param1.readUnsignedShort();
               _loc7_ = ProtocolTypeManager.getInstance(InteractiveElementSkill,_loc6_);
               _loc7_.deserialize(param1);
               this.enabledSkills.push(_loc7_);
               _loc3_++;
            }
            _loc4_ = param1.readUnsignedShort();
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc8_ = param1.readUnsignedShort();
               _loc9_ = ProtocolTypeManager.getInstance(InteractiveElementSkill,_loc8_);
               _loc9_.deserialize(param1);
               this.disabledSkills.push(_loc9_);
               _loc5_++;
            }
            return;
         }
      }
   }
}
