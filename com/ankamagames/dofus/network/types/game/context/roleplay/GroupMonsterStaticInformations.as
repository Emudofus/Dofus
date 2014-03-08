package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import __AS3__.vec.*;
   
   public class GroupMonsterStaticInformations extends Object implements INetworkType
   {
      
      public function GroupMonsterStaticInformations() {
         this.mainCreatureLightInfos = new MonsterInGroupLightInformations();
         this.underlings = new Vector.<MonsterInGroupInformations>();
         super();
      }
      
      public static const protocolId:uint = 140;
      
      public var mainCreatureLightInfos:MonsterInGroupLightInformations;
      
      public var underlings:Vector.<MonsterInGroupInformations>;
      
      public function getTypeId() : uint {
         return 140;
      }
      
      public function initGroupMonsterStaticInformations(mainCreatureLightInfos:MonsterInGroupLightInformations=null, underlings:Vector.<MonsterInGroupInformations>=null) : GroupMonsterStaticInformations {
         this.mainCreatureLightInfos = mainCreatureLightInfos;
         this.underlings = underlings;
         return this;
      }
      
      public function reset() : void {
         this.mainCreatureLightInfos = new MonsterInGroupLightInformations();
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_GroupMonsterStaticInformations(output);
      }
      
      public function serializeAs_GroupMonsterStaticInformations(output:IDataOutput) : void {
         this.mainCreatureLightInfos.serializeAs_MonsterInGroupLightInformations(output);
         output.writeShort(this.underlings.length);
         var _i2:uint = 0;
         while(_i2 < this.underlings.length)
         {
            (this.underlings[_i2] as MonsterInGroupInformations).serializeAs_MonsterInGroupInformations(output);
            _i2++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GroupMonsterStaticInformations(input);
      }
      
      public function deserializeAs_GroupMonsterStaticInformations(input:IDataInput) : void {
         var _item2:MonsterInGroupInformations = null;
         this.mainCreatureLightInfos = new MonsterInGroupLightInformations();
         this.mainCreatureLightInfos.deserialize(input);
         var _underlingsLen:uint = input.readUnsignedShort();
         var _i2:uint = 0;
         while(_i2 < _underlingsLen)
         {
            _item2 = new MonsterInGroupInformations();
            _item2.deserialize(input);
            this.underlings.push(_item2);
            _i2++;
         }
      }
   }
}
