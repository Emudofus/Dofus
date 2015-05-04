package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class GameRolePlayMerchantInformations extends GameRolePlayNamedActorInformations implements INetworkType
   {
      
      public function GameRolePlayMerchantInformations()
      {
         this.options = new Vector.<HumanOption>();
         super();
      }
      
      public static const protocolId:uint = 129;
      
      public var sellType:uint = 0;
      
      public var options:Vector.<HumanOption>;
      
      override public function getTypeId() : uint
      {
         return 129;
      }
      
      public function initGameRolePlayMerchantInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:String = "", param5:uint = 0, param6:Vector.<HumanOption> = null) : GameRolePlayMerchantInformations
      {
         super.initGameRolePlayNamedActorInformations(param1,param2,param3,param4);
         this.sellType = param5;
         this.options = param6;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.sellType = 0;
         this.options = new Vector.<HumanOption>();
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_GameRolePlayMerchantInformations(param1);
      }
      
      public function serializeAs_GameRolePlayMerchantInformations(param1:ICustomDataOutput) : void
      {
         super.serializeAs_GameRolePlayNamedActorInformations(param1);
         if(this.sellType < 0)
         {
            throw new Error("Forbidden value (" + this.sellType + ") on element sellType.");
         }
         else
         {
            param1.writeByte(this.sellType);
            param1.writeShort(this.options.length);
            var _loc2_:uint = 0;
            while(_loc2_ < this.options.length)
            {
               param1.writeShort((this.options[_loc2_] as HumanOption).getTypeId());
               (this.options[_loc2_] as HumanOption).serialize(param1);
               _loc2_++;
            }
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayMerchantInformations(param1);
      }
      
      public function deserializeAs_GameRolePlayMerchantInformations(param1:ICustomDataInput) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:HumanOption = null;
         super.deserialize(param1);
         this.sellType = param1.readByte();
         if(this.sellType < 0)
         {
            throw new Error("Forbidden value (" + this.sellType + ") on element of GameRolePlayMerchantInformations.sellType.");
         }
         else
         {
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
            return;
         }
      }
   }
}
