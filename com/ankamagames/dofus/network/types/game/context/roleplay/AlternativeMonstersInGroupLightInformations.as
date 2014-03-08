package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.*;
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
      
      public function initAlternativeMonstersInGroupLightInformations(playerCount:int=0, monsters:Vector.<MonsterInGroupLightInformations>=null) : AlternativeMonstersInGroupLightInformations {
         this.playerCount = playerCount;
         this.monsters = monsters;
         return this;
      }
      
      public function reset() : void {
         this.playerCount = 0;
         this.monsters = new Vector.<MonsterInGroupLightInformations>();
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_AlternativeMonstersInGroupLightInformations(output);
      }
      
      public function serializeAs_AlternativeMonstersInGroupLightInformations(output:IDataOutput) : void {
         output.writeInt(this.playerCount);
         output.writeShort(this.monsters.length);
         var _i2:uint = 0;
         while(_i2 < this.monsters.length)
         {
            (this.monsters[_i2] as MonsterInGroupLightInformations).serializeAs_MonsterInGroupLightInformations(output);
            _i2++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AlternativeMonstersInGroupLightInformations(input);
      }
      
      public function deserializeAs_AlternativeMonstersInGroupLightInformations(input:IDataInput) : void {
         var _item2:MonsterInGroupLightInformations = null;
         this.playerCount = input.readInt();
         var _monstersLen:uint = input.readUnsignedShort();
         var _i2:uint = 0;
         while(_i2 < _monstersLen)
         {
            _item2 = new MonsterInGroupLightInformations();
            _item2.deserialize(input);
            this.monsters.push(_item2);
            _i2++;
         }
      }
   }
}
