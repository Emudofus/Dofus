package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GroupMonsterStaticInformations extends Object implements INetworkType
   {
      
      public function GroupMonsterStaticInformations()
      {
         this.mainCreatureLightInfos = new MonsterInGroupLightInformations();
         this.underlings = new Vector.<MonsterInGroupInformations>();
         super();
      }
      
      public static const protocolId:uint = 140;
      
      public var mainCreatureLightInfos:MonsterInGroupLightInformations;
      
      public var underlings:Vector.<MonsterInGroupInformations>;
      
      public function getTypeId() : uint
      {
         return 140;
      }
      
      public function initGroupMonsterStaticInformations(param1:MonsterInGroupLightInformations = null, param2:Vector.<MonsterInGroupInformations> = null) : GroupMonsterStaticInformations
      {
         this.mainCreatureLightInfos = param1;
         this.underlings = param2;
         return this;
      }
      
      public function reset() : void
      {
         this.mainCreatureLightInfos = new MonsterInGroupLightInformations();
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_GroupMonsterStaticInformations(param1);
      }
      
      public function serializeAs_GroupMonsterStaticInformations(param1:ICustomDataOutput) : void
      {
         this.mainCreatureLightInfos.serializeAs_MonsterInGroupLightInformations(param1);
         param1.writeShort(this.underlings.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.underlings.length)
         {
            (this.underlings[_loc2_] as MonsterInGroupInformations).serializeAs_MonsterInGroupInformations(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GroupMonsterStaticInformations(param1);
      }
      
      public function deserializeAs_GroupMonsterStaticInformations(param1:ICustomDataInput) : void
      {
         var _loc4_:MonsterInGroupInformations = null;
         this.mainCreatureLightInfos = new MonsterInGroupLightInformations();
         this.mainCreatureLightInfos.deserialize(param1);
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new MonsterInGroupInformations();
            _loc4_.deserialize(param1);
            this.underlings.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
