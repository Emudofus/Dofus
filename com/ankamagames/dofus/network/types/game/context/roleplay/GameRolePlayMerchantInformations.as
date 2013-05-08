package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;


   public class GameRolePlayMerchantInformations extends GameRolePlayNamedActorInformations implements INetworkType
   {
         

      public function GameRolePlayMerchantInformations() {
         super();
      }

      public static const protocolId:uint = 129;

      public var sellType:uint = 0;

      override public function getTypeId() : uint {
         return 129;
      }

      public function initGameRolePlayMerchantInformations(contextualId:int=0, look:EntityLook=null, disposition:EntityDispositionInformations=null, name:String="", sellType:uint=0) : GameRolePlayMerchantInformations {
         super.initGameRolePlayNamedActorInformations(contextualId,look,disposition,name);
         this.sellType=sellType;
         return this;
      }

      override public function reset() : void {
         super.reset();
         this.sellType=0;
      }

      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameRolePlayMerchantInformations(output);
      }

      public function serializeAs_GameRolePlayMerchantInformations(output:IDataOutput) : void {
         super.serializeAs_GameRolePlayNamedActorInformations(output);
         if(this.sellType<0)
         {
            throw new Error("Forbidden value ("+this.sellType+") on element sellType.");
         }
         else
         {
            output.writeInt(this.sellType);
            return;
         }
      }

      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameRolePlayMerchantInformations(input);
      }

      public function deserializeAs_GameRolePlayMerchantInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.sellType=input.readInt();
         if(this.sellType<0)
         {
            throw new Error("Forbidden value ("+this.sellType+") on element of GameRolePlayMerchantInformations.sellType.");
         }
         else
         {
            return;
         }
      }
   }

}