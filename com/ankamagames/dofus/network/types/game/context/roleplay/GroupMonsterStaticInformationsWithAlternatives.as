package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GroupMonsterStaticInformationsWithAlternatives extends GroupMonsterStaticInformations implements INetworkType
   {
      
      public function GroupMonsterStaticInformationsWithAlternatives() {
         this.alternatives = new Vector.<AlternativeMonstersInGroupLightInformations>();
         super();
      }
      
      public static const protocolId:uint = 396;
      
      public var alternatives:Vector.<AlternativeMonstersInGroupLightInformations>;
      
      override public function getTypeId() : uint {
         return 396;
      }
      
      public function initGroupMonsterStaticInformationsWithAlternatives(param1:MonsterInGroupLightInformations=null, param2:Vector.<MonsterInGroupInformations>=null, param3:Vector.<AlternativeMonstersInGroupLightInformations>=null) : GroupMonsterStaticInformationsWithAlternatives {
         super.initGroupMonsterStaticInformations(param1,param2);
         this.alternatives = param3;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.alternatives = new Vector.<AlternativeMonstersInGroupLightInformations>();
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GroupMonsterStaticInformationsWithAlternatives(param1);
      }
      
      public function serializeAs_GroupMonsterStaticInformationsWithAlternatives(param1:IDataOutput) : void {
         super.serializeAs_GroupMonsterStaticInformations(param1);
         param1.writeShort(this.alternatives.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.alternatives.length)
         {
            (this.alternatives[_loc2_] as AlternativeMonstersInGroupLightInformations).serializeAs_AlternativeMonstersInGroupLightInformations(param1);
            _loc2_++;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GroupMonsterStaticInformationsWithAlternatives(param1);
      }
      
      public function deserializeAs_GroupMonsterStaticInformationsWithAlternatives(param1:IDataInput) : void {
         var _loc4_:AlternativeMonstersInGroupLightInformations = null;
         super.deserialize(param1);
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new AlternativeMonstersInGroupLightInformations();
            _loc4_.deserialize(param1);
            this.alternatives.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
