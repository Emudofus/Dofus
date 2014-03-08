package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GameRolePlayNpcInformations extends GameRolePlayActorInformations implements INetworkType
   {
      
      public function GameRolePlayNpcInformations() {
         super();
      }
      
      public static const protocolId:uint = 156;
      
      public var npcId:uint = 0;
      
      public var sex:Boolean = false;
      
      public var specialArtworkId:uint = 0;
      
      override public function getTypeId() : uint {
         return 156;
      }
      
      public function initGameRolePlayNpcInformations(param1:int=0, param2:EntityLook=null, param3:EntityDispositionInformations=null, param4:uint=0, param5:Boolean=false, param6:uint=0) : GameRolePlayNpcInformations {
         super.initGameRolePlayActorInformations(param1,param2,param3);
         this.npcId = param4;
         this.sex = param5;
         this.specialArtworkId = param6;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.npcId = 0;
         this.sex = false;
         this.specialArtworkId = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameRolePlayNpcInformations(param1);
      }
      
      public function serializeAs_GameRolePlayNpcInformations(param1:IDataOutput) : void {
         super.serializeAs_GameRolePlayActorInformations(param1);
         if(this.npcId < 0)
         {
            throw new Error("Forbidden value (" + this.npcId + ") on element npcId.");
         }
         else
         {
            param1.writeShort(this.npcId);
            param1.writeBoolean(this.sex);
            if(this.specialArtworkId < 0)
            {
               throw new Error("Forbidden value (" + this.specialArtworkId + ") on element specialArtworkId.");
            }
            else
            {
               param1.writeShort(this.specialArtworkId);
               return;
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameRolePlayNpcInformations(param1);
      }
      
      public function deserializeAs_GameRolePlayNpcInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.npcId = param1.readShort();
         if(this.npcId < 0)
         {
            throw new Error("Forbidden value (" + this.npcId + ") on element of GameRolePlayNpcInformations.npcId.");
         }
         else
         {
            this.sex = param1.readBoolean();
            this.specialArtworkId = param1.readShort();
            if(this.specialArtworkId < 0)
            {
               throw new Error("Forbidden value (" + this.specialArtworkId + ") on element of GameRolePlayNpcInformations.specialArtworkId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
