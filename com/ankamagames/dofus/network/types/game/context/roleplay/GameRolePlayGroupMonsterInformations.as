package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import flash.utils.IDataOutput;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class GameRolePlayGroupMonsterInformations extends GameRolePlayActorInformations implements INetworkType
   {
      
      public function GameRolePlayGroupMonsterInformations() {
         this.staticInfos = new GroupMonsterStaticInformations();
         super();
      }
      
      public static const protocolId:uint = 160;
      
      public var staticInfos:GroupMonsterStaticInformations;
      
      public var ageBonus:int = 0;
      
      public var lootShare:int = 0;
      
      public var alignmentSide:int = 0;
      
      public var keyRingBonus:Boolean = false;
      
      public var hasHardcoreDrop:Boolean = false;
      
      public var hasAVARewardToken:Boolean = false;
      
      override public function getTypeId() : uint {
         return 160;
      }
      
      public function initGameRolePlayGroupMonsterInformations(param1:int=0, param2:EntityLook=null, param3:EntityDispositionInformations=null, param4:GroupMonsterStaticInformations=null, param5:int=0, param6:int=0, param7:int=0, param8:Boolean=false, param9:Boolean=false, param10:Boolean=false) : GameRolePlayGroupMonsterInformations {
         super.initGameRolePlayActorInformations(param1,param2,param3);
         this.staticInfos = param4;
         this.ageBonus = param5;
         this.lootShare = param6;
         this.alignmentSide = param7;
         this.keyRingBonus = param8;
         this.hasHardcoreDrop = param9;
         this.hasAVARewardToken = param10;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.staticInfos = new GroupMonsterStaticInformations();
         this.lootShare = 0;
         this.alignmentSide = 0;
         this.keyRingBonus = false;
         this.hasHardcoreDrop = false;
         this.hasAVARewardToken = false;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameRolePlayGroupMonsterInformations(param1);
      }
      
      public function serializeAs_GameRolePlayGroupMonsterInformations(param1:IDataOutput) : void {
         super.serializeAs_GameRolePlayActorInformations(param1);
         var _loc2_:uint = 0;
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,0,this.keyRingBonus);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,1,this.hasHardcoreDrop);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,2,this.hasAVARewardToken);
         param1.writeByte(_loc2_);
         param1.writeShort(this.staticInfos.getTypeId());
         this.staticInfos.serialize(param1);
         if(this.ageBonus < -1 || this.ageBonus > 1000)
         {
            throw new Error("Forbidden value (" + this.ageBonus + ") on element ageBonus.");
         }
         else
         {
            param1.writeShort(this.ageBonus);
            if(this.lootShare < -1 || this.lootShare > 8)
            {
               throw new Error("Forbidden value (" + this.lootShare + ") on element lootShare.");
            }
            else
            {
               param1.writeByte(this.lootShare);
               param1.writeByte(this.alignmentSide);
               return;
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameRolePlayGroupMonsterInformations(param1);
      }
      
      public function deserializeAs_GameRolePlayGroupMonsterInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         var _loc2_:uint = param1.readByte();
         this.keyRingBonus = BooleanByteWrapper.getFlag(_loc2_,0);
         this.hasHardcoreDrop = BooleanByteWrapper.getFlag(_loc2_,1);
         this.hasAVARewardToken = BooleanByteWrapper.getFlag(_loc2_,2);
         var _loc3_:uint = param1.readUnsignedShort();
         this.staticInfos = ProtocolTypeManager.getInstance(GroupMonsterStaticInformations,_loc3_);
         this.staticInfos.deserialize(param1);
         this.ageBonus = param1.readShort();
         if(this.ageBonus < -1 || this.ageBonus > 1000)
         {
            throw new Error("Forbidden value (" + this.ageBonus + ") on element of GameRolePlayGroupMonsterInformations.ageBonus.");
         }
         else
         {
            this.lootShare = param1.readByte();
            if(this.lootShare < -1 || this.lootShare > 8)
            {
               throw new Error("Forbidden value (" + this.lootShare + ") on element of GameRolePlayGroupMonsterInformations.lootShare.");
            }
            else
            {
               this.alignmentSide = param1.readByte();
               return;
            }
         }
      }
   }
}
