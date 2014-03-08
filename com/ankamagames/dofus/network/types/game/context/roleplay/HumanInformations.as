package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.character.restriction.ActorRestrictionsInformations;
   import __AS3__.vec.Vector;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class HumanInformations extends Object implements INetworkType
   {
      
      public function HumanInformations() {
         this.restrictions = new ActorRestrictionsInformations();
         this.options = new Vector.<HumanOption>();
         super();
      }
      
      public static const protocolId:uint = 157;
      
      public var restrictions:ActorRestrictionsInformations;
      
      public var sex:Boolean = false;
      
      public var options:Vector.<HumanOption>;
      
      public function getTypeId() : uint {
         return 157;
      }
      
      public function initHumanInformations(param1:ActorRestrictionsInformations=null, param2:Boolean=false, param3:Vector.<HumanOption>=null) : HumanInformations {
         this.restrictions = param1;
         this.sex = param2;
         this.options = param3;
         return this;
      }
      
      public function reset() : void {
         this.restrictions = new ActorRestrictionsInformations();
         this.options = new Vector.<HumanOption>();
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_HumanInformations(param1);
      }
      
      public function serializeAs_HumanInformations(param1:IDataOutput) : void {
         this.restrictions.serializeAs_ActorRestrictionsInformations(param1);
         param1.writeBoolean(this.sex);
         param1.writeShort(this.options.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.options.length)
         {
            param1.writeShort((this.options[_loc2_] as HumanOption).getTypeId());
            (this.options[_loc2_] as HumanOption).serialize(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_HumanInformations(param1);
      }
      
      public function deserializeAs_HumanInformations(param1:IDataInput) : void {
         var _loc4_:uint = 0;
         var _loc5_:HumanOption = null;
         this.restrictions = new ActorRestrictionsInformations();
         this.restrictions.deserialize(param1);
         this.sex = param1.readBoolean();
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readUnsignedShort();
            _loc5_ = ProtocolTypeManager.getInstance(HumanOption,_loc4_);
            _loc5_.deserialize(param1);
            this.options.push(_loc5_);
            _loc3_++;
         }
      }
   }
}
