package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class AlternativeMonstersInGroupLightInformations extends Object implements INetworkType
   {
      
      public function AlternativeMonstersInGroupLightInformations() {
         this.monsters = new Vector.<MonsterInGroupLightInformations>();
         super();
      }
      
      public static const protocolId:uint = 394;
      
      public var playerCount:int = 0;
      
      public var monsters:Vector.<MonsterInGroupLightInformations>;
      
      public function getTypeId() : uint {
         return 394;
      }
      
      public function initAlternativeMonstersInGroupLightInformations(param1:int=0, param2:Vector.<MonsterInGroupLightInformations>=null) : AlternativeMonstersInGroupLightInformations {
         this.playerCount = param1;
         this.monsters = param2;
         return this;
      }
      
      public function reset() : void {
         this.playerCount = 0;
         this.monsters = new Vector.<MonsterInGroupLightInformations>();
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_AlternativeMonstersInGroupLightInformations(param1);
      }
      
      public function serializeAs_AlternativeMonstersInGroupLightInformations(param1:IDataOutput) : void {
         param1.writeInt(this.playerCount);
         param1.writeShort(this.monsters.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.monsters.length)
         {
            (this.monsters[_loc2_] as MonsterInGroupLightInformations).serializeAs_MonsterInGroupLightInformations(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AlternativeMonstersInGroupLightInformations(param1);
      }
      
      public function deserializeAs_AlternativeMonstersInGroupLightInformations(param1:IDataInput) : void {
         var _loc4_:MonsterInGroupLightInformations = null;
         this.playerCount = param1.readInt();
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new MonsterInGroupLightInformations();
            _loc4_.deserialize(param1);
            this.monsters.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
