package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class GameRolePlayGroupMonsterWaveInformations extends GameRolePlayGroupMonsterInformations implements INetworkType
   {
      
      public function GameRolePlayGroupMonsterWaveInformations()
      {
         this.alternatives = new Vector.<GroupMonsterStaticInformations>();
         super();
      }
      
      public static const protocolId:uint = 464;
      
      public var nbWaves:uint = 0;
      
      public var alternatives:Vector.<GroupMonsterStaticInformations>;
      
      override public function getTypeId() : uint
      {
         return 464;
      }
      
      public function initGameRolePlayGroupMonsterWaveInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:GroupMonsterStaticInformations = null, param5:int = 0, param6:int = 0, param7:int = 0, param8:Boolean = false, param9:Boolean = false, param10:Boolean = false, param11:uint = 0, param12:Vector.<GroupMonsterStaticInformations> = null) : GameRolePlayGroupMonsterWaveInformations
      {
         super.initGameRolePlayGroupMonsterInformations(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10);
         this.nbWaves = param11;
         this.alternatives = param12;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.nbWaves = 0;
         this.alternatives = new Vector.<GroupMonsterStaticInformations>();
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_GameRolePlayGroupMonsterWaveInformations(param1);
      }
      
      public function serializeAs_GameRolePlayGroupMonsterWaveInformations(param1:ICustomDataOutput) : void
      {
         super.serializeAs_GameRolePlayGroupMonsterInformations(param1);
         if(this.nbWaves < 0)
         {
            throw new Error("Forbidden value (" + this.nbWaves + ") on element nbWaves.");
         }
         else
         {
            param1.writeByte(this.nbWaves);
            param1.writeShort(this.alternatives.length);
            var _loc2_:uint = 0;
            while(_loc2_ < this.alternatives.length)
            {
               param1.writeShort((this.alternatives[_loc2_] as GroupMonsterStaticInformations).getTypeId());
               (this.alternatives[_loc2_] as GroupMonsterStaticInformations).serialize(param1);
               _loc2_++;
            }
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayGroupMonsterWaveInformations(param1);
      }
      
      public function deserializeAs_GameRolePlayGroupMonsterWaveInformations(param1:ICustomDataInput) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:GroupMonsterStaticInformations = null;
         super.deserialize(param1);
         this.nbWaves = param1.readByte();
         if(this.nbWaves < 0)
         {
            throw new Error("Forbidden value (" + this.nbWaves + ") on element of GameRolePlayGroupMonsterWaveInformations.nbWaves.");
         }
         else
         {
            var _loc2_:uint = param1.readUnsignedShort();
            var _loc3_:uint = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = param1.readUnsignedShort();
               _loc5_ = ProtocolTypeManager.getInstance(GroupMonsterStaticInformations,_loc4_);
               _loc5_.deserialize(param1);
               this.alternatives.push(_loc5_);
               _loc3_++;
            }
            return;
         }
      }
   }
}
